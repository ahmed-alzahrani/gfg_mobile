import 'package:flutter/material.dart';
import 'package:gfg_mobile/util/themes.dart';
import 'package:gfg_mobile/services/auth_service.dart';

class SubscriptionsPage extends StatelessWidget{
  final auth = new AuthService();
  final theme = new Themes();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Subscriptions',
          style: theme.textStyle,
        ),
        actions: <Widget>[
          new FlatButton(
            child: theme.logout,
            onPressed: auth.signOut,
          )
        ],
        centerTitle: true,
      ),
    );
  }
}