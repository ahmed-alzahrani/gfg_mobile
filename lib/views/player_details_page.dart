import 'package:flutter/material.dart';
import 'package:gfg_mobile/models/player.dart';
import 'package:gfg_mobile/services/subscription_service.dart';
import 'package:gfg_mobile/services/data_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:gfg_mobile/util/themes.dart';

class PlayerDetailsPage extends StatefulWidget {
  PlayerDetailsPage(this.player); // the player based on which the page is being built
  final Player player;

  @override
  State<StatefulWidget> createState() => PlayerDetailsPageWidgetState(player);
}

// whether or not the player were looking at is one we're subbed to or not
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
  List charities = []; // charities to populate the picker
  int _selectedIndex = -1; // initialize it such that no charity has been selected
  String _selectedCharity;

  @override
  void initState() {
    _setSubscriptionStatus(); // find out if user is subscribed on init
    super.initState();
  }

  void _setSubscriptionStatus() async {
    // make our two async calls the first to check subscription the second to populate charities
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
      appBar: _buildBar(context),
      body: new Container(
        child: new Column(
          children: [
            _buildFirstRow(),
            _buildSecondRow(),
            _buildStats(),
            _buildDropDown(),
          ]
        ),
      )
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
        leading: new IconButton(
          icon: theme.backIcon,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          '${player.name} #${player.number}',
          style: theme.textStyle,
        ),
        centerTitle: true,
        actions: _buildButton()
    );
  }

  // first row consists of age and position info on the player
  Widget _buildFirstRow() {
    return new Container(
      child: new Row(
        children: [
          new Expanded(
              child: new Text(
                'Age: ${player.age}',
                style: theme.textStyle,
              )
          ),
          new Expanded(
              child: new Text(
                'Position: ${player.position}',
                style: theme.textStyle,
              )
          )
        ],
      ),
      padding: EdgeInsets.only(
        top: 50.0,
        left: 80.0,
      ),
    );
  }

  // second row consists of the team name and league info
  Widget _buildSecondRow() {
    return new Container(
      child: new Row(
        children: [
          new Expanded(
            child: new Text(
              'Team: ${player.teamName}',
              style: theme.textStyle,
            ),
          ),
          new Expanded(
              child: new Text(
                'League: ${player.league}',
                style: theme.textStyle,
              )
          ),
        ],
      ),
      padding: EdgeInsets.only(
        top: 50.0,
        left: 30.0,
      ),
    );
  }

  // Stats consists of a column with an underlined title, goals and assists in a row, and then yellow / red in another row
  Widget _buildStats() {
    return new Container(
      child: new Column(
        children: [
          new Container(
            child: new Text(
              '2018/19 Stats:',
              style: new TextStyle(
                fontSize: 24.0,
                color: theme.textColor,
                decoration: TextDecoration.underline,
                decorationColor: theme.textColor,
              ),
            )
          ),
          new Container(
            child: new Row(
              children: [
                new Expanded(
                  child: new Text(
                    'Goals: ${player.stats.goals}',
                    style: theme.textStyle,
                  ),
                ),
                new Expanded(
                  child: new Text(
                    'Assists: ${player.stats.assits}',
                    style: theme.textStyle,
                  )
                )
              ],
            ),
            padding: EdgeInsets.only(
              left: 80.0,
              top: 50.0,
            ),
          ),
          new Container(
            child: new Row(
              children: [
                new Expanded(
                  child: new Text(
                    'Yellow Cards: ${player.stats.yellowCards}',
                    style: theme.textStyle,
                  )
                ),
                new Expanded(
                  child: new Text(
                    'Red Cards: ${player.stats.redCards}',
                    style: theme.textStyle,
                  )
                )
              ]
            ),
            padding: EdgeInsets.only(
              left: 80.0,
              top:  50.0,
            ),
          )
        ],
      ),
      padding: EdgeInsets.only(
        top: 100.0,
      ),
    );
  }

  // drop down populates itself with the list of charities
  Widget _buildDropDown() {
    return new Container(
     child: new DropdownButton(
         items: new List<DropdownMenuItem>.generate(charities.length ?? 0, (int index) {
           return new DropdownMenuItem(
               child: new Text(charities[index]['name']),
               value: index
           );
         }),
         hint: new Text(
           _selectedCharity ?? 'Select a Charity', // the currently selected index is held as default hint text in the picker
           style: theme.textStyle,
         ),
         onChanged: (value) {
           setState(() {
             // update the selected charity in a set state on pick
             _selectedIndex = value;
             _selectedCharity = charities[value]['name'];
           });
         }
     ),
      padding: EdgeInsets.only(
        top: 130.0,
      ),
    );
  }

  // builds either the sub or unsub button based on the reported subscribe status from the backend
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

  // if the subscribe button is tapped we attempt to add the subscription in Firestore and update the state of the widget if successful
  void _subscribeTapped() async {
    if (_selectedIndex == -1) {
      //TODO: add alert dialog if user attempts to subscribe before selecting a charity
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

  // we attempt to remove the subscription from Firestore and update the widget if successful
  void _unsubscribeTapped() async {
    bool result = await sub.removeSubscription(player.id);
    if (result) {
      _subbed = subscribed.notSubbed;
      setState(() {});
    }
  }
}