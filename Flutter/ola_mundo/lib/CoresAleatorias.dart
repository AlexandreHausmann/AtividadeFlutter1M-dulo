//Importações: O código importa a biblioteca dart:math para gerar números aleatórios
//e package:flutter/material.dart para criar interfaces de usuário em Flutter.
import 'dart:math';
import 'package:flutter/material.dart';

//Função main(): É a função de entrada do aplicativo Flutter.
// Ela chama a função runApp() e passa uma instância de MyApp().
void main() {
  runApp(MyApp());
}

//Classe MyApp: É uma classe que estende StatelessWidget. Ela define o aplicativo Flutter.
// No método build, retorna um MaterialApp que define a estrutura básica do aplicativo,
// incluindo o título da barra de aplicativos e o corpo, que contém o widget ColorChanger.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Sorteador de Cores'), // Título da barra de aplicativos
        ),
        body: Center(
          child:
              TrocarDeCores(), // Exibe o widget TrocarDeCores no centro do corpo da tela
        ),
      ),
    );
  }
}

//Classe TrocarDeCores: É uma classe que estende StatefulWidget.
// Esta classe representa o widget que muda de cor.
class TrocarDeCores extends StatefulWidget {
  @override
  TrocarDeCoresState createState() => TrocarDeCoresState();
}

class TrocarDeCoresState extends State<TrocarDeCores> {
  Color corTexto = Colors.black; // Cor inicial do texto

//Método mudarCor(): Este método é chamado quando o botão é pressionado.
// Ele atualiza o estado do widget TrocarDeCoresState,
// o que leva a uma reconstrução do widget com uma nova cor gerada aleatoriamente.
  void mudarCor() {
    setState(() {
      corTexto =
          geradorDeCorAleatoria(); // Gera uma nova cor aleatória quando o botão é pressionado
    });
  }

//Método geradorDeCorAleatoria(): Este método gera uma cor aleatória.
// Ele usa a classe Random para gerar números aleatórios para os componentes de vermelho,
//verde e azul da cor.
  Color geradorDeCorAleatoria() {
    Random random =
        Random(); // Cria uma instância da classe Random para gerar números aleatórios
    return Color.fromARGB(
      // Retorna uma cor aleatória
      255, // Opacidade máxima
      random.nextInt(256), // Componente de vermelho aleatório
      random.nextInt(256), // Componente de verde aleatório
      random.nextInt(256), // Componente de azul aleatório
    );
  }

//Método build() da classe ColorChanger: Este método é responsável por construir
// a interface do usuário do widget ColorChanger.
// Ele retorna uma coluna que contém um texto e um botão.
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:
          MainAxisAlignment.center, // Alinha os widgets verticalmente no centro
      children: [
        Text(
          'Sua Cor aqui', // Texto exibido
          style: TextStyle(
              fontSize: 24,
              color: corTexto), // Estilo do texto com a cor definida
        ),
        SizedBox(height: 20), // Adiciona um espaço entre o texto e o botão
        ElevatedButton(
          //Widget ElevatedButton: É um botão que, quando pressionado, chama o método
          onPressed:
              mudarCor, // Chama a função mudarCor quando o botão é pressionado
          child: Text('Sortear cor'), // Texto exibido no botão
        ),
      ],
    );
  }
}
