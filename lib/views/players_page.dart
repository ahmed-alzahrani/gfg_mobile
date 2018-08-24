import 'package:flutter/material.dart';
import 'dart:async';
import 'package:gfg_mobile/services/auth_service.dart';
import 'package:gfg_mobile/services/data_service.dart';
import 'package:gfg_mobile/views/player_details_page.dart';
import 'package:gfg_mobile/models/player.dart';
import 'package:gfg_mobile/util/themes.dart';

class PlayersPage extends StatefulWidget {
  PlayersPage({ Key key }) : super(key: key);
  @override
  PlayersPageState createState() => new PlayersPageState();
}

class PlayersPageState extends State<PlayersPage>{
  final data = new DataService();
  final auth = new AuthService();
  final theme = new Themes();
  final key = new GlobalKey<ScaffoldState>(); // Key for the search bar
  final TextEditingController _filter = new TextEditingController(); // allows us to check the text in the search bar to filter the players list
  List players = new List(); // list of all players
  List filteredPlayers = new List(); // list of players filtered based on user input
  Widget _appBarTitle;
  Icon _searchIcon;
  String _searchText = "";

  // 0 param constructor that sets the state of the search text based on whether or not the user has input a search query
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


  // retrieve theme info on startup and get players from backend
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
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

  // build the bar with the search bar in it if the search icon is clicked
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
          child: theme.logout,
          onPressed: () {
            auth.signOut();
            Navigator.pushNamed(context, '/logout');
          },
        )
      ],
    );
  }

  // reset to default state
  _searchEnd() {
    setState(() {
      this._searchIcon = theme.searchIcon;
      this._appBarTitle = theme.playerBarTitle;
      filteredPlayers = players;
      _filter.clear();
    });
  }

  // returns a promise that resolves to a list of players available to subscribe to
  Future<void> _getPlayers() async {
    List allPlayers = await data.allPlayers();
    this.setState(() {
      players = allPlayers;
      players.shuffle();
      filteredPlayers = players;
    });
  }

  // converts the players list we retrieved into the actual individual List Tiles populating the list view
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
              filteredPlayers[index]['number'].toString() ?? '0',
              style: theme.textStyle,
            ),
          ),
          onTap: () => _playerTapped(index),
        );
      },
    );
  }

  // constructs the Player information based on the tile tap and passes that to the Navigator to bring up the PlayerDetailsPage
  void _playerTapped(int index) {
    String id = filteredPlayers[index]['id'].toString();
    String name = filteredPlayers[index]['name'];
    String age = filteredPlayers[index]['age'].toString();
    String position = filteredPlayers[index]['position'];
    String team = filteredPlayers[index]['team'].toString();
    String teamName = filteredPlayers[index]['teamName'];
    String league = filteredPlayers[index]['league'];
    int number = filteredPlayers[index]['number'];
    String injured = filteredPlayers[index]['injured'];
    int appearences = filteredPlayers[index]['appearences'];
    int goals = filteredPlayers[index]['goals'];
    int assits = filteredPlayers[index]['assists'];
    int yellowCards = filteredPlayers[index]['yellowcards'];
    int redCards = filteredPlayers[index]['redcards'];

    PlayerStats stats = new PlayerStats(appearences, goals, assits, yellowCards, redCards);
    Player player = new Player(id, name, age, position, team, teamName, league, number, injured, stats);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PlayerDetailsPage(player))
    );
  }

}