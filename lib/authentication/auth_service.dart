import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String email;
  late String nome;
  late String celular;
  late String foto;

  AuthService();

  Future<void> fetchUserData() async {
    User? user = _auth.currentUser;

    if (user != null) {
      email = user.email ?? '';
      nome = user.displayName ?? '';
      celular = user.phoneNumber ?? '';
      foto = user.photoURL ?? '';
    } else {
      email = '';
      nome = '';
      celular = '';
      foto = '';
    }
  }

  Future<void> sendPasswordResetLink(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e);
    }
  }
}
