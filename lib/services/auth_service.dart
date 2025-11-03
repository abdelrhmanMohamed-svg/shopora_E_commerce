import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthService {
  Future<bool> signInWithEmailAndPassword(String email, String password);
  Future<bool> createUserWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  // Stream<String?> get authStateChanges;
  User? getCuurentUser();
}

class AuthServiceImpl implements AuthService {
  final fireBaseAuth = FirebaseAuth.instance;
  @override
  Future<bool> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final userCredential = await fireBaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = userCredential.user;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    final userCredential = await fireBaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = userCredential.user;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  User? getCuurentUser() {
    final user = fireBaseAuth.currentUser;
    return user;
  }

  @override
  Future<void> signOut() async{
      
    await fireBaseAuth.signOut();
  }
}
