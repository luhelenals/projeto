import 'package:flutter/material.dart';
import 'package:projeto/authentication/auth_service.dart';
import 'package:projeto/authentication/login_page.dart';
import 'package:projeto/configs/app_settings.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({Key? key}) : super(key: key);

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final _auth = AuthService();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(
                    AppSettings.getCorFundo(),
                  ),
                  minimumSize: WidgetStateProperty.all<Size>(
                    const Size(200, 50),
                  ),
                  textStyle: WidgetStateProperty.all<TextStyle>(
                    TextStyle(color: AppSettings.getCorTema()),
                  ),
                ),
                onPressed: (){
                  _auth.sendPasswordResetLink(_emailController.text);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Email de recuperação de senha enviado.')));
                },
                child: Text(
                  'Enviar',
                  style: TextStyle(
                      color: AppSettings.getCorTema(),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            child: IconButton(
              onPressed: () {
                // Navigate to the password reset screen
                Navigator.pop(
                  context,
                  MaterialPageRoute(builder: (context) => const LogInPage()),
                );
              },
              icon: Icon(Icons.arrow_back, color: AppSettings.getCorTema()),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> forgotPasswordEmailDialogue(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Email de recuperação de senha enviado.'),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
