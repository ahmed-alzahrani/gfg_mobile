import 'package:flutter/material.dart';
import 'package:gfg_mobile/util/themes.dart';

class MatchesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MatchesPageWidgetState();
}

class MatchesPageWidgetState extends State<MatchesPage> {
  final theme = new Themes();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: theme.backIcon,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'My Matches',
          style: theme.textStyle,
        ),
        centerTitle: true,
      ),
    );
  }
}

