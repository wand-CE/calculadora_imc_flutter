import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ImcCalculator(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ImcCalculator extends StatefulWidget {
  @override
  _ImcCalculatorState createState() => _ImcCalculatorState();
}

class _ImcCalculatorState extends State<ImcCalculator> {
  final _formKey = GlobalKey<FormState>();
  final altura_input = TextEditingController();
  final peso_input = TextEditingController();
  Color result_color = Colors.transparent;

  String? result;

  String get classification {
    String altura = altura_input.text.contains(',')
        ? altura_input.text.replaceFirst(",", ".")
        : altura_input.text;

    String peso = peso_input.text.contains(',')
        ? peso_input.text.replaceFirst(",", ".")
        : peso_input.text;

    double calculoIMC =
        (double.parse(peso) / (double.parse(altura) * double.parse(altura)));

    if (calculoIMC < 18.5) {
      return 'Baixo peso';
    } else if (calculoIMC >= 18.5 && calculoIMC <= 24.99) {
      return 'Peso normal';
    } else if (calculoIMC >= 25 && calculoIMC <= 29.99) {
      return 'Sobrepeso';
    } else if (calculoIMC >= 30 && calculoIMC <= 34.99) {
      return 'Obesidade grau I';
    } else if (calculoIMC >= 35 && calculoIMC <= 39.99) {
      return 'Obesidade grau II';
    } else if (calculoIMC >= 40) {
      return 'Obesidade grau III';
    }
    return 'oi';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora IMC'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 50.0, 16.0, 16.0),
                child: TextFormField(
                  controller: peso_input,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value == ',' ||
                        value == '.') {
                      return 'Por favor, insira seu peso';
                    }
                  },
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*[\.,]?\d*')),
                  ],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Digite seu peso em quilos',
                  ),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 30.0),
                child: TextFormField(
                  controller: altura_input,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value == ',' ||
                        value == '.') {
                      return 'Por favor, insira sua altura';
                    }
                  },
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*[\.,]?\d*')),
                  ],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Digite sua altura em metros',
                  ),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Calcular',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        result = classification;
                        result_color = Colors.black;
                      });
                    }
                  },
                ),
              ),
            ),
            Center(
              child: Text(
                '$result',
                style: TextStyle(fontSize: 30, color: result_color),
              ),
            )
          ],
        ),
      ),
    );
  }
}
