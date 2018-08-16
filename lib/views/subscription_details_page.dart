import 'package:flutter/material.dart';
import 'package:gfg_mobile/models/subscription.dart';
import'package:gfg_mobile/util/themes.dart';
import 'package:gfg_mobile/services/subscription_service.dart';
import 'package:gfg_mobile/services/data_service.dart';

class SubscriptionDetailsPage extends StatefulWidget {
  SubscriptionDetailsPage(this.subscription);
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

  @override
  void initState() {
    _setupCharities();
    super.initState();
  }

  void _setupCharities() async {
    charities = await data.charities();
    _selectedCharity = subscription.charity;
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _buildBar(context),
      body: new Container(
        child: new Text('Hi', style: theme.textStyle,),
      ),
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      leading: new IconButton(
        icon: theme.backIcon,
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        'Subscription Details',
        style: theme.textStyle,
      ),
      centerTitle: true,
    );
  }

}