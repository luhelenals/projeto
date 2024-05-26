import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'package:projeto/configs/app_settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LuS',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppSettings.getCor()),
        scaffoldBackgroundColor: const Color(0xFFBADBC0),
      ),
      home: const Scaffold(
        body: LogInPage(),
      ),
    );
  }
}
