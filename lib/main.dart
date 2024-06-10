import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'package:projeto/configs/app_settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LuS',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppSettings.getCorTema()),
        scaffoldBackgroundColor: AppSettings.getCorFundo(),
      ),
      home: const Scaffold(
        body: LogInPage(),
      ),
    );
  }
}
