import 'package:firebase_auth/firebase_auth.dart';
import 'package:dio/dio.dart';
import 'dart:async';

// Auth Service handles communication with FirebaseAuth
class AuthService {
  AuthService();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final dio = new Dio(); // dio for our REST requests

  // Makes a call to the GFG-Webapp server to create a new user in the Firestore if FirebaseAuth adds the user successfully to authentication
  void createAccount (String email, String password) async {
    try {
      FirebaseUser user = await auth.createUserWithEmailAndPassword(email: email, password: password);
      print("user: $user");
      Response response = await dio.post(
        "http://10.0.2.2:8080/user/profile",
        data: {
          'uid': user.uid,
          'email': email,
        },
      );
      print(response.data);
    } catch (error) {
      print("error: $error");
    }
  }

  //logs the user into the Firebase Authentication
  void login (String email, String password) async {
    try {
      //TODO: add ios app to Firebase project on mac once xcode is installed
      FirebaseUser user = await auth.signInWithEmailAndPassword(email: email, password: password);
      print("user: $user");
    } catch (error) {
      print("error: $error");
    }
  }

  // queries FirebaseAuth to tell us the uid of the currently logged in user
  Future<String> currentUser () async {
    try {
      FirebaseUser user = await auth.currentUser();
      if (user == null) {
        return "";
      } else {
        return user.uid;
      }
    } catch(error) {
      print("error: $error");
      return "";
    }
  }

  // makes a call to the FirebaseAuth signout
  Future<void> signOut() async {
    auth.signOut();
  }

  // makes a call to send password reset email
  Future<void> passwordReset(String email) async {
    return auth.sendPasswordResetEmail(email: email);
  }

}