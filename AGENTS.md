# 🤖 AGENTS.md — Diretrizes para Agentes de IA no BSD Emacs

Bem-vindo ao repositório **BSD Emacs** (`Personal/Systems/BSD Emacs`). Este documento é a constituição soberana e guia mandatório para agentes de Inteligência Artificial operando nesta base de código.

---

## 1. Identidade e Papel

O **BSD Emacs** é uma ferramenta hacker de display gráfico, GPGPU e computação acelerada por GPU, estruturado sob a simbiose de um Kernel C23 de alta velocidade e um Userland programável em Lua 5.5+.

- **Stack:** C23 estrito (`-std=c23`), SDL3, SDL_GPU, SDL_Sound, Lua 5.5+, POSIX.1-2024.
- **Foco:** Performance, extensibilidade hacker, renderização a 60/144Hz+, áudio nativo e tela dinâmica para mídia e computação gráfica.

---

## 2. Regras Críticas Soberanas

1. **Separação Kernel / Userland:** O Kernel C23 lida estritamente com hardware, eventos SDL3, SDL_GPU e FFI. O Userland Lua 5.5+ comanda a interface e layouts.
2. **Padrão C23 Estrito:** Código em C deve utilizar primitivas modernas do C23 (`<stdckdint.h>`, `nullptr`, `constexpr`, `[[nodiscard]]`), compilando sem warnings (`-Wall -Wextra -Wpedantic`).
3. **Invariante Hermetismo de Produção:** O binário e scripts nunca podem depender de `.agents/`. A invariante `rm -rf .agents` deve ser sempre respeitada.
4. **Invariante Out-of-the-Box:** Modos octais canônicos no Git Index (`0755` para scripts/hooks, `0644` para fontes e documentação).
5. **Zero Cruft:** Proibição terminante de código legado, bibliotecas abandonadas ou shims obsoletos.
6. **Commits Semânticos:** Mensagens padronizadas no formato `<type>(<scope>): <descrição>`.

---

## 3. Boy Scout Rule

Sempre deixe o acampamento mais limpo do que encontrou:

- [ ] Mantenha títulos de documentação com badges vetoriais limpos, sem excesso de emojis.
- [ ] Valide formatação com `make lint` e `make format`.
- [ ] Teste a compilação com `make build`.

---

## 4. Comandos de Verificação Rápidos

| Comando       | Descrição                                     |
| :------------ | :-------------------------------------------- |
| `make help`   | Exibe o menu interativo com alvos disponíveis |
| `make build`  | Compila o núcleo C23 do BSD Emacs em bin/     |
| `make run`    | Executa o ambiente sobre o Host               |
| `make format` | Formata fontes C (clang-format) e Markdown    |
| `make lint`   | Valida formatação com Prettier sem alterar    |
| `make hooks`  | Ativa os githooks locais com permissões 0755  |
| `make ci`     | Executa pipeline de validação de qualidade    |

---

## 5. Referências Obrigatórias

- [Manifesto Arquitetural](README.md)
- [Regras de Agentes](.agents/rules/principles.md)
