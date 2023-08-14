import 'package:APP_Characters/presentation/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.epilogueTextTheme(),
        scaffoldBackgroundColor:
            const Color(0xFF0D0118), // Establece el color de fondo global aquí
      ),
      home: const Home(),
    );
  }
}
