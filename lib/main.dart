import 'package:flutter/material.dart';
//import 'package:projeto/configs/hive_config.dart';
import 'pages/login_page.dart';
//import 'pages/home_page.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  //await HiveConfig.start();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LuS',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF204522)),
        scaffoldBackgroundColor: const Color(0xFFBADBC0), //Colors.white10,
      ),
      home: const Scaffold(
        body: LogInPage(),
      ),
    );
  }
}
