import 'package:flutter/material.dart';
import 'pages/login_page.dart';

void main() {
  runApp(const TechExpressApp());
}

class TechExpressApp extends StatelessWidget {
  const TechExpressApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Definisi warna sesuai permintaan desain
    const Color primaryColor = Color(0xFF111827);
    const Color accentColor = Color(0xFFD4AF37);
    const Color backgroundColor = Color(0xFFF8FAFC);

    return MaterialApp(
      title: 'TechExpress',
      debugShowCheckedModeBanner: false, // Menghilangkan banner debug
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: backgroundColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          primary: primaryColor,
          secondary: accentColor,
          surface: backgroundColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      // Halaman pertama yang dibuka adalah Login
      home: const LoginPage(),
    );
  }
}