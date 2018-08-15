import 'package:flutter/material.dart';
import 'package:gfg_mobile/services/auth_service.dart';
import 'profile_page.dart';
import 'players_page.dart';
import 'charities_page.dart';
import 'subscriptions_page.dart';
import 'about_page.dart';
import 'package:gfg_mobile/util/themes.dart';

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
  final theme = new Themes();

  @override
  void initState() {
    pages.add(ProfilePage());
    pages.add(PlayersPage());
    pages.add(CharitiesPage());
    pages.add(SubscriptionsPage());
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
                icon: theme.profileIcon,
                title: Text(
                    'Profile',
                    style: theme.textStyle,
                )),
            BottomNavigationBarItem(
                icon: theme.playersIcon,
                title: Text(
                  'Players',
                  style: theme.textStyle,
                )),
            BottomNavigationBarItem(
                icon: theme.charityIcon,
                title: Text(
                    'Charities',
                    style: theme.textStyle,
                )),
            BottomNavigationBarItem(
                icon: theme.subsIcon,
                title: Text(
                  'Subscriptions',
                  style: theme.textStyle,
                )),
            BottomNavigationBarItem(
                icon: theme.aboutIcon,
                title: Text(
                  'About',
                  style: theme.textStyle,
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
