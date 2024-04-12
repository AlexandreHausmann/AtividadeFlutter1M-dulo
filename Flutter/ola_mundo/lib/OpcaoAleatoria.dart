//Importações: O código importa os pacotes
// material.dart do Flutter para criar a interface do usuário
// e dart:math para gerar números aleatórios.
import 'package:flutter/material.dart';
import 'dart:math';

//Função main(): É a função de entrada do aplicativo Flutter.
// Ela chama a função runApp() e passa uma instância de MyApp().
void main() {
  runApp(MyApp());
}

// Classe MyApp: É uma classe que estende StatelessWidget.
// Ela define o aplicativo Flutter. No método build,
//ele retorna um MaterialApp que define o título do aplicativo
//e define GuessButtonScreen() como a tela inicial.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogo de Botões',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
          GuessButtonScreen(), // Define a tela inicial do aplicativo como GuessButtonScreen
    );
  }
}

// Tela do jogo que contém a lógica principal do jogo
//Classe GuessButtonScreen: É uma classe que estende StatefulWidget.
// Esta classe representa a tela principal do jogo.
class GuessButtonScreen extends StatefulWidget {
  @override
  _GuessButtonScreenState createState() => _GuessButtonScreenState();
}

class _GuessButtonScreenState extends State<GuessButtonScreen> {
  final Random _random = Random();
  late String botaoCorreto; // Botão correto escolhido aleatoriamente
  int tentativas = 2; // Número de tentativas permitidas
  bool fimDoJogo = false; // Indica se o jogo terminou

//Método initState(): É um método do ciclo de vida do widget,
// que é chamado uma vez quando o estado é inserido no widget tree.
// Aqui, ele chama geradorBotaoCorreto() para inicializar o botão correto.
  @override
  void initState() {
    super.initState();
    geradorBotaoCorreto(); // Inicializa o botão correto ao criar a tela
  }

  // Gera aleatoriamente o botão correto
  //Método geradorBotaoCorreto():
  //Este método gera aleatoriamente um botão correto entre 'A', 'B' e 'C'.
  void geradorBotaoCorreto() {
    final buttons = ['A', 'B', 'C'];
    botaoCorreto = buttons[_random.nextInt(buttons.length)];
  }

  // Verifica se o botão clicado é o correto
  //Método checkButton(): Este método é chamado quando um botão é clicado.
  // Ele verifica se o botão clicado é o correto. Se for,
  // o jogo termina e se não for, o número de tentativas é reduzido.
  // Se o número de tentativas se esgotar, o jogo também termina.
  void checarbotao(String buttonText) {
    if (buttonText == botaoCorreto) {
      // Se o botão clicado for o correto
      setState(() {
        fimDoJogo = true; // Indica que o jogo terminou
      });
    } else {
      setState(() {
        tentativas--; // Reduz o número de tentativas restantes
        if (tentativas == 0) {
          // Se não houver mais tentativas
          fimDoJogo = true; // Indica que o jogo terminou
        }
      });
    }
  }

  // Reinicia o jogo
  //Método reiniciaJogo(): Este método é chamado para reiniciar o jogo.
  // Ele redefine o número de tentativas, o estado do jogo e gera um novo botão correto.
  void reiniciaJogo() {
    setState(() {
      tentativas = 2; // Reinicia o número de tentativas
      fimDoJogo = false; // Reseta o estado do jogo
      geradorBotaoCorreto(); // Gera um novo botão correto
    });
  }

//Método build(): É o método responsável por construir a interface do usuário.
// Dependendo do estado do jogo (fimDoJogo),
// ele mostra uma mensagem de vitória ou derrota,
// juntamente com um botão para jogar novamente,
// ou mostra as tentativas restantes e os botões de escolha ('A', 'B', 'C').
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jogo de Botões'),
      ),
      body: Center(
        child: fimDoJogo
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    tentativas > 0 ? 'Você perdeu!' : 'Você ganhou!',
                    style: TextStyle(fontSize: 24.0),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: reiniciaJogo,
                    child: Text('Jogar Novamente'),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Tentativas restantes: $tentativas',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () => checarbotao('A'),
                    child: Text('A'),
                  ),
                  ElevatedButton(
                    onPressed: () => checarbotao('B'),
                    child: Text('B'),
                  ),
                  ElevatedButton(
                    onPressed: () => checarbotao('C'),
                    child: Text('C'),
                  ),
                ],
              ),
      ),
    );
  }
}
