import 'package:flutter/material.dart';
import 'package:gfg_mobile/models/player.dart';

class PlayerDetailsPage extends StatefulWidget {
  PlayerDetailsPage(this.player);
  final Player player;

  @override
  State<StatefulWidget> createState() => PlayerDetailsPageWidgetState(player);
}

class PlayerDetailsPageWidgetState extends State<PlayerDetailsPage> {
  PlayerDetailsPageWidgetState(this.player);
  final Player player;


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(player.name),
        centerTitle: true,
      )
    );
  }
}