import 'package:flutter/material.dart';
import 'package:gfg_mobile/services/auth_service.dart';

class CharitiesPage extends StatelessWidget {
  final auth = new AuthService();

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text('Charities'),
        actions: <Widget>[
          new FlatButton(
            child: new Text('Logout', style: new TextStyle(fontSize: 17.0, color: Colors.white)),
            onPressed: auth.signOut,
          ),
        ]
      ),
    );
  }
}
