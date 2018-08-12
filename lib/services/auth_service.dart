import 'package:firebase_auth/firebase_auth.dart';
import 'package:dio/dio.dart';
import 'dart:async';

class AuthService {
  AuthService();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final dio = new Dio();

  void createAccount (String email, String password) async {
    try {
      FirebaseUser user = await auth.createUserWithEmailAndPassword(email: email, password: password);
      print("user: $user");
      Response response = await dio.post(
        "http://10.0.2.2:8080/addUser",
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

  void login (String email, String password) async {
    try {
      //TODO: add ios app to Firebase project on mac once xcode is installed
      FirebaseUser user = await auth.signInWithEmailAndPassword(email: email, password: password);
      print("user: $user");
    } catch (error) {
      print("error: $error");
    }
  }

  Future<String> currentUser () async {
    try {
      FirebaseUser user = await auth.currentUser();
      if (user == null) {
        return null;
      } else {
        return user.uid;
      }
    } catch(error) {
      print("error: $error");
      return null;
    }
  }

  Future<void> signOut() async {
    auth.signOut();
  }

  Future<void> passwordReset(String email) async {
    return auth.sendPasswordResetEmail(email: email);
  }

}