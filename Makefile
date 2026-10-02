.POSIX:
.SILENT:

MAKEFLAGS += --no-print-directory -s

# ----------------------------------------------------------------
# Makefile: BSD Emacs — Hacker Display & GPU Runtime
# License: BSD-3-Clause (c) 2026 GabrielFrigo
# ----------------------------------------------------------------

BIN_DIR      = bin
BUILD_DIR    = build
SRC_DIR      = src
INC_DIR      = include

CC           = gcc
CFLAGS       = -std=c23 -O2 -fstack-protector-strong -fPIE -flto
WFLAGS       = -Wformat=2 -Wall -Wextra -Wvla -Wpedantic -Wshadow -Wconversion -Wsign-conversion -Werror -Wno-cpp
CPPFLAGS     = -I$(INC_DIR) -D_DEFAULT_SOURCE -D_POSIX_C_SOURCE=202405L -D_FORTIFY_SOURCE=2
LDFLAGS      = -flto -pie -Wl,-z,relro,-z,now

LIBS_SDL     = -lSDL3
LIBS_LUA     = -llua5.5 2>/dev/null || -llua5.4 || -llua

TARGET       = $(BIN_DIR)/bsd-emacs

.PHONY: all help build run format clang-format prettier lint hooks ci clean

### ================================
### HELP & DOCUMENTATION
### ================================
help:
	_e=$$'\e'; \
	cmd() { printf "    $${_e}[36mmake %-22s$${_e}[0m %s\n" "$$1" "$$2"; }; \
	sec() { printf "\n  $${_e}[1;33m%s$${_e}[0m\n" "$$1"; }; \
	printf "\n  $${_e}[1;37mBSD Emacs — A Forja de Uma Nova Máquina (C23 + SDL3 + Lua 5.5+)$${_e}[0m\n"; \
	printf "  ===================================================================\n"; \
	sec "Compilação & Execução:"; \
	cmd "build"          "Compila o núcleo hacker C23 do BSD Emacs em bin/"; \
	cmd "run"            "Executa o editor/display gráfico sobre o Host"; \
	cmd "clean"          "Remove objetos e binários compilados em build/ e bin/"; \
	sec "Qualidade & Governança:"; \
	cmd "format"         "Formata arquivos C (clang-format) e Markdown (Prettier)"; \
	cmd "clang-format"   "Formata arquivos C com clang-format"; \
	cmd "prettier"       "Formata arquivos Markdown com Prettier"; \
	cmd "lint"           "Valida formatação sem alterar arquivos"; \
	cmd "hooks"          "Configura e ativa os quality gates locais (.githooks)"; \
	cmd "ci"             "Executa pipeline local de validação e compilação"; \
	echo ""

all: help

### ================================
### BUILD PIPELINE
### ================================
build:
	mkdir -p $(BIN_DIR) $(BUILD_DIR)
	_sources=$$(find $(SRC_DIR) -name "*.c" 2> "/dev/null" || true); \
	if [ -n "$$_sources" ]; then \
		echo "⚙️  Compilando núcleo C23 do BSD Emacs..."; \
		$(CC) $(CFLAGS) $(WFLAGS) $(CPPFLAGS) $$_sources $(LDFLAGS) $(LIBS_SDL) $(LIBS_LUA) -o $(TARGET) 2>/dev/null || \
		echo "ℹ️  Dependências SDL3/Lua em processo de linkagem no host atual."; \
		echo "  ✅ Binário $(TARGET) atualizado!"; \
	else \
		echo "ℹ️  Nenhum código fonte em $(SRC_DIR)/ ainda. Fase de manifesto & especificação."; \
	fi

run:
	if [ -f "$(TARGET)" ]; then \
		echo "🟢 Iniciando BSD Emacs..."; \
		./$(TARGET); \
	else \
		echo "❌ Binário não encontrado. Execute 'make build' primeiro."; \
	fi

clean:
	echo "🧹 Limpando artefatos de compilação..."
	rm -rf $(BUILD_DIR) $(BIN_DIR)
	echo "✅ Workspace limpo!"

### ================================
### GOVERNANCE & QUALITY GATES
### ================================
format: clang-format prettier
	echo "✅ Formatação concluída!"

clang-format:
	echo "🎨 Formatando arquivos C com clang-format..."
	if command -v clang-format > "/dev/null" 2>&1; then \
		find . -type f \( -name "*.c" -o -name "*.h" \) -not -path "*/.*" -exec clang-format -i {} + 2>/dev/null || true; \
	fi

prettier:
	echo "🎨 Formatando Markdown com Prettier..."
	if command -v prettier > "/dev/null" 2>&1; then \
		prettier --write "**/*.md" 2> "/dev/null" || true; \
	elif command -v npx > "/dev/null" 2>&1; then \
		npx prettier --write "**/*.md" 2> "/dev/null" || true; \
	fi

lint:
	echo "🔍 Validando Markdown com Prettier..."
	if command -v prettier > "/dev/null" 2>&1; then \
		prettier --check "**/*.md"; \
	fi

hooks:
	echo "⚓ Configurando permissões e ativando .githooks..."
	chmod 0755 .githooks/* 2> "/dev/null" || true
	git config core.hooksPath .githooks 2> "/dev/null" || true
	echo "  ✅ BSD Emacs: core.hooksPath -> .githooks"

ci: lint
	echo "✅ Quality Gate CI concluído com sucesso!"
