import 'package:flutter/material.dart';
import 'package:gfg_mobile/models/player.dart';
import 'package:gfg_mobile/services/subscription_service.dart';
import 'package:gfg_mobile/services/data_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:gfg_mobile/util/themes.dart';

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
  final theme = new Themes();
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
        leading: new IconButton(
            icon: new Icon(
              Icons.arrow_back,
              color: theme.textColor,
            ),
            onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          player.name,
          style: theme.textStyle,
        ),
        centerTitle: true,
        actions: _buildButton()
      ),
      body: new Container(
        padding: EdgeInsets.only(
          top: 20.0,
        ),
        child: new Column(
          children: [
            //TODO: Implement DropDownMenuButton that can populate a form with the name of the Charity the subscription is being added with
          ]
        ),
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
          child: new Text('Unsubscribe', style: new TextStyle(fontSize: 17.0, color: theme.textColor)),
          onPressed: _unsubscribeTapped,
        )
      ];
    } else {
      return [
        new FlatButton(
          child: new Text('Subscribe', style: new TextStyle(fontSize: 17.0, color: theme.textColor)),
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