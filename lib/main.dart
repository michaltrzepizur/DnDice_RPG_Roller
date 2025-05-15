import 'package:dndice/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const DnDiceApp());
}

class DnDiceApp extends StatelessWidget {
  const DnDiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DnDice',
      theme: ThemeData(fontFamily: 'MedievalSharp'),
      home: const HomePage(),
    );
  }
}
