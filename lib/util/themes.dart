import 'package:flutter/material.dart';

class Themes {
  Themes();
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

  Icon searchIcon = new Icon(Icons.search, color: Colors.limeAccent[700],);
}