import 'package:flutter/material.dart';
import 'dart:async';
import 'package:gfg_mobile/services/auth_service.dart';
import 'package:gfg_mobile/services/data_service.dart';
import 'package:gfg_mobile/views/player_details_page.dart';
import 'package:gfg_mobile/models/player.dart';

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
        centerTitle: true,
        actions: <Widget>[
          new FlatButton(
            child: new Text('Logout', style: new TextStyle(fontSize: 17.0, color: Colors.white)),
            onPressed: () {
              auth.signOut();
              Navigator.pushReplacementNamed(context, '/logout');
            },
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
          onTap: () => _playerTapped(index),
        );

      },
    );
  }

  void _playerTapped(int index) {
    String id = filteredPlayers[index]['id'];
    String name = filteredPlayers[index]['name'];
    String age = filteredPlayers[index]['age'];
    String position = filteredPlayers[index]['position'];
    String team = filteredPlayers[index]['team_id'];
    String teamName = filteredPlayers[index]['team'];
    String league = filteredPlayers[index]['league'];
    Player player = new Player(id, name, age, position, team, teamName, league);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PlayerDetailsPage(player))
    );
  }
}