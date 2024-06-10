import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto/configs/app_settings.dart';
import 'home_page.dart';

class FirstAccessScreen extends StatefulWidget {
  const FirstAccessScreen({Key? key}) : super(key: key);

  @override
  State<FirstAccessScreen> createState() => _FirstAccessScreenState();
}

class _FirstAccessScreenState extends State<FirstAccessScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  String _email = "";
  String _password = "";
  String _name = "";

  void _handleSignUp() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );

      await userCredential.user!.updateProfile(displayName: _name);
      await userCredential.user!.reload();

      print("Usuário registrado: ${userCredential.user!.email}");
    } catch (e) {
      print("Erro de registro: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppSettings.getCorFundo(),
        title: Text(
          "Crie uma conta",
          style: TextStyle(color: AppSettings.getCorTema()),
        ),
      ),
      backgroundColor: AppSettings.getCorFundo(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nome',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return "Insira seu nome";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _name = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
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
                    'Criar conta',
                    style: TextStyle(
                      color: AppSettings.getCorSecundaria(),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _handleSignUp();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyHomePage(input: []),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}