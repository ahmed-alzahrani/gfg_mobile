import 'package:flutter/material.dart';
import 'package:gfg_mobile/services/auth_service.dart';

class Themes {
  Themes();
  final auth = new AuthService();
  final backgroundColor = Colors.grey[850];
  final primaryColor = Colors.black;
  final buttonColor = Colors.black;
  final textColor = Colors.limeAccent[700];
  final textStyle = new TextStyle(
    color: Colors.limeAccent[700],
  );

  Widget playerBarTitle = new Text(
    'Players',
    style: new TextStyle(
      color: Colors.limeAccent[700],
    ),
  );

  Widget charitiesBarTitle = new Text(
    'Charities',
    style: new TextStyle(
      color: Colors.limeAccent[700],
    ),
  );

  Icon searchIcon = new Icon(Icons.search, color: Colors.limeAccent[700],);

  Icon backIcon = new Icon(Icons.arrow_back, color: Colors.limeAccent[700],);

  Text logout = new Text('Logout', style: new TextStyle(fontSize: 17.0, color: Colors.limeAccent[700]));
}