import 'package:flutter/material.dart';
import 'package:gfg_mobile/util/themes.dart';

class ProfilePage extends StatelessWidget{
  final theme = new Themes();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: theme.textStyle,
        ),
        centerTitle: true,
      ),
    );
  }
}