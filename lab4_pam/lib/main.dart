import 'package:flutter/material.dart';
import 'package:lab4_pam/presentation/screens/HomePage.dart';

void main() {
  runApp(BarberShopApp());
}

class BarberShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: HomePage(),
    );
  }
}
