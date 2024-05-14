import 'package:flutter/material.dart';
import 'login_page.dart';

class PasswordResetScreen extends StatelessWidget {
  const PasswordResetScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color(0xFFDEFFDF),
                  ),
                  minimumSize: MaterialStateProperty.all<Size>(
                    const Size(200, 50),
                  ),
                  textStyle: MaterialStateProperty.all<TextStyle>(
                    const TextStyle(color: Color(0xFF204522)),
                  ),
                ),
                onPressed: () => forgotPasswordEmailDialogue(context),
                child: const Text(
                  'Enviar',
                  style: TextStyle(
                      color: Color(0xFF204522),
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
                  MaterialPageRoute(builder: (context) => LogInPage()),
                );
              },
              icon: const Icon(Icons.arrow_back, color: Color(0xFF204522)),
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
