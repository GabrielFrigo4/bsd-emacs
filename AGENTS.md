# 🤖 BSD Emacs — AI Agent Briefing

> Ferramenta hacker de display gráfico, GPGPU e computação acelerada por GPU, estruturado sob a simbiose de um Kernel C23 de alta velocidade e um Userland programável em Lua 5.5+.

---

## 🧭 Identidade e Papel

O **BSD Emacs** é uma ferramenta hacker de display gráfico, GPGPU e computação acelerada por GPU, estruturado sob a simbiose de um Kernel C23 de alta velocidade e um Userland programável em Lua 5.5+.

- **Stack Primária:** C23 estrito (`-std=c23`), SDL3, SDL_GPU, SDL_Sound, Lua 5.5+, POSIX.1-2024
- **Foco:** Performance, extensibilidade hacker, renderização a 60/144Hz+, áudio nativo e tela dinâmica para mídia e computação gráfica

---

## 📁 Estrutura Canônica de Arquivos

```text
BSD Emacs/
├── .agents/                   # Governança e runbooks locais de IA
├── AGENTS.md                  # Constituição e briefing para agentes de IA
├── BSD-EMACS.md               # Manifesto técnico e visão do hacker display
├── LICENSE                    # Licença BSD-3-Clause
├── Makefile                   # Orquestrador POSIX silencioso
├── PRINCIPLES.md              # 22 Princípios de Engenharia aplicados
├── README.md                  # Documentação arquitetural do BSD Emacs
└── TODO.md                    # Roadmap e planejamento do projeto
```

---

## ⚠️ Regras Críticas para Agentes de IA

1. **Separação Kernel / Userland:** O Kernel C23 lida estritamente com hardware, eventos SDL3, SDL_GPU e FFI. O Userland Lua 5.5+ comanda a interface e layouts.
2. **Padrão C23 Estrito:** Código em C deve utilizar primitivas modernas do C23 (`<stdckdint.h>`, `nullptr`, `constexpr`, `[[nodiscard]]`), compilando sem warnings (`-Wall -Wextra -Wpedantic`).
3. **Invariante Hermetismo de Produção:** O binário e scripts nunca podem depender de `.agents/`. A invariante `rm -rf .agents` deve ser sempre respeitada.
4. **Invariante Out-of-the-Box:** Modos octais canônicos no Git Index (`0755` para scripts/hooks, `0644` para fontes e documentação).
5. **Zero Cruft:** Proibição terminante de código legado, bibliotecas abandonadas ou shims obsoletos.
6. **Commits Semânticos:** Mensagens padronizadas no formato `<type>(<scope>): <descrição>`.

---

## 🛡️ Regra da Proatividade e Correção Contínua (Boy Scout Rule)

O agente de IA atua de forma proativa na manutenção e aplicação dos padrões canônicos deste repositório.

Ao identificar linhas ou artefatos fora dos padrões estabelecidos:

1. **Notificar concisamente** o usuário sobre o ajuste realizado.
2. **Corrigir a inconformidade**, aplicando o padrão correspondente:
    - **Comentários Narrativos:** Eliminar comentários óbvios que apenas narram código executável.
    - **Banners Estruturais:** Ajustar réguas para exatamente 64 hífens no topo ou 32 caracteres com `### ` no corpo.
    - **Portabilidade POSIX:** Substituir bashismos (`[[ ]]`, `&>`, arrays, `source`) por sintaxe estrita POSIX `/bin/sh`.
    - **Shebang Universal:** Garantir sempre `#!/usr/bin/env sh` ou `#!/usr/bin/env python3`.
    - **Sequências ANSI & Escapes:** Não use octais (`\033`, `\001`) para caracteres ou escapes. Use `[ -t 1 ] && echo -n $'\e...'` ou notação hexadecimal (`\x01`, `\x1b`). Octal é exclusivo para permissões POSIX (`chmod 0755`, `chmod 0644`, `umask`).
    - **Redirecionamento Seguro:** Envolver destinos em aspas duplas (ex: `> "/dev/null" 2>&1`).
    - **Makefiles:** Assegurar cabeçalho `.POSIX: .SILENT:`, `MAKEFLAGS += --no-print-directory -s`, alinhamento estético de variáveis e zero `@` redundante.
    - **Permissões Canônicas:** Aplicar 4 dígitos octais (`chmod 0755`, `chmod 0644`, `chmod 0700`, `chmod 0600`).
    - **Invariante Out-of-the-Box:** Garantir modos octais corretos no Git Index e auto-cura em tempo de execução sem requerer intervenção manual pós-clone.
    - **Emissão Semântica de UI:** Substituir `echo` avulsos com emojis pelas rotinas canônicas `_ui_*`.
    - **Antifragilidade & Resiliência:** Resolução ativa de caminhos em cascata, auto-cura de permissões (0600 em chaves/segredos) e validação defensiva de pré-requisitos.
    - **Curadoria Cognitiva:** Capturar decisões estruturais e regras tácitas em skills locais compactas (`.agents/skills/`), mantendo-as atualizadas e expurgando ruído obsoleto.
    - **Refatoração Sem Legado:** Expurgar aliases obsoletos, variáveis mortas e shims de compatibilidade em renomeações.
    - **Elevação Antifrágil & Shift Seguro:** Usar o bloco explícito `if [ "$(id -u)" -ne 0 ]` para resolução de `ELEVATE` (evitando término fatal sob `set -e` como root) e proteger todo comando `shift` com validação prévia de parâmetros (`[ "$#" -ge N ] && shift N`).
    - **Simetria de Documentação:** Mover regras ou invariantes universais documentadas erroneamente em sub-membros específicos para o documento de arquitetura do grupo correspondente, eliminando falsas assimetrias.

---

## 🚀 Comandos de Verificação Rápida (Quality Gates)

| Comando             | Finalidade Operacional                              |
| :------------------ | :-------------------------------------------------- |
| `make help`         | Exibe o menu interativo com alvos disponíveis       |
| `make build`        | Compila o núcleo C23 do BSD Emacs em `bin/`         |
| `make run`          | Executa o ambiente sobre o Host                     |
| `make format`       | Formata fontes C (clang-format) e Markdown Prettier |
| `make clang-format` | Formata apenas os fontes C com clang-format         |
| `make prettier`     | Formata arquivos Markdown com Prettier              |
| `make lint`         | Valida formatação com Prettier sem alterar          |
| `make hooks`        | Ativa os githooks locais com permissões `0755`      |
| `make ci`           | Executa pipeline local de validação de qualidade    |
| `make clean`        | Remove artefatos de compilação em `bin/` e `build/` |

---

## 📖 Referências Obrigatórias

Antes de qualquer modificação neste ecossistema, consulte:

- [README.md](README.md) — Documentação arquitetural do BSD Emacs
- [BSD-EMACS.md](BSD-EMACS.md) — Manifesto técnico do hacker display
- [PRINCIPLES.md](PRINCIPLES.md) — Os 22 Princípios de Engenharia Soberanos
- [TODO.md](TODO.md) — Roadmap e planejamento do projeto
- [LICENSE](LICENSE) — Licença BSD-3-Clause
- [.agents/rules/principles.md](.agents/rules/principles.md) — Regra de Princípios
- [.agents/skills/bsd-emacs-architecture/SKILL.md](.agents/skills/bsd-emacs-architecture/SKILL.md) — Runbook Arquitetural do BSD Emacs
