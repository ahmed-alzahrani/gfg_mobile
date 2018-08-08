import 'package:flutter/material.dart';
import 'package:gfg_mobile/services/auth_service.dart';
import 'profile_page.dart';
import 'players_page.dart';
import 'charities_page.dart';
import 'matches_page.dart';
import 'about_page.dart';

class HomePage extends StatefulWidget {

  HomePage(this.onSignedOut);
  final VoidCallback onSignedOut;

  @override
  State<StatefulWidget> createState() => HomePageWidgetState(onSignedOut);
}

class HomePageWidgetState extends State<HomePage> {

  HomePageWidgetState(this.onSignedOut);
  final VoidCallback onSignedOut;
  final _bottomNavigationColor = Colors.grey;
  int _currentIndex = 0;
  List<Widget> pages = List();
  final AuthService auth = new AuthService();

  @override
  void initState() {
    pages.add(ProfilePage());
    pages.add(PlayersPage());
    pages.add(CharitiesPage());
    pages.add(MatchesPage());
    pages.add(AboutPage());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      /*
      appBar: new AppBar(
        title: new Text('Welcome'),
        actions: <Widget>[
          new FlatButton(
            child: new Text('Logout', style: new TextStyle(fontSize: 17.0, color: Colors.white)),
            onPressed: _signedOut,
        ],
          )
      ),
      */
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              color: _bottomNavigationColor,
            ),
            title: Text(
              'Profile',
              style: TextStyle(color: _bottomNavigationColor),
            )),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.face,
              color: _bottomNavigationColor,
            ),
            title: Text(
              'Players',
              style: TextStyle(color: _bottomNavigationColor),
            )),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: _bottomNavigationColor,
            ),
            title: Text(
              'Charities',
              style: TextStyle(color: _bottomNavigationColor),
            )),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_today,
              color: _bottomNavigationColor,
            ),
            title: Text(
              'My Matches',
              style: TextStyle(color: _bottomNavigationColor),
            )),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.text_format,
              color: _bottomNavigationColor
            ),
            title: Text(
              'About',
              style: TextStyle(color: _bottomNavigationColor),
            )),
        ],
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.shifting,
      ),
    );
  }
}