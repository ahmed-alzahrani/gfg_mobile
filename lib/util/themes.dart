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

  Widget charitiesBarTitle = new Text(
    'Charities',
    style: new TextStyle(
      color: Colors.limeAccent[700],
    ),
  );

  Widget subscriptionsBarTitle = new Text(
    'Subscriptions',
    style: new TextStyle(
      color: Colors.limeAccent[700],
    ),
  );

  Icon profileIcon = new Icon(Icons.account_circle, color: Colors.limeAccent[700],);
  Icon playersIcon = new Icon(Icons.face, color: Colors.limeAccent[700],);
  Icon charityIcon = new Icon(Icons.favorite, color: Colors.limeAccent[700],);
  Icon subsIcon = new Icon(Icons.format_list_bulleted, color: Colors.limeAccent[700],);
  Icon aboutIcon = new Icon(Icons.text_format, color: Colors.limeAccent[700],);
  Icon searchIcon = new Icon(Icons.search, color: Colors.limeAccent[700],);
  Icon backIcon = new Icon(Icons.arrow_back, color: Colors.limeAccent[700],);
  Icon matchesIcon = new Icon(Icons.calendar_today, color: Colors.limeAccent[700]);
  Icon editIcon = new Icon(Icons.save, color: Colors.lime[700],);

  Text logout = new Text('Logout', style: new TextStyle(fontSize: 17.0, color: Colors.limeAccent[700]));
}