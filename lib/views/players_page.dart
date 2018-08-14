import 'package:flutter/material.dart';
import 'dart:async';
import 'package:gfg_mobile/services/auth_service.dart';
import 'package:gfg_mobile/services/data_service.dart';
import 'package:gfg_mobile/views/player_details_page.dart';
import 'package:gfg_mobile/models/player.dart';
import 'package:gfg_mobile/util/themes.dart';

//TODO: POST ABOUT / FIGURE OUT KEYBOARD BLOCKING ISSUE

class PlayersPage extends StatefulWidget {
  PlayersPage({ Key key }) : super(key: key);
  @override
  PlayersPageState createState() => new PlayersPageState();
}

class PlayersPageState extends State<PlayersPage>{
  final formKey = new GlobalKey<FormState>();
  final data = new DataService();
  final auth = new AuthService();
  final theme = new Themes();
  final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _filter = new TextEditingController();
  List players = new List();
  List filteredPlayers = new List();
  Widget _appBarTitle;
  Icon _searchIcon;
  String _searchText = "";

  PlayersPageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredPlayers = players;
        });
      }
      else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }


  @override
  void initState() {
    _searchIcon = theme.searchIcon;
    _appBarTitle = theme.playerBarTitle;
    this._getPlayers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildBar(context),
      body: Container(
        child: _buildPlayers(),
      )
    );
  }

  Widget buildBar(BuildContext context) {
    return new AppBar(
      centerTitle: true,
      title: _appBarTitle,
      leading: new IconButton(icon: _searchIcon, onPressed: () {
        setState(() {
          if (this._searchIcon.icon == Icons.search) {
            this._searchIcon = new Icon(Icons.close, color: theme.textColor);
            this._appBarTitle = new TextField(
              controller: _filter,
              style: new TextStyle(
                color: theme.textColor,
              ),
              decoration: new InputDecoration(
                  prefixIcon: new Icon(Icons.search, color: theme.textColor,),
                  hintText: 'Search...',
                  hintStyle: new TextStyle(color: theme.textColor)
              ),
            );
          } else {
            _searchEnd();
          }
        });
      }),
      actions: <Widget>[
        new FlatButton(
          child: new Text('Logout', style: new TextStyle(fontSize: 17.0, color: theme.textColor),),
          onPressed: auth.signOut,
        )
      ],
    );
  }

  _searchEnd() {
    setState(() {
      this._searchIcon = theme.searchIcon;
      this._appBarTitle = theme.playerBarTitle;
      this._appBarTitle = theme.playerBarTitle;
      _filter.clear();
    });
  }

  Future<void> _getPlayers() async {
    List allPlayers = await data.allPlayers();
    this.setState(() {
      players = allPlayers;
      players.shuffle();
      filteredPlayers = players;
    });
    return;
  }

  Widget _buildPlayers() {
    if (!(_searchText.isEmpty)) {
      List tempList = new List();
      for (int i = 0; i < filteredPlayers.length; i++) {
        if (filteredPlayers[i]['name'].toLowerCase().contains(_searchText.toLowerCase()) || filteredPlayers[i]['teamName'].toLowerCase().contains(_searchText.toLowerCase()) || filteredPlayers[i]['league'].toLowerCase().contains(_searchText.toLowerCase())) {
          tempList.add(filteredPlayers[i]);
        }
      }
      filteredPlayers = tempList;
    }
    return ListView.builder(
      itemCount: players == null ? 0 : filteredPlayers.length,
      itemBuilder: (BuildContext context, int index) {
        return new ListTile(
          title: Text(
            filteredPlayers[index]['name'],
            style: theme.textStyle,
          ),
          subtitle: Text(
            filteredPlayers[index]['teamName'],
            style: theme.textStyle,
          ),
          leading: CircleAvatar(
            backgroundColor: Colors.black,
            child: Text(
              filteredPlayers[index]['number'] ?? '0',
              style: theme.textStyle,
            ),
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
    String team = filteredPlayers[index]['team'];
    String teamName = filteredPlayers[index]['teamName'];
    String league = filteredPlayers[index]['league'];
    int number = int.parse(filteredPlayers[index]['number']);
    String injured = filteredPlayers[index]['injured'];
    int appearences = int.parse(filteredPlayers[index]['appearences']);
    int goals = int.parse(filteredPlayers[index]['goals']);
    int assits = int.parse(filteredPlayers[index]['assists']);
    int yellowCards = int.parse(filteredPlayers[index]['yellowcards']);
    int redCards = int.parse(filteredPlayers[index]['redcards']);

    Stats stats = new Stats(appearences, goals, assits, yellowCards, redCards);
    Player player = new Player(id, name, age, position, team, teamName, league, number, injured, stats);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PlayerDetailsPage(player))
    );
  }

}