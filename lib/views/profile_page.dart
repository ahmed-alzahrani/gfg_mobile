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
  String _first = "";
  final firstController = TextEditingController();
  String _last = "";
  final lastController = TextEditingController();
  String _email = "";
  String _birthday = "";
  String _country = "";


  @override
  void initState() {
    _getProfile();
    auth.currentUser();
    super.initState();
  }

  @override
  void dispose() {
    firstController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),
      body: new Column(
        children: _buildForm(),
      ),
      resizeToAvoidBottomPadding: true,
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

  List<Widget> _buildForm() {
    return [
      new Flexible(
        child: new ListTile(
          leading: new Text(
            'First',
            style: theme.textStyle,
          ),
          title: new TextField(
            controller: firstController,
            decoration: new InputDecoration(
              hintText: _first,
              hintStyle: theme.textStyle,
            ),
          ),
        ),
      ),
      new Flexible(
        child: new ListTile(
          leading: new Text(
            'Last',
            style: theme.textStyle,
          ),
          title: new TextField(
            controller: lastController,
            decoration: new InputDecoration(
              hintText: _last,
              hintStyle: theme.textStyle,
            ),
          ),
        ),
      ),
      new Flexible(
        child: new ListTile(
          leading: new Text(
            'E-mail',
            style: theme.textStyle,
          ),
          title: new Text(
            _email,
            style: new TextStyle(
              color: theme.textColor,
            ),
          ),
        ),
      ),
      const Divider(
        height: 1.0,
      ),

    ];
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

      setState(() {
        _birthday = response.data['birthday'];
        _country = response.data['country'];
        _email = response.data['email'];
        _first = response.data['first'];
        _last = response.data['last'];
        user = new Profile(_birthday, _country, _email, _first, _last, stats);

      });
    } catch (error) {
      throw '$error';
    }
  }


}