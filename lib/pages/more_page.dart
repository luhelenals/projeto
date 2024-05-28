import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:projeto/configs/app_settings.dart';
import 'profile_page.dart';

class MorePage extends StatelessWidget {
  const MorePage({Key? key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            leading: const Icon(Icons.perm_identity),
            title: const Text('Perfil'),
            onTap: () {
              // Navigate to profile page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notificações'),
            onTap: () {
              // Navigate to settings page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationsPage()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: const Text('Tema'),
            onTap: () {
              // Navigate to settings page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ThemePage()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sair'),
            onTap: () {
              // Navigate to settings page
              Navigator.pop(
                context,
                MaterialPageRoute(builder: (context) => const LogInPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notificações',
            style: TextStyle(color: AppSettings.getCorTexto())),
        backgroundColor: AppSettings.getCor(),
        iconTheme: IconThemeData(color: AppSettings.getCorTexto()),
      ),
      body: const Center(
        child: Text('implementar'),
      ),
    );
  }
}

class ThemePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tema', style: TextStyle(color: AppSettings.getCorTexto())),
        backgroundColor: AppSettings.getCor(),
        iconTheme: IconThemeData(color: AppSettings.getCorTexto()),
      ),
      body: Center(
        child: const Text('implementar'),
      ),
    );
  }
}
