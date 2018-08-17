import 'package:flutter/material.dart';
import 'package:gfg_mobile/util/themes.dart';
import 'package:gfg_mobile/services/auth_service.dart';
import 'package:gfg_mobile/services/data_service.dart';
import 'package:gfg_mobile/views/matches_page.dart';
import 'package:dio/dio.dart';
import 'package:gfg_mobile/models/profile.dart';

class ProfilePage extends StatefulWidget {
  @override State<StatefulWidget> createState() => ProfilePageWidgetState();
}

class ProfilePageWidgetState extends State<ProfilePage> {
  GlobalKey<FormState> _key = new GlobalKey();
  final auth = new AuthService();
  final theme = new Themes();
  final data = new DataService();
  final dio = new Dio();
  Profile user;
  String _first = "";
  String _last = "";
  String _email = "";
  String _birthday = "";
  String _country = "";
  String _topScorer = "";
  String _topCharity = "";
  final _firstController = TextEditingController();
  final _lastController = TextEditingController();
  List countries = new List();

  @override
  void initState() {
    _getProfile();
    _getCountries();
    super.initState();
  }

  @override
  void dispose() {
    _firstController.dispose();
    _lastController.dispose;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),
      body: new SingleChildScrollView(
        child: new Container(
          margin: new EdgeInsets.all(15.0),
          child: new Form(
            key: _key,
            child: _buildForm(),
          ),
        ),
      ),
      resizeToAvoidBottomPadding: false,
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

  Widget _buildForm() {
    return new Column(
      children: <Widget>[
        new ListTile(
          leading: new Text(
            'First:',
            style: theme.textStyle,
          ),
          title: new TextField(
            style: theme.textStyle,
            controller: _firstController,
            decoration: new InputDecoration(
              hintText: _first,
              hintStyle: theme.textStyle,
            ),
          ),
        ),
        new ListTile(
          leading: new Text(
            'Last:',
            style: theme.textStyle,
          ),
          title: new TextField(
            style: theme.textStyle,
            controller: _lastController,
            decoration: new InputDecoration(
              hintStyle: theme.textStyle,
              hintText: _last,
            ),
          ),
        ),
        new ListTile(
          leading: new Text(
            'E-mail:',
            style: theme.textStyle,
          ),
          title: new Text(
            _email,
            style: TextStyle(
              color: theme.textColor,
              fontSize: 10.0,
            ),
          ),
          trailing: new FlatButton(
            child: Text('Password Reset'),
            onPressed: () => print('you wanted to reset password'),
            color: Colors.red,
            textColor: Colors.white,
          ),
        ),
        new ListTile(
          leading: new Text(
            "Top Scorer:",
            style: theme.textStyle,
          ),
          title: _buildTopScorer(),
        ),
        new ListTile(
          leading: new Text(
            "Top Charity:",
            style: theme.textStyle,
          ),
          title: _buildTopCharity(),
        ),
        // _buildTopCharity(),
        _buildDropDown(),
        _buildSubmitButton(),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return new RaisedButton(
      child: Text('Submit Changes'),
      color: Colors.black,
      textColor: theme.textColor,
      onPressed: _submitPressed,
    );
  }

  Widget _buildTopScorer() {
    String hint = "";
    if (_topScorer == "") {
      hint = "No Goals Yet";
    } else {
      hint = _topScorer;
    }
    return new Text(
      hint,
      style: theme.textStyle,
    );
  }

  Widget _buildTopCharity() {
    String hint = "";
    if (_topCharity == "") {
      hint = "No Goals Yet";
    } else {
      hint = _topScorer;
    }
    return new Text(
      hint,
      style: theme.textStyle,
    );
  }


  Widget _buildDropDown() {
    return new Container(
      child: DropdownButton(
        items: new List<DropdownMenuItem>.generate(countries.length ?? 0, (int index) {
          return new DropdownMenuItem(
            child: Text(countries[index]),
            value: index,
          );
        }),
        hint: _getHint(),
        onChanged: (value) {
          print('you tapped ${countries[value]}');
          setState(() {
            _country = countries[value];
          });
        },
      ),
      padding: EdgeInsets.only(
        top: 50.0,
        bottom: 50.0,
      ),
    );
  }

  Widget _getHint() {
    String data = "";
    if (_country == "") {
      data = "Country of Residence";
    } else {
      data = _country;
    }
    return Text(
      data,
      style: theme.textStyle,
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

      String topScorer = response.data['stats']['topScorer'];
      String topCharity = response.data['stats']['topCharity'];
      UserStats stats = new UserStats(topScorer, goals, response.data['stats']['charities'], topCharity, response.data['stats']['scorers'], response.data['stats']['goals']);

      setState(() {
        if (!(response.data['country'] == "")) {
          _country = response.data['country'];
        }
        _birthday = response.data['birthday'];
        _email = response.data['email'];
        _first = response.data['first'];
        _last = response.data['last'];
        _topScorer = topScorer;
        _topCharity = topCharity;

        user = new Profile(_birthday, _country, _email, _first, _last, stats);

      });
    } catch (error) {
      throw '$error';
    }
  }

  void _getCountries() async {
    List allCountries = await data.countries();
    countries = allCountries;
  }

  void _submitPressed() async {
    String first = _first;
    String last = _last;
    String country = user.country;

    if (_firstController.text != "" && _firstController.text!= first) {
      first = _firstController.text;
    }

    if (_lastController.text != "" && _lastController.text!= last) {
      last = _lastController.text;
    }

    if (_country != user.country && _country != country) {
      country = _country;
    }

    bool result = await data.updateProfile(first, last, country);

    if (result) {
      setState(() {
        _getProfile();
      });
    }
  }


}