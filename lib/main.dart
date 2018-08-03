import 'package:flutter/material.dart';
import 'package:gfg_mobile/views/root_page.dart';

void main() {
  runApp(new App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'gfg_mobile',
      theme: new ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: new RootPage(),
    );
  }

}