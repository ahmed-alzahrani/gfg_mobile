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
  int _selectedIndex = -1;
  String _selectedCharity;

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
        child: new Column(
          children: [
            new Container(
              child: new DropdownButton(
                items: new List<DropdownMenuItem>.generate(charities.length ?? 0, (int index) {
                  return new DropdownMenuItem(
                    child: new Text(charities[index]['name']),
                    value: index,
                  );
                }),
                hint: new Text(
                  _selectedCharity ?? 'select a charity',
                  style: new TextStyle(color: theme.textColor),
                ),
                onChanged: (value) {
                  setState(() {
                    _selectedIndex = value;
                    _selectedCharity = charities[value]['name'];
                  });
                },
              ),
              padding: EdgeInsets.only(
                top: 500.0,
                left: 80.0,
              ),
            ),
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
    if (_selectedIndex == -1) {
      print('select a charity before you try to subscribe!');
      return;
    } else {
      bool result = await sub.addSubscription(player.id, player.name, player.team, player.teamName, charities[_selectedIndex]['name'], charities[_selectedIndex]['id']);
      if (result) {
        _subbed = subscribed.subbed;
        setState(() {});
      }
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