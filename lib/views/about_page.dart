import 'package:flutter/material.dart';
import 'package:gfg_mobile/services/auth_service.dart';
import 'package:gfg_mobile/util/themes.dart';


class AboutPage extends StatelessWidget{
  final auth = new AuthService();
  final theme = new Themes();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About',
          style: theme.textStyle,
        ),
        centerTitle: true,
        actions: <Widget>[
          new FlatButton(
            child: new Text('Logout', style: new TextStyle(fontSize: 17.0, color: theme.textColor)),
            onPressed: auth.signOut,
          )
        ]
      ),
    );
  }
}