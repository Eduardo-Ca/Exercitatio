import 'package:exercitatio/module/home/presenter/home.dart';
import 'package:flutter/material.dart';

import 'core/constants/tema_constante.dart';

void main() {
  runApp(const Exercitatio());
}

class Exercitatio extends StatelessWidget {
  const Exercitatio({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: temaClaro,
      darkTheme: temaEscuro,
      title: 'Exercitatio',
      home: const HomeTela(),
    );
  }
}
