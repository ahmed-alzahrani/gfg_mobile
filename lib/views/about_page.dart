import 'package:flutter/material.dart';
import 'package:gfg_mobile/services/auth_service.dart';


class AboutPage extends StatelessWidget{
  final auth = new AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
        actions: <Widget>[
          new FlatButton(
            child: new Text('Logout', style: new TextStyle(fontSize: 17.0, color: Colors.white)),
            onPressed: auth.signOut,
          )
        ]
      ),
    );
  }
}