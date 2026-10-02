# O Manifesto BSD Emacs: A Forja de Uma Nova Máquina

[![License: BSD-3-Clause](https://img.shields.io/badge/License-BSD_3--Clause-blue.svg?logo=open-source-initiative&logoColor=white)](LICENSE)
[![C Standard: C23](https://img.shields.io/badge/C_Standard-C23-blue.svg?logo=c&logoColor=white)](README.md)
[![Graphics: SDL3 + SDL_GPU](https://img.shields.io/badge/Graphics-SDL3_%2B_SDL__GPU-purple.svg?logo=vulkan&logoColor=white)](README.md)
[![Audio: SDL_Sound](https://img.shields.io/badge/Audio-SDL__Sound-darkgreen.svg)](README.md)
[![Scripting: Lua 5.5+](https://img.shields.io/badge/Userland-Lua_5.5%2B-blue.svg?logo=lua&logoColor=white)](README.md)
[![POSIX: 2024](https://img.shields.io/badge/POSIX-2024-purple.svg?logo=freebsd&logoColor=white)](README.md)

> _"Nós não buscamos reescrever a história, mas sim construir o próximo capítulo. Onde o passado nos deu a fundação para a liberdade absoluta do texto, o futuro exige a fundação para a fluidez absoluta da máquina."_

Há mais de quatro décadas, o GNU Emacs reina não apenas como um editor de texto, mas como um paradigma: a _Lisp Machine_ sobrevivente, com o ecossistema estelar do `Magit`, a organização do `Org-mode` e a flexibilidade do `Eshell`. Ele é a montanha inabalável forjada nos terminais de texto da década de 80.

No entanto, 40 anos de história criam âncoras. A fusão inseparável entre seu motor em C arcaico e seu ambiente Lisp torna a aceleração gráfica moderna e o paralelismo tarefas hercúleas sem quebrar o legado.

É aqui que nasce o **BSD Emacs**.

O BSD Emacs não é um fork. Não é uma tentativa de assassinar o rei ou substituir o GNU Emacs. Ele é a ferramenta hacker de vanguarda gráfica e computação acelerada:

- **GNU Emacs:** Para a profundidade infinita do legado de texto e produtividade estática.
- **BSD Emacs:** Para o dinamismo da GPU, GPGPU, desenho em tempo real, renderização de vídeo e simulações gráficas nativas na janela do editor.

---

## A Filosofia das Três Coroas (O Legado BSD)

### 1. A Coesão do FreeBSD

No **FreeBSD**, o Kernel e o Userland são desenvolvidos juntos, como um único sistema integrado e elegante.
O BSD Emacs adota essa premissa: entregamos um **Kernel C23** enxuto e um **Userland Lua 5.5+** orquestrado para falar com ele. Tudo funciona direto da caixa. O Userland pode ser inteiramente substituído sem necessidade de recompilar o núcleo.

### 2. A Correção e Simplicidade do OpenBSD

O **OpenBSD** é reverenciado por sua segurança impiedosa, código auditado e ausência de gambiarras.
O BSD Emacs reflete isso adotando **C23 estrito** (`-std=c23`) com imunidade a overflow (`<stdckdint.h>`), ponteiros tipados (`nullptr`), `[[nodiscard]]` e sanitizers contínuos. O código é enxuto, transparente e livre de complexidade acidental.

### 3. A Portabilidade do NetBSD

O lema do **NetBSD** é _"Of course it runs NetBSD"_.
O núcleo do BSD Emacs não tenta monopolizar o display server. Ele delega o gerenciamento agnóstico de janelas, eventos e GPU à **SDL3** e **SDL_GPU**, operando com paridade idêntica sobre Wayland nativo (Linux/FreeBSD), Windows e macOS.

---

## A Arquitetura: Kernel C23 & Userland Lua

```text
+--------------------------------------------------------------+
|                    USERLAND LUA 5.5+                         |
|   Customização • Buffers • Layouts • Shaders • Scripts       |
+--------------------------------------------------------------+
                               | FFI / C API Direta
+--------------------------------------------------------------+
|                      KERNEL C23 ESTUDO                       |
|   Loop de Eventos • Pipeline SDL_GPU • SDL_Sound • POSIX     |
+--------------------------------------------------------------+
                               | Drivers & Hardware
+--------------------------------------------------------------+
|               GPU (Vulkan / DX12 / Metal) • SO HOST          |
+--------------------------------------------------------------+
```

### O Kernel (C23): A Máquina Perto do Metal

Escrito em C23 puro, o Kernel não impõe opiniões sobre temas ou atalhos. Ele é o músculo que conversa diretamente com o hardware:

- **Abstração Universal (SDL3):** Gerencia janelas, display e ciclo de vida de eventos sem gambiarras de X11/Wayland.
- **Aceleração Direta (SDL_GPU):** Não redesenhamos apenas texto estático; o BSD Emacs renderiza quadros a 60/144Hz+, viabilizando compute shaders (GPGPU), efeitos visuais e transformações geométricas.
- **Áudio Nativo (SDL_Sound):** Capacidade de reprodução sonora integrada sem dependência de daemons externos.
- **Display Hacker:** Permite usar a janela do BSD Emacs como display para rodar vídeos, simulações ou renderizadores gráficos customizados sem hackear o sistema operacional.

### O Userland (Lua 5.5+): A Alma Hacker Autoprogramável

Onde o GNU Emacs respira Elisp, o BSD Emacs respira **Lua 5.5+**:

- **Liberdade de Superfície:** O Lua comanda o Kernel sobre como renderizar buffers, particionar janelas (splits), desenhar widgets flutuantes e despachar comandos para a GPU.
- **Velocidade de Execução:** Scripts Lua compilados e executados em microssegundos com uso mínimo de memória.

---

## A Hierarquia FreeBSD: O Mundo Sob a Raiz

O diretório de configurações (`~/.config/bsd-emacs/`) reproduz a estrutura lógica de um sistema operacional FreeBSD:

- **`/etc`:** Configurações de fábrica do Userland oficial.
- **`/bin` e `/lib`:** Comandos primários e bibliotecas de UI em Lua.
- **`/usr/local`:** O feudo do usuário (seus pacotes, scripts e seu `init.lua`).
- **`/dev`:** Dispositivos abstratos (`/dev/log`, `/dev/buffers`, `/dev/null`).
- **`/var`:** Caches voláteis e históricos de undo.

---

## O Pacto de Coexistência

Nós amamos o GNU Emacs. Usamos o GNU Emacs para tarefas clássicas e o veneramos como patrimônio da computação.

Mas quando precisamos de uma ferramenta hacker que:

- Abra instantaneamente sem engasgos;
- Renderize gráficos vetoriais, shaders e som nativamente através de **SDL3** e **SDL_GPU**;
- Atue como uma tela dinâmica para mídia, jogos ou visualização de dados;
- E forneça um ambiente puramente mutável em **Lua 5.5+** e **C23**...

Nós abriremos o **BSD Emacs**.

O terminal nos deu a palavra. A GPU nos dará o mundo.
