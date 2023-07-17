import 'package:RayFit/ad_mob_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:RayFit/bmi/calculate.dart';

void main() {
  runApp(const HomeScreen());
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const BmiCalculator(),
      routes: {
        '/calculate': (context) => const CalculateScreen(),
      },
    );
  }
}

class BmiCalculator extends StatefulWidget {
  const BmiCalculator({Key? key}) : super(key: key);

  @override
  _BmiCalculatorState createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {
  int currentIndex = 0;
  double heightValue = 150.0;
  double weightValue = 60.0;
  int ageValue = 25;

  TextEditingController weightController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    weightController.text = weightValue.toString();
    ageController.text = ageValue.toString();
  }

  @override
  void dispose() {
    weightController.dispose();
    ageController.dispose();
    super.dispose();
  }

  void showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('RayFit BETA!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void calculateBMI() {
    // Ad
    AdMobService().showInterstitialAd();

    double bmi = weightValue / ((heightValue / 100) * (heightValue / 100));
    Navigator.pushNamed(
      context,
      '/calculate',
      arguments: {'bmi': bmi},
    );
  }

  @override
  Widget build(BuildContext context) {
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
          onTap: () {},
          child: const Icon(
            Icons.fitness_center,
          ),
        ),
      ),
      backgroundColor: const Color.fromRGBO(20, 20, 20, 1.0),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  radioButton("Masculino", const Color.fromRGBO(12, 12, 12, 1.0), 0, Icons.male),
                  radioButton("Femenino", const Color.fromRGBO(12, 12, 12, 1.0), 1, Icons.female),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(12, 12, 12, 1.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Altura en cm',
                      style: TextStyle(
                        color: Colors.orangeAccent,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    CupertinoSlider(
                      value: heightValue,
                      min: 100.0,
                      max: 200.0,
                      onChanged: (value) {
                        setState(() {
                          heightValue = value;
                        });
                      },
                      activeColor: const Color.fromRGBO(20, 20, 20, 1.0),
                      thumbColor: Colors.white,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '${heightValue.round()} cm',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 4),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(12, 12, 12, 1.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Peso en kg',
                            style: TextStyle(
                              color: Colors.orangeAccent,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                color: Colors.white,
                                onPressed: () {
                                  setState(() {
                                    weightValue -= 1;
                                    weightController.text = weightValue.toString();
                                  });
                                },
                              ),
                              const SizedBox(width: 1),
                              Expanded(
                                child: TextFormField(
                                  controller: weightController,
                                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                  style: const TextStyle(color: Colors.white, fontSize: 18),
                                  textAlign: TextAlign.center,
                                  onChanged: (value) {
                                    setState(() {
                                      weightValue = double.tryParse(value) ?? weightValue;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.all(8),
                                    border: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(),
                                    hintText: 'Ingrese el peso',
                                    hintStyle: TextStyle(color: Colors.white, fontSize: 14),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              IconButton(
                                icon: const Icon(Icons.add),
                                color: Colors.white,
                                onPressed: () {
                                  setState(() {
                                    weightValue += 1;
                                    weightController.text = weightValue.toString();
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 1),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 4),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(12, 12, 12, 1.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Edad',
                            style: TextStyle(
                              color: Colors.orangeAccent,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                color: Colors.white,
                                onPressed: () {
                                  setState(() {
                                    ageValue -= 1;
                                    ageController.text = ageValue.toString();
                                  });
                                },
                              ),
                              const SizedBox(width: 1),
                              Expanded(
                                child: TextFormField(
                                  controller: ageController,
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(color: Colors.white, fontSize: 18),
                                  textAlign: TextAlign.center,
                                  onChanged: (value) {
                                    setState(() {
                                      ageValue = int.tryParse(value) ?? ageValue;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.all(8),
                                    border: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(),
                                    hintText: 'Ingrese la edad',
                                    hintStyle: TextStyle(color: Colors.white, fontSize: 14),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              IconButton(
                                icon: const Icon(Icons.add),
                                color: Colors.white,
                                onPressed: () {
                                  setState(() {
                                    ageValue += 1;
                                    ageController.text = ageValue.toString();
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              CupertinoButton(
                onPressed: calculateBMI,
                color: const Color.fromRGBO(12, 12, 12, 1.0),
                child: const Text(
                  'Calcular',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.orangeAccent,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'El IMC es una medida del peso y la altura que ayuda a evaluar la salud general. Mantener un IMC saludable reduce el riesgo de enfermedades. Consulta a un profesional de la salud para obtener más información.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void changeIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  Widget radioButton(String value, Color color, int index, IconData iconData) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(16.0),
            textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            side: BorderSide(
              color: currentIndex == index ? color : Colors.grey,
            ),
            primary: currentIndex == index ? color : Colors.white,
          ),
          onPressed: () {
            changeIndex(index);
          },
          child: Column(
            children: [
              Icon(
                iconData,
                color: currentIndex == index ? Colors.orangeAccent : color,
                size: 40,
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: TextStyle(
                  color: currentIndex == index ? Colors.orangeAccent : color,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
