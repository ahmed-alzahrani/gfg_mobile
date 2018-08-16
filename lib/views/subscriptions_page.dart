import 'package:flutter/material.dart';
import 'package:gfg_mobile/util/themes.dart';
import 'package:gfg_mobile/services/auth_service.dart';
import 'package:gfg_mobile/services/data_service.dart';
import'package:gfg_mobile/services/subscription_service.dart';
import 'dart:async';
import 'package:gfg_mobile/models/subscription.dart';
import 'package:gfg_mobile/views/subscription_details_page.dart';

class SubscriptionsPage extends StatefulWidget {
  SubscriptionsPage({ Key key }) : super(key: key);

  @override
  SubscriptionsPageState createState() => new SubscriptionsPageState();
}

class SubscriptionsPageState extends State<SubscriptionsPage>{
  final auth = new AuthService();
  final data = new DataService();
  final sub = new SubscriptionService();
  final theme = new Themes();
  final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _filter = new TextEditingController();
  List subscriptions = new List();
  List filteredSubscriptions = new List();
  Widget _appBarTitle;
  Icon _searchIcon;
  String _searchText = "";

  SubscriptionsPageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredSubscriptions = subscriptions;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  @override
  void initState() {
    _searchIcon = theme.searchIcon;
    _appBarTitle = theme.subscriptionsBarTitle;
    this._getSubscriptions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),
      body: Container(
        child: _buildSubscriptions(),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      centerTitle: true,
      title: _appBarTitle,
      leading: new IconButton(icon: _searchIcon, onPressed: () {
        setState(() {
          if (this._searchIcon.icon == Icons.search) {
            this._searchIcon = new Icon(Icons.close, color: theme.textColor,);
            this._appBarTitle = new TextField(
              controller: _filter,
              style: new TextStyle(
                color: theme.textColor,
              ),
              decoration: new InputDecoration(
                prefixIcon: new Icon(Icons.search, color: theme.textColor,),
                hintText: 'Search...',
                hintStyle: theme.textStyle,
              ),
            );
          } else {
            setState(() {
              this._searchIcon = theme.searchIcon;
              this._appBarTitle = theme.playerBarTitle;
              filteredSubscriptions = subscriptions;
              _filter.clear();
            });
          }
        });
      }),
      actions: <Widget>[
        new FlatButton(
          child: theme.logout,
          onPressed: auth.signOut,
        )
      ],
    );
  }

  Future<void> _getSubscriptions () async {
    List allSubs = await data.subscriptions();
    setState(() {
      print(allSubs);
      subscriptions = allSubs;
      subscriptions.shuffle();
      filteredSubscriptions = subscriptions;
    });
    return;
  }

  Widget _buildSubscriptions() {
    if (!(_searchText.isEmpty)) {
      List tempList = new List();
      for (int i = 0; i < filteredSubscriptions.length; i++) {
        if (filteredSubscriptions[i]['charity'].toLowerCase().contains(_searchText.toLowerCase()) || filteredSubscriptions[i]['name'].toLowerCase().contains(_searchText.toLowerCase()) || filteredSubscriptions[i]['team'].toLowerCase().contains(_searchText.toLowerCase())) {
          tempList.add(filteredSubscriptions[i]);
        }
      }
      filteredSubscriptions = tempList;
    }
    return ListView.builder(
      itemCount: subscriptions == null ? 0 : filteredSubscriptions.length,
      itemBuilder: (BuildContext context, int index) {
        return new ListTile(
          title: Text(
            filteredSubscriptions[index]['name'],
            style: theme.textStyle,
          ),
          subtitle: Text(
            filteredSubscriptions[index]['charity'],
            style: theme.textStyle,
          ),
          leading: CircleAvatar(
            backgroundColor: Colors.black,
            child: Text(
              (index + 1).toString(),
              style: theme.textStyle,
            ),
          ),
          onTap: () => _subTapped(index),
        );
      },
    );
  }

  void _subTapped(int index) {
    String charity = filteredSubscriptions[index]['charity'];
    String charityId = filteredSubscriptions[index]['charityId'];
    int goals = filteredSubscriptions[index]['goals'];
    String name = filteredSubscriptions[index]['name'];
    String teamName = filteredSubscriptions[index]['teamName'];
    String time = filteredSubscriptions[index]['time'];
    Subscription sub = new Subscription(charity, charityId, goals, name, teamName, time);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SubscriptionDetailsPage(sub))
    );

  }

}