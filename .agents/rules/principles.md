# Regras Canônicas de Domínio & Regras Locais: BSD Emacs

> Regras de governança estrita e restrições de arquitetura para agentes de IA operando no repositório **BSD Emacs** (`Personal/Systems/BSD Emacs`).

---

## 1. Stack Tecnológica Soberana

1. **Kernel em C23:** O motor central do editor é desenvolvido estritamente em **C23** (`-std=c23`), gerenciando eventos, a camada de janelas SDL3, o pipeline gráfico de GPU e o runtime Lua.
2. **Camada Gráfica SDL_GPU:** Em vez de OpenGL clássico ou wrappers pesados, o subsistema de renderização utiliza a API moderna **SDL_GPU** (renderizando sobre Vulkan no Linux/FreeBSD, DX12 no Windows e Metal no macOS).
3. **Áudio Nativo com SDL_Sound:** Decodificação e streaming de múltiplos formatos de som sem travar a thread de display.
4. **Userland Autoprogramável em Lua 5.5+:** Toda a interface do usuário, divisão de janelas (_splits_), temas e extensões são implementados em scripts Lua através de bindings diretos e rápidos.

---

## 2. A Filosofia da Ferramenta Hacker de Display

1. **Mais Hacker Display do que SO Monolítico:** A prioridade é permitir customização extrema, GPGPU, som, desenho livre e a capacidade de usar uma janela do BSD Emacs como display para rodar vídeos, simulações ou jogos sem precisar de hacks no sistema operacional.
2. **Desacoplamento Kernel / Userland:** O Kernel nunca embute regras de estilo ou atalhos hardcoded. Ele apenas provê primitivas e superfícies aceleradas por GPU para o Userland comandar.
3. **Hierarquia de Diretórios do FreeBSD:** A árvore de configurações reproduz os domínios do FreeBSD: `/etc` (imutável), `/bin` e `/lib` (Userland base), `/usr/local` (feudo do usuário e `init.lua`), `/dev` (dispositivos de I/O), `/var` (caches voláteis).

---

## 3. Invariantes de Engenharia

1. **Invariante Hermetismo de Produção:** Nenhuma linha de código ou script de produção pode depender de `.agents/` ou skills.
2. **Invariante Out-of-the-Box:** Permissões no Git Index canônicas (`0755` para scripts/hooks, `0644` para fontes e documentação).
3. **Sem Emojis em Títulos:** A documentação técnica prioriza badges vetoriais (SVG shields) e diagramação limpa.
