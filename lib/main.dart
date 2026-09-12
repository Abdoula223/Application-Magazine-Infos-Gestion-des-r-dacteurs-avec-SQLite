import 'package:flutter/material.dart';
import 'views/redacteur_interface.dart';

void main() {
  runApp(const MonApplication());
}

class MonApplication extends StatelessWidget {
  const MonApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestion des Rédacteurs - Magazine Infos',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        useMaterial3: true,
      ),
      home: const RedacteurInterface(),
      debugShowCheckedModeBanner: false,
    );
  }
}