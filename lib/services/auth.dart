import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:sitecheck3/models/user.dart';

class AuthService {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  String errorMsg = "";

  // sign in anon
  Future signInAnon() async {
    try {
      print('1');
      auth.UserCredential result = await _auth.signInAnonymously();
      auth.User user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  User _userFromFirebaseUser(auth.User user) {
    return user != null ? User(uid: user.uid, username: user.email) : null;
  }

  Future<String> username() async {
    String emailDt = _auth.currentUser.email;

    return emailDt;
  }

  Stream<User> get user {
    return _auth.authStateChanges().asyncMap(_userFromFirebaseUser);
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      auth.UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      auth.User user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      auth.UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      auth.User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<void> resetPassword(String email) {
    return _auth.sendPasswordResetEmail(email: email);
  }
}
