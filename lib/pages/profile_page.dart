import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String currentName = "João Silva";//_auth.currentUser!.email;
  final String currentEmail = "joao.silva@example.com";
  final String currentBirthDate = "15/05/1990";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações do Perfil',
            style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[300],
              child: IconButton(
                icon: Icon(Icons.camera_alt, color: Colors.white),
                onPressed: () {
                  // Função para adicionar foto
                },
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              title:
                  Text('Nome', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(currentName),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // Função para editar nome
                  _showEditDialog(context, 'Nome', currentName, (newValue) {
                    // Atualizar nome
                  });
                },
              ),
            ),
            Divider(),
            ListTile(
              title:
                  Text('Email', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(currentEmail),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // Função para editar email
                  _showEditDialog(context, 'Email', currentEmail, (newValue) {
                    // Atualizar email
                  });
                },
              ),
            ),
            Divider(),
            ListTile(
              title: Text('Data de Nascimento',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(currentBirthDate),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // Função para editar data de nascimento
                  _showEditDialog(
                      context, 'Data de Nascimento', currentBirthDate,
                      (newValue) {
                    // Atualizar data de nascimento
                  });
                },
              ),
            ),
            Divider(),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Senha Atual',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Nova Senha',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Confirmar Nova Senha',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              child: Text('Salvar Alterações'),
              onPressed: () {
                // Função para salvar as alterações do perfil
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, String field, String currentValue,
      Function(String) onSave) {
    TextEditingController controller =
        TextEditingController(text: currentValue);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Editar $field'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Salvar'),
              onPressed: () {
                onSave(controller.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
