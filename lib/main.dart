//Wanderson Soares dos Santos  -  UTF-8  -  09/10/2023  -  pt-Br
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';

void main() {
  debugPaintLayerBordersEnabled = false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.blueGrey,
        textTheme: ThemeData.light().textTheme.apply(
              bodyColor: Colors.white,
            ),
      ),
      home: ImcCalculator(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ImcCalculator extends StatefulWidget {
  const ImcCalculator({super.key});

  @override
  ImcCalculatorState createState() => ImcCalculatorState();
}

TextFormField meuInput(controllerVariable, errorMessage, textOfLabel) {
  TextFormField meuInput = TextFormField(
    controller: controllerVariable,
    validator: (value) {
      if (value == null || value.isEmpty || value == ',' || value == '.') {
        return errorMessage;
      }
    },
    keyboardType: TextInputType.numberWithOptions(decimal: true),
    inputFormatters: <TextInputFormatter>[
      FilteringTextInputFormatter.allow(RegExp(r'^\d*[\.,]?\d*')),
    ],
    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
          width: 2.0,
        ),
      ),
      labelText: textOfLabel,
      labelStyle: TextStyle(
        color: Colors.white,
      ),
      errorStyle: TextStyle(
          fontSize: 20, color: const Color.fromARGB(255, 131, 26, 18)),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: const Color.fromARGB(255, 131, 26, 18),
          width: 2.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.blue,
          width: 2.0,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: const Color.fromARGB(255, 131, 26, 18),
          width: 2.0,
        ),
      ),
    ),
    style: TextStyle(
      fontSize: 25,
    ),
  );

  return meuInput;
}

class ImcCalculatorState extends State<ImcCalculator> {
  final _formKey = GlobalKey<FormState>();
  final alturaInput = TextEditingController();
  final pesoInput = TextEditingController();
  Color resultColor = Colors.transparent;
  double? calculoIMC;

  String? result;

  String get classification {
    String altura = alturaInput.text.contains(',')
        ? alturaInput.text.replaceFirst(",", ".")
        : alturaInput.text;

    String peso = pesoInput.text.contains(',')
        ? pesoInput.text.replaceFirst(",", ".")
        : pesoInput.text;

    calculoIMC =
        (double.parse(peso) / (double.parse(altura) * double.parse(altura)));

    calculoIMC = double.parse((calculoIMC!).toStringAsFixed(2));

    if (calculoIMC! < 18.5) {
      return 'Baixo peso';
    } else if (calculoIMC! >= 18.5 && calculoIMC! <= 24.99) {
      return 'Peso normal';
    } else if (calculoIMC! >= 25 && calculoIMC! <= 29.99) {
      return 'Sobrepeso';
    } else if (calculoIMC! >= 30 && calculoIMC! <= 34.99) {
      return 'Obesidade grau I';
    } else if (calculoIMC! >= 35 && calculoIMC! <= 39.99) {
      return 'Obesidade grau II';
    } else if (calculoIMC! >= 40) {
      return 'Obesidade grau III';
    }
    return 'Erro ao calcular Imc';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Calculadora IMC'),
        backgroundColor: Colors.blue[200],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 50.0, 16.0, 16.0),
                child: meuInput(
                  pesoInput,
                  'Por favor, insira seu peso',
                  'Digite seu peso em quilos',
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 30.0),
                child: meuInput(
                  alturaInput,
                  'Por favor, insira sua altura',
                  'Digite sua altura em metros',
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
                        resultColor = Colors.white;
                      });
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 10.0),
              child: Center(
                child: Text(
                  'Seu Imc é $calculoIMC\nVocê está com $result',
                  style: TextStyle(
                    fontSize: 23,
                    color: resultColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
