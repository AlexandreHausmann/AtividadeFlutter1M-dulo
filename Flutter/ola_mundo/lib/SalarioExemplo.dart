import 'package:flutter/material.dart';

void main() {
  runApp(MyApp(nome: 'Pedro'));
}

class MyApp extends StatefulWidget {
  final String nome;
  const MyApp({Key? key, this.nome = ''}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int salario = 7000;
  void aumentaSalario(int valor) {
    setState(() {
      this.salario = this.salario + valor;
    });
  }

  void diminuiSalario(int valor) {
    setState(() {
      this.salario = this.salario - valor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          print('clicou');
          diminuiSalario(200);
          /*
          setState(() {
                salario = salario + 100;
          });
      */
          print('novo salário $salario');
        },
        child: Text(
          'Osalário de ${widget.nome} é $salario',
          textDirection: TextDirection.ltr,
        ),
      ),
    );
  }
}
