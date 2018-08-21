import 'package:flutter/material.dart';
import 'package:gfg_mobile/models/subscription.dart';
import'package:gfg_mobile/util/themes.dart';
import 'package:gfg_mobile/services/subscription_service.dart';
import 'package:gfg_mobile/services/data_service.dart';

class SubscriptionDetailsPage extends StatefulWidget {
  SubscriptionDetailsPage(this.subscription); // the subscription that this page is being built based on
  final Subscription subscription;

  @override
  State<StatefulWidget> createState() => SubscriptionDetailsPageWidgetState(subscription);
}

class SubscriptionDetailsPageWidgetState extends State<SubscriptionDetailsPage> {
  SubscriptionDetailsPageWidgetState(this.subscription);
  final Subscription subscription;
  final sub = new SubscriptionService();
  final data = new DataService();
  final theme = new Themes();
  List charities = [];
  String _selectedCharity;
  int _selectedIndex = -1; // initialize in a state where no charity has been selected

  @override
  void initState() {
    // grab the charities on init
    _setupCharities();
    super.initState();
  }

  void _setupCharities() async {
    charities = await data.charities();
    setState(() {
      _selectedCharity = subscription.charity;
    });
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _buildBar(context),
      body: new Container(
        child: new Column(
          children: <Widget>[
            _buildFirstRow(),
            _buildSecondRow(),
            _buildDropDown(),
            _buildDeleteButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      leading: new IconButton(
        icon: theme.backIcon,
        onPressed: () => Navigator.of(context).pop(true),
      ),
      title: Text(
        'Subscription Details',
        style: theme.textStyle,
      ),
      centerTitle: true,
      actions: <Widget>[
        new IconButton(icon: theme.editIcon, onPressed: _editPressed)
      ],
    );
  }

  Widget _buildFirstRow() {
    return new Container(
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Text(
              'Player: ${subscription.name}',
              style: theme.textStyle,
            ),
          ),
          new Expanded(
            child: new Text(
              'Charity: ${subscription.charity}',
              style: theme.textStyle,
            ),
          )
        ],
      ),
      padding: EdgeInsets.only(
        top: 50.0,
        left: 40.0,
      ),
    );
  }

  Widget _buildSecondRow() {
    String subscribedSince = subscription.time.substring(0, 15);
    subscribedSince.trim();
    return new Container(
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Text(
              'Goals: ${subscription.goals}',
              style: theme.textStyle,
            ),
          ),
          new Expanded(
            child: new Text(
              'Subscribed Since: $subscribedSince.',
              style: theme.textStyle,
            ),
          )
        ],
      ),
      padding: EdgeInsets.only(
        top: 50.0,
        left: 40.0,
      ),
    );
  }

  Widget _buildDropDown() {
    return new Container(
      child: new DropdownButton(
          items: new List<DropdownMenuItem>.generate(charities.length ?? 0, (int index) {
            return new DropdownMenuItem(
              child: new Text(charities[index]['name']),
              value: index,
            );
          }),
          hint: new Text(
            _selectedCharity ?? 'Select a Charity',
            style: theme.textStyle,
          ),
          onChanged: (value) {
            setState(() {
              _selectedIndex = value;
              _selectedCharity = charities[value]['name'];
            });
          },
      ),
      padding: EdgeInsets.only(
        top: 100.0,
      ),
    );
  }

  Widget _buildDeleteButton() {
    return new Container(
      child: RaisedButton(
        color: Colors.red,
        textColor: Colors.white,
        child: Text('Delete Subscription'),
        onPressed: _deleteSubscription,
      ),
      padding: EdgeInsets.only(
        top: 200.0,
      ),
    );
  }

  void _deleteSubscription()  {
    print('ok');
    showDialog(
        context: context,
        builder: _showAlert
    );
  }

  Widget _showAlert(BuildContext context) {
    return new AlertDialog(
      content: new Text(
        'Are you sure you want to delete this subscription?',
      ),
      actions: <Widget>[
        new FlatButton(
          child: Text('Delete', style: TextStyle(color: Colors.red),),
          onPressed: _confirmDelete,
        ),
        new FlatButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }

  void _editPressed() async {

    String name = charities[_selectedIndex]['name'];
    String id = charities[_selectedIndex]['id'];
    if (_selectedCharity != subscription.charity) {
      bool result = await sub.updateSubscription(subscription.id, name, id);
      if (result) {
        setState(() {
          _selectedIndex = -1;
          subscription.charity = name;
          subscription.charityId = id;
        });
      }
    }
  }

  void _confirmDelete() async {
    bool result = await sub.removeSubscription(subscription.id);
    if (result) {
      Navigator.of(context).pop();
      Navigator.of(context).pop(true);
    }
  }

}