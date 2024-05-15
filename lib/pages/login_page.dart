import 'package:flutter/material.dart';
import 'first_access.dart';
import 'password_reset.dart';
import 'home_page.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset('assets/logo_resized.png'),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Email',
              fillColor: Colors.white,
              filled: true,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Senha',
              fillColor: Colors.white,
              filled: true,
            ),
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
          ),
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(const Color(0xFFDEFFDF)),
            minimumSize: MaterialStateProperty.all<Size>(const Size(200, 50)),
            textStyle: MaterialStateProperty.all<TextStyle>(
              const TextStyle(color: Color(0xFF204522)),
            ),
          ),
          child: const Text(
            'Login',
            style: TextStyle(
                color: Color(0xFF204522),
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const MyHomePage(input: [])),
            );
          },
        ),
        const SizedBox(height: 10.00),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  // Navigate to the password reset screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PasswordResetScreen()),
                  );
                },
                child: const Text(
                  'Esqueci minha senha',
                  style: TextStyle(
                    color: Colors.transparent,
                    shadows: [
                      Shadow(color: Color(0xFF204522), offset: Offset(0, -3))
                    ],
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xFF204522),
                    decorationThickness: 2,
                  ),
                )),
            TextButton(
              onPressed: () {
                // Navigate to the password reset screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FirstAccessScreen()),
                );
              },
              child: const Text(
                'Primeiro acesso',
                style: TextStyle(
                  color: Colors.transparent,
                  shadows: [
                    Shadow(color: Color(0xFF204522), offset: Offset(0, -3))
                  ],
                  decoration: TextDecoration.underline,
                  decorationColor: Color(0xFF204522),
                  decorationThickness: 2,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
