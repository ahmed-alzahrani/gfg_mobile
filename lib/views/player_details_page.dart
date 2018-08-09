import 'package:flutter/material.dart';
import 'package:gfg_mobile/models/player.dart';
import 'package:gfg_mobile/services/subscription_service.dart';
import 'package:gfg_mobile/services/data_service.dart';
import 'package:flutter/cupertino.dart';

class PlayerDetailsPage extends StatefulWidget {
  PlayerDetailsPage(this.player);
  final Player player;

  @override
  State<StatefulWidget> createState() => PlayerDetailsPageWidgetState(player);
}

enum subscribed {
  subbed,
  notSubbed
}

class PlayerDetailsPageWidgetState extends State<PlayerDetailsPage> {
  PlayerDetailsPageWidgetState(this.player);
  final Player player;
  final sub = new SubscriptionService();
  final data = new DataService();
  subscribed _subbed;
  List charities = [];
  int _selectedIndex;

  @override
  void initState() {
    _setSubscriptionStatus();
    super.initState();
  }

  void _setSubscriptionStatus() async {
    bool result = await sub.checkSubscription(player.id);
    charities = await data.charities();
    setState(() {
      if (result) {
        _subbed = subscribed.subbed;
      } else {
        _subbed = subscribed.notSubbed;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(player.name),
        centerTitle: true,
        actions: _buildButton()
      ),
      body: new Container(
        padding: EdgeInsets.all(16.0),
        child: new CupertinoPicker(
            itemExtent: 20.0,
            backgroundColor: Colors.white,
            onSelectedItemChanged: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            children: new List<Widget>.generate(charities.length ?? 0, (int index) {
              return new Center(
                child: new Text(charities[index]['name']),
              );
            })
        )
      )
    );
  }

  List<Widget> _buildButton() {
    if (_subbed == null) {
      return [];
    }
    if (_subbed == subscribed.subbed) {
      return [
        new FlatButton(
          child: new Text('Unsubscribe', style: new TextStyle(fontSize: 17.0, color: Colors.white)),
          onPressed: _unsubscribeTapped,
        )
      ];
    } else {
      return [
        new FlatButton(
          child: new Text('Subscribe', style: new TextStyle(fontSize: 17.0, color: Colors.white)),
          onPressed: _subscribeTapped
        )
      ];
    }
  }

  void _subscribeTapped() async {
    bool result = await sub.addSubscription(player.id, player.name, player.team, player.teamName, charities[_selectedIndex]['name'], charities[_selectedIndex]['id']);
    if (result) {
      _subbed = subscribed.subbed;
      setState(() {});
    }
  }

  void _unsubscribeTapped() async {
    bool result = await sub.removeSubscription(player.id);
    if (result) {
      _subbed = subscribed.notSubbed;
      setState(() {});
    }
  }
}