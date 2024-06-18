import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto/configs/app_settings.dart';
import 'first_access.dart';
import 'package:projeto/authentication/password_reset.dart';
import 'package:projeto/pages/home_page.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  String _email = "";
  String _password = "";

  void _handleLogIn() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );

        Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) => const MyHomePage(input: []),
        ),
      );
      
      print("Usuário logado: ${userCredential.user!.email}");
    } catch (e) {
      print("Erro de login: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/logo_resized.png'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Form(
            key: _formKey,  // Associate the form key here
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    fillColor: Colors.white,
                    filled: true,
                    labelText: "Email",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Insira seu email";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _email = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    fillColor: Colors.white,
                    filled: true,
                    labelText: "Senha",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Insira sua senha";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _password = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                      AppSettings.getCorTema(),
                    ),
                    minimumSize: WidgetStateProperty.all<Size>(
                      const Size(200, 50),
                    ),
                    textStyle: WidgetStateProperty.all<TextStyle>(
                      TextStyle(color: AppSettings.getCorSecundaria()),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: AppSettings.getCorSecundaria(),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _handleLogIn();
                    }
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
                                builder: (context) => PasswordResetScreen()),
                          );
                        },
                        child: Text(
                          'Esqueci minha senha',
                          style: TextStyle(
                            color: Colors.transparent,
                            shadows: [
                              Shadow(color: AppSettings.getCorTema(), offset: const Offset(0, -3))
                            ],
                            decoration: TextDecoration.underline,
                            decorationColor: AppSettings.getCorTema(),
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
                          child: Text(
                            'Primeiro acesso',
                            style: TextStyle(
                              color: Colors.transparent,
                              shadows: [
                                Shadow(color: AppSettings.getCorTema(), offset: const Offset(0, -3))
                              ],
                              decoration: TextDecoration.underline,
                              decorationColor: AppSettings.getCorTema(),
                              decorationThickness: 2,
                            ),
                          ),
                        ),
                      ],
                    )
              ],
            ),
          ),
        ),
      ],
    ));
  }
}