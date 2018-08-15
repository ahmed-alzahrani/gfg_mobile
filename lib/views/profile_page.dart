import 'package:flutter/material.dart';
import 'package:gfg_mobile/util/themes.dart';
import 'package:gfg_mobile/services/auth_service.dart';
import 'package:gfg_mobile/views/matches_page.dart';
import 'package:dio/dio.dart';
import 'package:gfg_mobile/models/profile.dart';

class ProfilePage extends StatefulWidget {
  @override State<StatefulWidget> createState() => ProfilePageWidgetState();
}

class ProfilePageWidgetState extends State<ProfilePage> {
  final auth = new AuthService();
  final theme = new Themes();
  final dio = new Dio();
  Profile user;


  @override
  void initState() {
    _getProfile();
    auth.currentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),
      body: new Container(
        child: new RaisedButton(
          child: new Text(
            'press',
            style: new TextStyle(
              color: theme.textColor,
            )
          ),
            onPressed: () {
              _showProfile();
            }
        ),
      ),
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar (
      leading: new IconButton(
        icon: theme.matchesIcon,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MatchesPage())
          );
        },
      ),
      title: new Text(
        'Profile',
        style: theme.textStyle,
      ),
      actions: <Widget>[
        new FlatButton(
          child: theme.logout,
          onPressed: auth.signOut,
        ),
      ],
      centerTitle: true,
    );
  }

  void _getProfile() async {
    final uid = await auth.currentUser();
    try {
      String url = 'http://10.0.2.2:8080/profile/' + uid;
      final response = await dio.get(url);

      List<Goal> goals = new List();
      for (int i = 0; i < response.data['stats']['allGoals'].length; i++) {
        String charityName = response.data['stats']['allGoals'][i]['charityName'];
        String charity = response.data['stats']['allGoals'][i]['charity'];
        String player = response.data['stats']['allGoals'][i]['player'];
        String playerName = response.data['stats']['allGoals'][i]['playerName'];
        String teamName = response.data['stats']['allGoals'][i]['charityName'];
        String team = response.data['stats']['allGoals'][i]['charityName'];
        String time = response.data['stats']['allGoals'][i]['charityName'];
        Goal goal = new Goal(charityName, charity, player, playerName, teamName, team, time);
        goals.add(goal);
      }
      UserStats stats = new UserStats(response.data['stats']['topScorer'], goals, response.data['stats']['charities'], response.data['stats']['topCharity'], response.data['stats']['scorers'], response.data['stats']['goals']);
      user = new Profile(response.data['birthday'], response.data['country'], response.data['email'], response.data['first'], response.data['last'], stats);
    } catch (error) {
      throw '$error';
    }
  }

  void _showProfile() {
    print(user.email);
  }

}