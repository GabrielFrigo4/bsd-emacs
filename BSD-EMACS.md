# O Manifesto BSD Emacs: A Forja de Uma Nova Máquina

> _"Nós não buscamos reescrever a história, mas sim construir o próximo capítulo. Onde o passado nos deu a fundação para a liberdade absoluta do texto, o futuro exige a fundação para a fluidez absoluta da máquina."_

Há mais de quatro décadas, o GNU Emacs reina absoluto não apenas como um editor de texto, mas como um paradigma. Ele é a _Lisp Machine_ sobrevivente, um ecossistema estelar que engloba a genialidade do `Magit`, a organização onipresente do `Org-mode` e a flexibilidade do `Eshell`. O GNU Emacs é o avô sábio, estável, uma montanha inabalável forjada nos terminais de texto da década de 80. Ele é um monumento ao software livre e à retrocompatibilidade.

No entanto, a gravidade de 40 anos de história cria âncoras. A fusão inseparável entre o seu motor em C e o seu ambiente Lisp tornou o avanço gráfico e a concorrência assíncrona tarefas hercúleas, senão impossíveis, sem quebrar o legado.

É aqui que nasce o **BSD Emacs**.

O BSD Emacs não é um _fork_. Não é uma tentativa de assassinar o rei ou de substituir o GNU Emacs. Ele é o neto ávido, agitado e construído para os anseios do hardware moderno. Ele propõe um mundo onde ambos coexistem lado a lado: o GNU Emacs para a profundidade infinita do legado de texto, e o BSD Emacs para a vanguarda do desempenho gráfico e arquitetural.

Esta é a nossa declaração de princípios.

---

## I. A Filosofia das Três Coroas (O Legado BSD)

O nome "BSD Emacs" não é um mero acidente estético; é uma declaração direta de como o software deve ser estruturado. Assim como o ecossistema BSD divergiu do caótico e fragmentado mundo Linux ao tratar o sistema como um _todo coeso_, o BSD Emacs herda a alma de três gigantes:

### 1. A Elegância e Coesão do FreeBSD

No ecossistema GNU/Linux, o kernel é uma coisa e o _userland_ é um Frankenstein de pacotes agrupados por distribuições. No **FreeBSD**, o Kernel e o Userland são desenvolvidos juntos, como um único sistema integrado, otimizado e elegante.
O BSD Emacs adota essa premissa: entregamos um _Kernel_ robusto e um _Userland_ perfeitamente orquestrado para falar com ele. Tudo funciona direto da caixa, mas a separação é cristalina. Você pode apagar todo o Userland e reconstruí-lo sem nunca precisar recompilar o Kernel.

### 2. A Correção e Segurança do OpenBSD

O **OpenBSD** é mundialmente reverenciado por sua segurança impiedosa, código auditado e ausência de gambiarras.
O BSD Emacs reflete isso ao escolher o **Rust** para o seu Kernel. Nós abolimos as falhas de segmentação (_segfaults_) e o gerenciamento de memória caótico das antigas bases em C. Existe uma fronteira estrita e imutável (FFI) entre o Kernel de baixo nível e o ambiente de script. O código é correto por padrão, assíncrono por design e blindado contra as amarras do estado global bloqueante.

### 3. A Portabilidade e Abstração do NetBSD

O lema do **NetBSD** é _"Of course it runs NetBSD"_, graças à sua arquitetura incrivelmente limpa e agnóstica de hardware.
O núcleo do BSD Emacs não tenta "monopolizar" a tela. Ele fornece abstrações limpas sobre Wayland, Vulkan e OpenGL. A interface gráfica não está embutida no motor; o Kernel apenas gerencia a janela e passa a tela em branco para o Userland desenhar o que quiser, onde quiser.

---

## II. A Arquitetura: Kernel e Userland

Para atingir a fluidez de uma _Game Engine_ e a flexibilidade de um Sistema Operacional, o BSD Emacs divide o mundo em dois hemisférios absolutos:

### O Kernel (Rust): O Motor Implacável

Escrito do zero em Rust, o Kernel não sabe o que é um atalho de teclado, não sabe o que é um tema de cores e não sabe como desenhar uma aba. Ele é o puro músculo assíncrono conectado diretamente ao metal.

- **Paralelismo Real:** Gerencia a GPU, eventos gráficos e I/O de arquivos de forma puramente assíncrona, eliminando travamentos por completo.
- **A Ponte Sensorial:** Traz embutido, em velocidade nativa, suporte aos protocolos modernos: _Tree-sitter_ (para AST instantâneo), _LSP_ e _DAP_, servindo os dados mastigados para a camada superior.
- **Gestor de Estados:** O Kernel levanta o ambiente Lua, gerencia as _threads_ isoladas (L-States) e atua como o maestro, garantindo que a renderização nunca, em hipótese alguma, seja bloqueada por uma busca de texto pesada.
- **A Abstração Universal (SDL3):** Em vez de lutar contra as idiossincrasias de cada sistema operacional (X11, Wayland, Windows, macOS), o Kernel adota o **SDL3** e suas extensões como camada agnóstica de hardware. É através dele que gerenciamos janelas, contextos gráficos e o ciclo de vida dos eventos com portabilidade absoluta.
- **Aceleração Cruda (Vulkan):** O BSD Emacs não redesenha buffers de texto; ele renderiza quadros como uma Game Engine. Utilizando a API **Vulkan** diretamente (ou via abstrações nativas de alta performance como `wgpu`), o motor entrega taxas de atualização estáveis de 60/144Hz+, aplicando efeitos visuais, sombreamentos e transformações geométricas sem esforço.
- **O Desafio dos Glifos (A Arte do Texto na GPU):** Renderizar texto com nitidez cirúrgica diretamente na GPU é um desafio matemático implacável. O Kernel resolve isso através de pipeline assíncrono de rasterização vetorial e geração de atlas de fontes texturizadas, garantindo latência zero, ligaturas perfeitas e clareza em qualquer resolução.
- **Simbiose com o Hardware:** O Kernel quebra a barreira invisível que isolava os editores tradicionais do mundo físico. Webcams, microfones, aceleração gráfica e periféricos de hardware são acessados nativamente pelo motor Rust, expondo esses fluxos de dados de forma segura para que o Userland possa utilizá-los sem depender de daemons externos ou IPC lento.

### O Userland (Lua): A Alma Autoprogramável

Onde o GNU Emacs respira Elisp, o BSD Emacs respira **Lua** (otimizado e expandido para se tornar uma linguagem funcional moderna, com suporte nativo a `map`, `reduce` e concorrência). O Lua dita todas as regras.

- **Liberdade de Superfície:** O Lua diz ao Kernel como renderizar _buffers_, dividir janelas no mesmo frame (_splits_ perfeitos), desenhar _widgets_ flutuantes e renderizar sombras. Tudo usando aceleração direta na GPU.

### A Escolha da Alma: Instalação e Variantes do Userland

A extrema modularidade entre Kernel (repositório independente) e Userland permite que a fundação assuma diferentes formas logo no momento da instalação. O instalador exigirá que você escolha qual alma habitará o motor:

- **BSD Emacs (Completo):** A experiência rica, com "baterias inclusas", trazendo de fábrica bibliotecas e _widgets_ para um ambiente de desenvolvimento robusto.
- **BSD Emacs Base:** O Userland minimalista. Apenas a fundação estritamente necessária para ter um funcionamento padrão, perfeito para puristas que desejam construir seu ecossistema do zero.
- **Fork / Customizado:** A verdadeira liberdade. Se você bifurcou o nosso repositório ou criou uma UI totalmente nova, basta inserir o link do seu repositório Git durante a instalação, e o Kernel fará o _boot_ diretamente na sua visão pessoal do editor.

### A Hierarquia FreeBSD: O Mundo Sob a Raiz (`/`)

O diretório de configurações (`~/.config/bsd-emacs/`) não é apenas uma pasta de _dotfiles_ para guardar variáveis desorganizadas. Ele é uma Árvore de Sistema Operacional completa e estrita. Nós adotamos a filosofia de separação de domínios do FreeBSD: o sistema base é imutável e sagrado; as suas customizações vivem no seu próprio feudo. Tudo tem seu lugar, e tudo obedece a uma lógica implacável:

- **`/etc` (O Padrão Imutável):** Aqui residem as configurações de fábrica do _Userland_ oficial. As regras de como o editor deve se comportar nativamente. O usuário pode ler para aprender, mas nunca precisa tocar.
- **`/bin` e `/lib` (O Userland Base):** A fundação escrita em Lua. Em `/bin` vivem os comandos primários do editor (como abrir janelas, buscar arquivos), e em `/lib` repousam as bibliotecas nativas de renderização de UI, _parsing_ e utilitários. Este é o ambiente estéril, limpo e testado que garante que o BSD Emacs sempre inicialize perfeitamente.
- **`/usr/local` (O Seu Feudo Absoluto):** A verdadeira alma do usuário. Assim como no FreeBSD, tudo o que não vem de fábrica, vive aqui. Seus pacotes da comunidade, seus temas, suas funções personalizadas e o seu sagrado `init.lua` (em `/usr/local/etc`). Se o seu editor quebrar por causa de um script ruim, você simplesmente apaga o `/usr/local` e o BSD Emacs renasce das cinzas na mesma hora, intacto pelo sistema base.
- **`/opt` (Os Monólitos):** O asilo para subsistemas gigantes e isolados. Quer rodar um binário de navegador WebKit inteiro dentro de uma aba? Quer injetar uma máquina virtual Lisp clássica apenas para rodar o Magit antigo? Eles vão para o `/opt`, onde seus arquivos não poluem as bibliotecas limpas do resto do editor.
- **`/sys` (A Ponte de Baixo Nível):** O ápice da extensibilidade irrestrita. O Lua é veloz, mas se você precisar calcular o _hash_ criptográfico de 50 mil arquivos ou rodar inferência de IA local, você escreve em Rust, C ou Zig, compila uma `.so` ou `.dll` e coloca no `/sys`. O Kernel conecta isso ao Lua instantaneamente via FFI com zero de latência.
- **`/dev` (A Ilusão Perfeita):** No UNIX, tudo é um arquivo. No BSD Emacs também. O `/dev` abstrai entidades vivas do editor para que scripts possam interagir com elas através de I/O básico. Escreva no `/dev/log` para depurar. Leia o `/dev/buffers/main.rs` para capturar o texto na tela em tempo real. Destrua lixo jogando no eterno `/dev/null`. Uma abstração genial que torna o _scripting_ universal.
- **`/mnt` (A Ruptura de Fronteiras):** Onde o editor transcende a sua máquina local. Esqueça protocolos confusos para acessar arquivos remotos. Em `/mnt`, você monta conexões SSH em segundo plano, entra dentro de contêineres Docker, ou "monta" um arquivo `.zip` e navega pelos arquivos dele nativamente, como se fossem apenas mais pastas no seu disco.
- **`/var` (A Memória Muscular):** Os dados voláteis. Onde o Kernel guarda o cache massivo do _Tree-sitter_, os logs assíncronos do LSP, e as árvores de _undo_ infinitas (para que você possa desfazer uma edição que ocorreu há 3 meses atrás). O BSD Emacs nunca esquece, e o `/var` garante que a RAM seja aliviada quando necessário.

---

## III. A Doutrina de Contenção: Ambientes e Jails Nativos

Um editor moderno frequentemente lida com ecossistemas conflitantes. Para resolver isso, o BSD Emacs não confia apenas em variáveis de buffer; ele implementa os conceitos de isolamento do FreeBSD diretamente no seu núcleo:

- **Environments (O Escopo Lógico):** A camada mais leve de contenção. Dependendo do projeto, você pode instanciar um "Environment" que isola configurações, plugins específicos de uma linguagem e variáveis de ambiente, sem precisar de uma separação severa de processos.
- **Jails (A Prisão Hermética):** O isolamento absoluto, implementado de forma nativa pelo Kernel Rust. Uma Jail permite rodar o BSD Emacs "dentro" do BSD Emacs. Se você possui um projeto com dependências radicalmente distintas, você pode levantar uma Jail. Para quem vê de fora, ela pode se apresentar como apenas mais uma _window_, um _frame_ separado, ou um processo inteiramente apartado (dependendo de como foi invocada). Para o código rodando lá dentro, ela enxerga a si mesma como um BSD Emacs "Host" isolado. Mais fascinante ainda: você pode construir uma Jail usando o Userland Base, mesmo que o seu Host esteja rodando o Userland Completo.

---

## IV. Modularidade Extrema: Muito Além de um Editor

O design desacoplado entre o _Kernel Rust_ e o _Userland Lua_ não é apenas para organização de código; é uma plataforma de desenvolvimento de interfaces e aplicações de alta performance.

Imagine o seguinte: você deseja criar uma **Game Engine** ou uma aplicação gráfica complexa. Você não precisa começar do zero. O Kernel do BSD Emacs já sabe como conversar com a GPU, gerenciar Wayland/X11 e processar I/O assíncrono perfeitamente. Você pode simplesmente criar um _fork_ do repositório do **BSD Emacs Base**, apagar os conceitos de texto e usar o poder do Lua para desenhar o seu próprio sistema. O nosso motor se torna o seu motor. A utilidade desse Userland modular brilha intensamente na criação de ferramentas customizadas tanto para a máquina principal quanto para instâncias de Jails específicas.

---

## V. O Pacto de Coexistência

Nós amamos o GNU Emacs. Usaremos o GNU Emacs para acessar nossos e-mails, gerenciar nossas agendas no _Org-mode_ e calcular o caos no _Calc_. Ele é o testamento da genialidade humana em software de texto.

Mas quando precisarmos de um editor que:

- Abra milhares de arquivos instantaneamente sem engasgar a interface;
- Renderize gráficos vetoriais complexos, _shaders_ e UIs a 60/144 FPS nativamente através da arquitetura Vulkan e SDL3;
- Trate o paralelismo e o acesso de baixo nível ao hardware como cidadãos de primeira classe;
- Gerencie Jails de projetos e seja infinitamente mutável do nível de texto até uma Game Engine;
- E forneça um ambiente puramente _hackeável_ usando uma linguagem veloz como Lua...

Nós abriremos o **BSD Emacs**.

Nós não carregamos a obrigação da retrocompatibilidade com a década de 1980. Nós carregamos a missão de construir a ferramenta do presente, para o hardware do presente, mantendo a filosofia libertadora de que o usuário, e somente o usuário, é o dono absoluto de cada pixel renderizado na sua tela.

O terminal nos deu a palavra. A GPU nos dará o mundo.
Bem-vindo ao BSD Emacs.
