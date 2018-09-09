import 'package:flutter/material.dart';
import 'package:gfg_mobile/services/auth_service.dart';
import 'profile_page.dart';
import 'players_page.dart';
import 'charities_page.dart';
import 'subscriptions_page.dart';
import 'about_page.dart';
import 'package:gfg_mobile/util/themes.dart';

class HomePage extends StatefulWidget {

  HomePage(this.onSignedOut, this.index);
  // on signed out callback to take us back to the Root page except to Login instead
  final VoidCallback onSignedOut;
  final int index;

  @override
  State<StatefulWidget> createState() => HomePageWidgetState(onSignedOut, index);
}

class HomePageWidgetState extends State<HomePage> {
  HomePageWidgetState(this.onSignedOut, this.entryIndex);
  final VoidCallback onSignedOut;
  int entryIndex;
  int _currentIndex; // index of the currently selected view from the bottom navigation bar
  List<Widget> pages = List(); // the 5 different options in the bottom navigation bar
  final AuthService auth = new AuthService();
  final theme = new Themes();

  // on Initialization we want to add all of our pages to the list that populates the nav bar
  @override
  void initState() {
    _currentIndex = entryIndex;
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
      body: pages[_currentIndex], // defaults to profile page but changes as the user navigates
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
              _currentIndex = index; // resets the state but with current index as the tapped index, meaning the body of the scaffold will be the desired page
            });
          },
          type: BottomNavigationBarType.shifting,
        ),
      ),
    );
  }
}
