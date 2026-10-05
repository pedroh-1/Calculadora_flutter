import 'package:flutter/material.dart';

void main() {
  runApp(const CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  const CalculadoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CalculadoraScreen(),
    );
  }
}

class CalculadoraScreen extends StatefulWidget {
  const CalculadoraScreen({super.key});

  @override
  State<CalculadoraScreen> createState() => _CalculadoraScreenState();
}

class _CalculadoraScreenState extends State<CalculadoraScreen> {
  // Controladores para capturar o texto digitado pelo usuário
  final TextEditingController _num1Controller = TextEditingController();
  final TextEditingController _num2Controller = TextEditingController();

  // Variável de estado que armazena o texto do resultado a ser exibido
  String _resultado = "0.0";

  // Função principal para realizar o cálculo e atualizar o estado
  void _calcular(String operacao) {
    // Tenta converter o texto digitado para números decimais
    double? num1 = double.tryParse(_num1Controller.text);
    double? num2 = double.tryParse(_num2Controller.text);

    // Validação de entrada vazia ou inválida
    if (num1 == null || num2 == null) {
      setState(() {
        _resultado = "Insira números válidos";
      });
      return;
    }

    double calcResult = 0;

    switch (operacao) {
      case '+':
        calcResult = num1 + num2;
        break;
      case '-':
        calcResult = num1 - num2;
        break;
      case '*':
        calcResult = num1 * num2;
        break;
      case '/':
        if (num2 == 0) {
          setState(() {
            _resultado = "Erro: Divisão por zero";
          });
          return;
        }
        calcResult = num1 / num2;
        break;
    }

    // Atualiza a variável de estado e reconstrói a UI
    setState(() {
      _resultado = calcResult.toStringAsFixed(
        2,
      ); // Formata para 2 casas decimais
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora Básica'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Campo de entrada para o primeiro número
            TextField(
              controller: _num1Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Primeiro número',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Campo de entrada para o segundo número
            TextField(
              controller: _num2Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Segundo número',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),

            // Botões de operação matemática
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _calcular('+'),
                  child: const Text('+', style: TextStyle(fontSize: 24)),
                ),
                ElevatedButton(
                  onPressed: () => _calcular('-'),
                  child: const Text('-', style: TextStyle(fontSize: 24)),
                ),
                ElevatedButton(
                  onPressed: () => _calcular('*'),
                  child: const Text('×', style: TextStyle(fontSize: 24)),
                ),
                ElevatedButton(
                  onPressed: () => _calcular('/'),
                  child: const Text('÷', style: TextStyle(fontSize: 24)),
                ),
              ],
            ),
            const SizedBox(height: 48),

            // Exibição do Resultado
            const Text(
              'Resultado:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Text(
              _resultado,
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Liberar recursos dos controladores quando a tela for destruída
    _num1Controller.dispose();
    _num2Controller.dispose();
    super.dispose();
  }
}
