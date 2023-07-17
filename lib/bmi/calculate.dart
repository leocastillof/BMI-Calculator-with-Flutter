import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalculateScreen extends StatelessWidget {
  const CalculateScreen({Key? key}) : super(key: key);

  String getBMIInterpretation(double bmi) {
    if (bmi < 18.5) {
      return 'Tienes un peso corporal por debajo del rango saludable. Considera hablar con un profesional de la salud para mejorar tu peso.';
    } else if (bmi >= 18.5 && bmi < 25.0) {
      return 'Tienes un peso corporal dentro del rango saludable. ¡Sigue cuidándote!';
    } else if (bmi >= 25.0 && bmi < 30.0) {
      return 'Tienes un ligero sobrepeso. Considera hacer cambios en tu estilo de vida para mantener un peso saludable.';
    } else {
      return 'Tienes obesidad. Es importante tomar medidas para mejorar tu salud. Consulta a un profesional de la salud para obtener orientación.';
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final bmi = args['bmi'] as double;

    String result = '';

    Color resultColor = Colors.black;

    if (bmi < 18.5) {
      result = 'Bajo peso';
      resultColor = Colors.blue;
    } else if (bmi >= 18.5 && bmi < 25) {
      result = 'Normal';
      resultColor = Colors.green;
    } else if (bmi >= 25 && bmi < 30) {
      result = 'Sobrepeso';
      resultColor = Colors.orange;
    } else {
      result = 'Obesidad';
      resultColor = Colors.red;
    }

    final interpretation = getBMIInterpretation(bmi);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(12, 12, 12, 1.0),
        centerTitle: true,
        title: const Text(
          "RayFit - IMC",
          style: TextStyle(fontSize: 20, color: Colors.orangeAccent, letterSpacing: 1.5, fontFamily: 'sans-serif', fontWeight: FontWeight.bold),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.fitness_center,
          ),
        ),
      ),
      backgroundColor: const Color.fromRGBO(20, 20, 20, 1.0),
      body: Center(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'RESULTADO:',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white,),
              ),
              const SizedBox(height: 30),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(12, 12, 12, 1.0),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Text(
                      result.toUpperCase(),
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: resultColor),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Tu IMC es: ${bmi.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 18, color: Colors.white,),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      interpretation,
                      style: const TextStyle(fontSize: 15, color: Colors.white,),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 60),

              CupertinoButton(
                color: const Color.fromRGBO(12, 12, 12, 1.0),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Volver al inicio',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
