import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/screens/weather_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
      ),
      darkTheme: ThemeData.dark(),
      home: const WeatherScreen(),
    );
  }
}
