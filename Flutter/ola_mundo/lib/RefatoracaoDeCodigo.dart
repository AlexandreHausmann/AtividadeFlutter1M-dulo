//foi utilizado pesquisa no campo de respostas para conseguir fazer o código rodar 

//Importações: O código importa o pacote package:flutter/material.dart
// para criar a interface do usuário e dart:math para gerar números aleatórios.
import 'package:flutter/material.dart';
import 'dart:math';

// Enumerador para representar os diferentes estados do jogo
enum GameState {
  Playing,
  Won,
  Lost,
}

//Definição de cores: Define uma cor escura (darkBlue) para o tema do aplicativo.
const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

//Função main(): É a função de entrada do aplicativo Flutter.
// Ela chama a função runApp() e passa uma instância de MyApp().
void main() {
  runApp(MyApp());
}

//Classe MyApp: É uma classe que estende StatelessWidget.
// Ela define o aplicativo Flutter. No método build,
// retorna um MaterialApp que define o tema escuro e
// a tela inicial como um Scaffold contendo o widget MyWidget.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: darkBlue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: MyWidget(),
        ),
      ),
    );
  }
}

//Classe MyWidget: É uma classe que estende StatefulWidget.
// Esta classe representa a tela principal do jogo.
class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final Random _random = Random();

  int _correctButton = 0;
  int _clicks = 0;
  int _wins = 0;
  int _losses = 0;
  GameState _gameState = GameState.Playing;

//Método initState(): É um método do ciclo de vida do widget,
// que é chamado uma vez quando o estado é inserido no widget tree.
// Aqui, ele chama _chooseCorrectButton() para inicializar o botão correto.
  @override
  void initState() {
    super.initState();
    _chooseCorrectButton();
  }

//Método _chooseCorrectButton():
// Este método gera aleatoriamente o botão correto entre 'A', 'B' e 'C'.
  void _chooseCorrectButton() {
    _correctButton = _random.nextInt(3);
  }

//Método _resetGame(): Este método é chamado para reiniciar o jogo.
// Ele redefine o número de cliques, o estado do jogo e gera um novo botão correto.
  void _resetGame() {
    setState(() {
      _clicks = 0;
      _gameState = GameState.Playing;
      _chooseCorrectButton();
    });
  }

//Método _checkButton(): Este método é chamado quando um botão é clicado.
// Ele verifica se o botão clicado é o correto. Se for, o jogo é ganho, e se não for,
// o número de cliques é incrementado. Se o número de cliques exceder 2, o jogo é perdido.
  void _checkButton(int option) {
    setState(() {
      if (option == _correctButton) {
        _gameState = GameState.Won;
        _wins++;
      } else {
        _clicks++;
        if (_clicks >= 2) {
          _gameState = GameState.Lost;
          _losses++;
        }
      }
    });
  }

//Método build() da classe MyWidget: É o método responsável por construir a interface do usuário.
// Dependendo do estado do jogo (_gameState),
//ele mostra os botões de escolha ('A', 'B', 'C') ou a tela de resultado.
  @override
  Widget build(BuildContext context) {
    switch (_gameState) {
      case GameState.Playing:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _checkButton(0),
              child: Text('A'),
            ),
            ElevatedButton(
              onPressed: () => _checkButton(1),
              child: Text('B'),
            ),
            ElevatedButton(
              onPressed: () => _checkButton(2),
              child: Text('C'),
            ),
          ],
        );
      case GameState.Won:
        return _ResultScreen(
          message: 'Você ganhou!',
          color: Colors.green,
          onRestart: _resetGame,
        );
      case GameState.Lost:
        return _ResultScreen(
          message: 'Você perdeu!',
          color: Colors.red,
          onRestart: _resetGame,
        );
    }
  }
}

//Classe _ResultScreen: É um widget para exibir a tela de resultado quando o jogo é ganho ou perdido.
class _ResultScreen extends StatelessWidget {
  final String message;
  final Color color;
  final VoidCallback onRestart;

  const _ResultScreen({
    required this.message,
    required this.color,
    required this.onRestart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: TextStyle(fontSize: 24.0),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: onRestart,
            child: Text('Jogar Novamente'),
          ),
        ],
      ),
    );
  }
}

