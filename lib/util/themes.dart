import 'package:flutter/material.dart';

// class to hold UI information, centralizes it and makes it so any theme changes / future dynamic themes or night mode / day mode feature can be built out of one class
// current working, may change in future as wisdom comes to me
class Themes {
  // The theme is a grey background, with a black secondary on the top/bottom bars and lime accent writing
  Themes();
  final backgroundColor = Colors.grey[850];
  final primaryColor = Colors.black;
  final buttonColor = Colors.black;
  final textColor = Colors.limeAccent[700];
  final textStyle = new TextStyle(
    color: Colors.limeAccent[700],
  );

  // Also store widgets and icons that don't change here, as they belong with other cosnt UI elements imo

  Widget profileBarTitle = new Text(
    'Profile',
    style: new TextStyle(
      color: Colors.limeAccent[700],
    ),
  );
  Widget loginBarTitle = new Text(
    'Login',
    style: new TextStyle(
      color: Colors.limeAccent[700],
    ),
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

  Widget matchesBarTitle = new Text(
    'Matches',
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

  // also keeping this here as the Logout button is on many pages but the onTap needs to stay in auth, and i dont want auth as a dependency here
  Text logout = new Text('Logout', style: new TextStyle(fontSize: 17.0, color: Colors.limeAccent[700]));
}