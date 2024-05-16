import 'package:flutter/material.dart';

final ThemeData temaClaro = ThemeData(
  appBarTheme: const AppBarTheme(
    color: Colors.deepOrange,
  ),
  bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.grey[700]),
  canvasColor: const Color.fromARGB(255, 221, 220, 220),
  cardTheme: const CardTheme(
    color: Colors.white,
  ),
  iconTheme: const IconThemeData(color: Colors.deepOrange),
  primarySwatch: Colors.deepOrange,
  brightness: Brightness.light,
  primaryColor: Colors.deepOrange,
  primaryColorLight: Colors.deepOrange,
);

//================= ESCURO ========================
final ThemeData temaEscuro = ThemeData(
  appBarTheme: const AppBarTheme(
    color: Colors.deepOrange,
  ),
  bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.grey[700]),
  canvasColor: Colors.grey[700],
  cardTheme: const CardTheme(
    color: Colors.white,
  ),
  iconTheme: const IconThemeData(color: Colors.deepOrange),
  primarySwatch: Colors.deepOrange,
  brightness: Brightness.light,
  primaryColor: Colors.deepOrange,
  primaryColorLight: Colors.deepOrange,
);
