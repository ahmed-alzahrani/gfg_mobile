import 'package:flutter/material.dart';
import 'package:gfg_mobile/views/root_page.dart';
import 'util/themes.dart';

void main() {
  runApp(new App());
}

class App extends StatelessWidget {
  final theme = new Themes();
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'gfg_mobile',
      theme: new ThemeData(
        scaffoldBackgroundColor: theme.backgroundColor, // ACTUAL background color of the scaffold, // this is the color of the appBar, and parts of the listviews
        primaryColor: theme.primaryColor, // overrides primary swatch as color of appBar
        buttonColor: theme.buttonColor, // the color of raised buttons, including the button to visit the charity websites
      ),
      home: new RootPage(),
      routes: {
        '/logout': (_) => new RootPage(),
      },
    );
  }

}