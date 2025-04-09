import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User?> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_email', userCredential.user!.email!);

      return userCredential.user;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<User?> signUpWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      throw Exception(e.toString());
    }
  }


  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    // Xóa thông tin đăng nhập
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_email');
    await prefs.setBool('isLoggedIn', false);
  }

  Stream<User?> get userChanges => _firebaseAuth.authStateChanges();
}