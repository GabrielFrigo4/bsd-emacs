---
name: bsd-emacs-architecture
description: >-
    Runbook cognitivo e manual de arquitetura para desenvolvimento do BSD Emacs.
    Use ao implementar ou estender o Kernel em C23, integração com SDL3 e SDL_GPU,
    reprodução de áudio via SDL_Sound, bindings e runtime Lua 5.5+,
    hierarquia de diretórios FreeBSD (~/.config/bsd-emacs/) e pipelines gráficos na GPU.
---

# BSD Emacs Architecture Runbook

Este runbook instrui agentes de Inteligência Artificial sobre as decisões de engenharia, ciclo de vida e organização do **BSD Emacs**, estruturado sobre a simbiose de um Kernel de alto desempenho em C23 e um Userland em Lua 5.5+.

---

## 1. O Kernel em C23 & O Loop Gráfico

O Kernel atua como a ponte entre o hardware e o script Lua:

```c
#include <SDL3/SDL.h>
#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>

int main(int argc, char *argv[]) {
    if (!SDL_Init(SDL_INIT_VIDEO | SDL_INIT_AUDIO | SDL_INIT_EVENTS)) {
        return 1;
    }

    SDL_Window *window = SDL_CreateWindow("BSD Emacs", 1280, 720, SDL_WINDOW_RESIZABLE | SDL_WINDOW_HIGH_PIXEL_DENSITY);
    if (!window) return 1;

    /* Inicialização do subsistema SDL_GPU e contexto Lua 5.5 */
    lua_State *L = luaL_newstate();
    luaL_openlibs(L);

    /* Loop de eventos principal */
    bool running = true;
    while (running) {
        SDL_Event event;
        while (SDL_PollEvent(&event)) {
            if (event.type == SDL_EVENT_QUIT) running = false;
            /* Despacho de eventos para o Userland Lua */
        }
        /* Renderização via SDL_GPU */
    }

    lua_close(L);
    SDL_DestroyWindow(window);
    SDL_Quit();
    return 0;
}
```

---

## 2. A Filosofia da Janela como "Hacker Display"

O BSD Emacs não se limita a buffers de texto monospace:

1. **Superfícies de Renderização Livre:** Um buffer pode ser configurado em Lua para receber streams de pixels, quadros de vídeo decodificados, simulações físicas ou gráficos vetoriais.
2. **Compute Shaders na GPU:** Através da API `SDL_GPU`, scripts podem despachar compute passes diretamente para a placa de vídeo.
3. **Áudio Integrado:** Utilizando `SDL_Sound`, qualquer buffer ou comando pode disparar reprodução sonora assíncrona com latência mínima.

---

## 3. Hierarquia de Diretórios (~/.config/bsd-emacs/)

A organização reproduz estritamente os domínios do FreeBSD:

- **/etc/:** Arquivos padrão fornecidos pelo editor (ex: `default-theme.lua`, `keymaps.lua`).
- **/bin/:** Comandos built-in do Userland (ex: `split-window`, `find-file`).
- **/lib/:** Bibliotecas Lua nativas de UI, renderização de fontes e layouts.
- **/usr/local/:** O feudo soberano do usuário. O script de inicialização do usuário reside exclusivamente em `~/.config/bsd-emacs/usr/local/etc/init.lua`.
- **/dev/:** Abstrações virtuais para I/O (`/dev/log` para mensagens, `/dev/null` para descarte).
- **/var/:** Caches do compilador JIT e arquivos de estado transitório.

---

## 4. Diretrizes de Qualidade & Clean Code

- **Zero Alocações no Loop de Renderização:** Buffers e texturas devem ser pré-alocados ou gerenciados via arena.
- **Tipos C23 Seguros:** Uso mandatório de `nullptr`, `[[nodiscard]]` e controle de tamanho via `<stdckdint.h>`.
- **Prettier & Clang-Format:** Todo arquivo Markdown segue o `.prettierrc` canônico e todo código C segue o `.clang-format`.
