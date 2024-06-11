//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto/authentication/current_user.dart';
import 'package:projeto/configs/app_settings.dart';

class ProfilePage extends StatefulWidget {
const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Usuario usuario;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    usuario = Usuario();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    await usuario.fetchUserData();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppSettings.getCorFundo(),
      appBar: AppBar(
        title: Text('Configurações do Perfil',
            style: TextStyle(color: AppSettings.getCorSecundaria())),
        centerTitle: true,
        backgroundColor: AppSettings.getCorTema(),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: AppSettings.getCorSecundaria(),
              child: IconButton(
                icon: Icon(Icons.camera_alt, color: AppSettings.getCorTema()),
                onPressed: () {
                  // Função para adicionar foto
                },
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              title:
                  const Text('Nome', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(usuario.nome),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // Função para editar nome
                  _showEditDialog(context, 'Nome', usuario.nome, (newValue) {
                    // Atualizar nome
                  });
                },
              ),
            ),
            Divider(color: AppSettings.getCorTema()),
            ListTile(
              title:
                  const Text('Email', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(usuario.email),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // Função para editar email
                  _showEditDialog(context, 'Email', usuario.email, (newValue) {
                    // Atualizar email
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            /* Divider(),
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
            Divider(),*/
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Senha Atual',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Nova Senha',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Confirmar Nova Senha',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(AppSettings.getCorTema()),
                minimumSize: WidgetStateProperty.all<Size>(const Size(200, 50)),
                textStyle: WidgetStateProperty.all<TextStyle>(
                  const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              child: Text('Salvar Alterações', style: TextStyle(color: AppSettings.getCorSecundaria())),
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
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Salvar'),
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
