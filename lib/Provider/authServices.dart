import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationProvider {
  final FirebaseAuth _firebaseAuth;

  AuthenticationProvider(this._firebaseAuth);
  final FirebaseAuth userAuth = FirebaseAuth.instance;
  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  User getUserId() {
    final User userId = userAuth.currentUser;

    return userId;
  }

  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "True";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> signUp({String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "True";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> googleSignIn() async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      // _firebaseAuth.authStateChanges();

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential);

      return "True";
    } catch (e) {
      return e;
    }
  }

  Future<String> signOut() async {
    await _firebaseAuth.signOut();
    return "signed Out";
  }

  Future<String> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return "True";
    } catch (e) {
      return e;
    }
  }
}
