import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:gfg_mobile/services/auth_service.dart';
import 'package:gfg_mobile/views/home_page.dart';

class RootPage extends StatefulWidget {
  final auth = new AuthService();

  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

enum AuthStatus {
  createAccount,
  signedIn,
  notSignedIn
}

class _RootPageState extends State<RootPage> {
  AuthStatus _authStatus = AuthStatus.notSignedIn;

  initState() {
    super.initState();
    widget.auth.currentUser().then((userId) {
      setState(() {
        _authStatus = userId == '' ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  void _createAccount() {
    setState(() {
      _authStatus = AuthStatus.createAccount;
    });
  }
  void _signedIn() {
    setState(() {
     // _index = index;
      _authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      _authStatus = AuthStatus.notSignedIn;
    });
  }


  // returns either the home page or the login page based on whether or not the user is logged in
  @override
  Widget build(BuildContext context) {
    switch (_authStatus) {
      case AuthStatus.signedIn:
        return new HomePage(_signedOut, 0);
      case AuthStatus.createAccount:
        return new HomePage(_signedOut, 4);
      default:
        return new LoginPage(_signedIn, _createAccount);
    }
  }
}