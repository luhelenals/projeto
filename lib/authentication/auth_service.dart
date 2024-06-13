import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String email;
  late String nome;

  AuthService();

  Future<void> fetchUserData() async {
    User? user = _auth.currentUser;

    if (user != null) {
      email = user.email ?? 'No Email';
      nome = user.displayName ?? 'No Name';
    } else {
      email = 'No Email';
      nome = 'No Name';
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
