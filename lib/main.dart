import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/View/HomeView.dart';
import 'Controller/Controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: const MaterialApp(
        title: 'Weather App',
        home: HomeView(),
      ),
    );
  }
}


