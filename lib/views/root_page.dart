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
  signedIn,
  notSignedIn
}

class _RootPageState extends State<RootPage> {
  AuthStatus _authStatus = AuthStatus.notSignedIn;

  initState() {
    super.initState();
    widget.auth.currentUser().then((userId) {
      setState(() {
        _authStatus = userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  void _signedIn() {
    setState(() {
      _authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      _authStatus = AuthStatus.notSignedIn;
    });
  }


  @override
  Widget build(BuildContext context) {
    switch (_authStatus) {
      case AuthStatus.signedIn:
        return new HomePage(_signedOut);
      default:
        return new LoginPage(_signedIn);
    }
  }
}