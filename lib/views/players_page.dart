import 'package:flutter/material.dart';
import 'dart:async';
import 'package:gfg_mobile/services/auth_service.dart';
import 'package:gfg_mobile/services/data_service.dart';

class PlayersPage extends StatefulWidget {
  @override
  PlayersPageState createState() => new PlayersPageState();
}

class PlayersPageState extends State<PlayersPage>{
  final data = new DataService();
  final auth = new AuthService();
  List players;
  List filteredPlayers;

  @override
  void initState() {
    this._getPlayers();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Players'),
        actions: <Widget>[
          new FlatButton(
            child: new Text('Logout', style: new TextStyle(fontSize: 17.0, color: Colors.white)),
            onPressed: auth.signOut,
          ),
        ],
      ),
      body: Container(
        child: _buildPlayers(),
      )
    );
  }

  Future<String> _getPlayers() async {
    List allPlayers = await data.allPlayers();
    this.setState(() {
      players = allPlayers;
      filteredPlayers = allPlayers;
    });
    return "Completed";
  }


  Widget _buildPlayers() {
    return ListView.builder(
      itemCount: players == null ? 0 : filteredPlayers.length,
      itemBuilder: (BuildContext content, int index) {
        return new ListTile(
          title: Text(filteredPlayers[index]['name']),
          subtitle: Text(filteredPlayers[index]['team']),
          leading: CircleAvatar(child: Text(filteredPlayers[index]['position'][0])),
        );

      },
    );
  }


}