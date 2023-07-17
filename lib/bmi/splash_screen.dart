import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:RayFit/bmi/dates.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
with SingleTickerProviderStateMixin{
  
  @override
  void initState(){
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => const HomeScreen(),
      ));
    });
  }

  @override
  void dispose()
  {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromRGBO(73, 44, 73, 1.0),  Color.fromRGBO(23, 14, 23, 1.0),],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.fitness_center,
                size: 80,
                color: Colors.white
            ),
            SizedBox(height: 20),
            Text('RayFit',
            style: TextStyle(
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 32,
            ),)
          ],
          ),

      ),
    );
  }
}