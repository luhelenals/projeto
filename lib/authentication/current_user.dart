import 'package:firebase_auth/firebase_auth.dart';

class Usuario {
  late String email;
  late String nome;

  Usuario();

  Future<void> fetchUserData() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;

    if (user != null) {
      email = user.email ?? 'No Email';
      nome = user.displayName ?? 'No Name';
    } else {
      email = 'No Email';
      nome = 'No Name';
    }
  }
}
