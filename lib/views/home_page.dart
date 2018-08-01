import 'package:flutter/material.dart';
import 'package:gfg_mobile/services/auth_service.dart';

class HomePage extends StatelessWidget {
  HomePage(this.onSignedOut);
  final VoidCallback onSignedOut;
  final AuthService auth = new AuthService();

  void _signedOut() async {
    try {
      await auth.signOut();
      onSignedOut();
    } catch (error) {
      print(error);
    }
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Welcome'),
        actions: <Widget>[
          new FlatButton(
            child: new Text('Logout', style: new TextStyle(fontSize: 17.0, color: Colors.white)),
            onPressed: _signedOut,
          )
        ],
      ),
      body: new Container(
        child: new Center(
          child: new Text('Welcome', style: new TextStyle(fontSize: 32.0))
        ),
      )
    );
  }
}