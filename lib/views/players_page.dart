import 'package:flutter/material.dart';
import 'dart:async';
import 'package:gfg_mobile/services/auth_service.dart';
import 'package:gfg_mobile/services/data_service.dart';
import 'package:gfg_mobile/views/player_details_page.dart';
import 'package:gfg_mobile/models/player.dart';
import 'package:gfg_mobile/util/themes.dart';

class PlayersPage extends StatefulWidget {
  @override
  PlayersPageState createState() => new PlayersPageState();
}

class PlayersPageState extends State<PlayersPage>{
  final data = new DataService();
  final auth = new AuthService();
  final theme = new Themes();
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
        title: Text(
          'Players',
          style: theme.textStyle,
        ),
        centerTitle: true,
        actions: <Widget>[
          new FlatButton(
            child: new Text('Logout', style: new TextStyle(fontSize: 17.0, color: theme.textColor)),
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
          title: Text(
            filteredPlayers[index]['name'],
            style: theme.textStyle,
          ),
          subtitle: Text(
            filteredPlayers[index]['team'],
            style: theme.textStyle,
          ),
          leading: CircleAvatar(
              backgroundColor: Colors.black,
              child: Text(
                filteredPlayers[index]['position'][0],
                style: theme.textStyle,
              )
          ),
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