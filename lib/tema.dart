import 'package:flutter/material.dart';

// cores do app, inspiradas no simbolo de radiacao (amarelo e preto)
class Cores {
  static const fundo = Color(0xFF0E1116);
  static const superficie = Color(0xFF171C23);
  static const superficieClara = Color(0xFF232A33);
  static const amarelo = Color(0xFFFFC928);
  static const vermelho = Color(0xFFE53935);
  static const verde = Color(0xFF2EC4B6);
  static const texto = Colors.white;
  static const textoSuave = Color(0xFF9AA4B2);
}

ThemeData criarTema() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Cores.fundo,
    colorScheme: const ColorScheme.dark(
      primary: Cores.amarelo,
      onPrimary: Colors.black,
      secondary: Cores.verde,
      error: Cores.vermelho,
      surface: Cores.superficie,
      onSurface: Cores.texto,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Cores.fundo,
      foregroundColor: Cores.texto,
      elevation: 0,
      // nao muda de cor quando rola a tela
      scrolledUnderElevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Cores.texto,
      ),
    ),
    cardTheme: CardThemeData(
      color: Cores.superficie,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: Cores.textoSuave,
      subtitleTextStyle: TextStyle(color: Cores.textoSuave, fontSize: 14),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Cores.superficie,
      labelStyle: const TextStyle(color: Cores.textoSuave),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Cores.amarelo, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Cores.vermelho),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Cores.vermelho, width: 2),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Cores.amarelo,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Cores.amarelo,
        side: const BorderSide(color: Cores.amarelo),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Cores.amarelo,
      foregroundColor: Colors.black,
    ),
    snackBarTheme: const SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Cores.superficieClara,
      contentTextStyle: TextStyle(color: Cores.texto),
    ),
    dialogTheme: const DialogThemeData(backgroundColor: Cores.superficie),
    dividerTheme: const DividerThemeData(color: Cores.superficieClara),
  );
}
