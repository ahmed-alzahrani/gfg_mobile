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
  int _currentIndex = 0;
  List<Widget> pages = List();
  final AuthService auth = new AuthService();

  final _textColor = Colors.limeAccent[700];
  final _textStyle = new TextStyle(
    color: Colors.limeAccent[700],
  );

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
      body: pages[_currentIndex],
      bottomNavigationBar: new Theme(
        data: new ThemeData(
          canvasColor: Colors.black,
        ),
        child: new BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_circle,
                  color: _textColor,
                ),
                title: Text(
                    'Profile',
                    style: _textStyle,
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.face,
                  color: _textColor,
                ),
                title: Text(
                  'Players',
                  style: _textStyle,
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                  color: _textColor,
                ),
                title: Text(
                    'Charities',
                    style: _textStyle,
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.calendar_today,
                  color: _textColor,
                ),
                title: Text(
                  'My Matches',
                  style: _textStyle,
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.text_format,
                  color: _textColor,
                ),
                title: Text(
                  'About',
                  style: _textStyle,
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
      ),
    );
  }
}

/*
bottomNavigationBar: new Theme(
  data: Theme.of(context).copyWith(
    // sets the background color of the `BottomNavigationBar`
    canvasColor: Colors.green,
    // sets the active color of the `BottomNavigationBar` if `Brightness` is light
    primaryColor: Colors.red,
    textTheme: Theme
      .of(context)
      .textTheme
      .copyWith(caption: new TextStyle(color: Colors.yellow))), // sets the inactive color of the `BottomNavigationBar`
  child: new BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    currentIndex: 0,
    items: [
      new BottomNavigationBarItem(
        icon: new Icon(Icons.add),
        title: new Text("Add"),
      ),
      new BottomNavigationBarItem(
        icon: new Icon(Icons.delete),
        title: new Text("Delete"),
       )
      ],
    ),
),
*/
