import 'package:deneb_v2/screens/add_planet_screen.dart';
import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 100, 62, 98),
      ),
      home: HomeScreen2(),
    );
  }
}
