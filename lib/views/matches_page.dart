import 'package:flutter/material.dart';
import 'package:gfg_mobile/util/themes.dart';

class MatchesPage extends StatelessWidget{
  final theme = new Themes();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Matches',
          style: theme.textStyle,
        ),
        centerTitle: true,
      ),
    );
  }
}