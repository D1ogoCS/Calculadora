# Calculadora
## Desenvolver uma calculadora com interface gráfica e com os cálculos as serem executados num servidor remoto

No âmbito da disciplina de Sistemas Distribuídos, foi proposto a realização de um trabalho em linguagem de programação java de uma calculadora RMI com interface gráfica. O RMI (Invocação de Método Remoto) é uma interface de programação que permite a execução de chamadas remotas desenvolvidas em Java. Segue o modelo Cliente-Servidor, no qual o servidor é um “host” que pode executar um ou mais serviços partilhados com os clientes. O cliente apenas solicita funções do servidor. 
O servidor cria objetos remotos e disponibiliza referências a esses objetos. O cliente obtém referências a esses objetos remotos do servidor e invoca métodos nesses objetos.

### Objetivos:
- Criar uma calculadora em que os cálculos da mesma sejam realizados num servidor remoto
- Deve-se utilizar para a comunicação entre Cliente-Servidor pelo menos uma das tecnologias abordadas (RMI / TCP / UDP)

### Ferramentas utilizadas:
- Apache NetBeans 19
- Visual Studio Code

### Tecnologias utilizadas:
- Linguagem Java
- Java RMI

### Resultados:
#### 1. Inicio
Ao iniciar a aplicação da Calculadora, é exibida uma janela onde é necessário introduzir um IP (Internet Protocol) de um servidor RMI existente.

![Janela inicial](https://github.com/D1ogoCS/Calculadora/blob/main/imagens/janelaInicial.png)

*Janela inicial*

A caixa de texto já estará preenchida com “localhost”. Se o servidor RMI que estiver a utilizar esteja no próprio computador, não será necessário fazer qualquer alteração. No entanto, se o servidor estiver em outro computador, será necessário introduzir o IP correspondente a esse computador e clicar no botão “Confirmar”.

Se o IP do servidor RMI introduzido não existir ou estiver errado, vai obter um erro de ligação ao servidor.

![Mensagem de erro](https://github.com/D1ogoCS/Calculadora/blob/main/imagens/erroServidor.png)

*Mensagem de erro*

Para resolver este erro existem tem duas opções: 

1. Verificar se o servidor RMI está a ser executado;
2. Corrigir o IP do servidor RMI introduzido.

Após conseguir estabelecer conexão entre a calculadora e o servidor, vai conseguir utilizar a calculadora sem qualquer restrição. 

#### 2. Interface da calculadora
Após introduzir o IP desejado, e de clicar no botão __Confirmar__, é exibida a janela da calculadora.

![Interface da calculadora](https://github.com/D1ogoCS/Calculadora/blob/main/imagens/interfaceCalculadora.png)

*Interface da calculadora*

A calculadora conta com uma variedade de operações, desde as mais básicas como soma, substração, multiplicação e divisão, mas também as operações mais avançadas como exponeciação, raiz, logaritmo, módulo e trigonometria.

#### 3. Voltar ao menu
A calculadora RMI possui o botão “Voltar”, que irá voltar para o menu apresentado anteriormente onde poderá altera o IP do servidor caso seja necessário, sem ter que fechar a calculadora.

#### 4. Operações básicas
A seguir pode-se observar um exemplo de uma operação simples de multiplicação e como as operações são apresentadas. É de notar que os botões das operações são desativados após clicar em qualquer tipo de operação, para que não haja operações introduzidas simultaneamente, pois a calculadora apenas realiza uma operação por vez.

Para realizar a operação é necessário introduzir um primeiro número, depois clicar no botão da operação desejada, a seguir introduzir outro número e por fim clicar no botão de resultado, representado pelo simbolo “=”. Só é possivel introduzir números de até dez digitos.

![Operação de multiplicação](https://github.com/D1ogoCS/Calculadora/blob/main/imagens/multiplicacao.png)

*Operação de multiplicação*

![]()

**

![]()

**

![]()

**

![]()

**

![]()

**

