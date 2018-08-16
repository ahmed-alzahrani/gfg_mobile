import 'package:flutter/material.dart';
import 'package:gfg_mobile/util/themes.dart';
import 'package:gfg_mobile/services/data_service.dart';
import 'dart:async';
import'package:modal_progress_hud/modal_progress_hud.dart';

class MatchesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MatchesPageWidgetState();
}

class MatchesPageWidgetState extends State<MatchesPage> {
  final data = new DataService();
  final theme = new Themes();
  List matches = new List();
  List participants = new List();
  bool _loading = true;

  @override
  void initState() {
    this._getMatches();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),
      body: Container(
        child: _buildProgressHUD(),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

  _buildBar(BuildContext context) {
    return new AppBar(
      leading: new IconButton(
        icon: theme.backIcon,
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: theme.matchesBarTitle,
      centerTitle: true,
    );
  }

  Widget _buildProgressHUD () {
    return ModalProgressHUD(
        child: _buildMatches(),
        inAsyncCall: _loading,
        progressIndicator: new RefreshProgressIndicator(),
    );
  }

  Widget _buildMatches() {
    return ListView.builder(
      itemCount: matches == null ? 0 : matches.length,
      itemBuilder: (BuildContext context, int index) {
        String title = matches[index]['localteam_name'] + ' v. ' + matches[index]['visitorteam_name'];
        return new ListTile(
          title: Text(
            title,
            style: TextStyle(
              color: theme.textColor,
              fontSize: 15.0,
            ),
          ),
          subtitle: Text(
            matches[index]['venue'],
            style: TextStyle(
              color: theme.textColor,
              fontSize: 10.0,
            ),
          ),
          trailing: Text(
            matches[index]['formatted_date'],
            style: theme.textStyle,
          ),
          onTap: () => _matchTapped(index),
        );
      },
    );
  }

  Future<void> _getMatches () async {
    List allMatches = await data.matches();
    setState(() {
      _loading = false;
      matches = allMatches;
    });
  }

  void _matchTapped(int index) async {
    String localId = matches[index]['localteam_id'];
    String visitorId = matches[index]['visitorteam_id'];
    participants = await data.participants(localId, visitorId);


    showDialog(
        context: context,
        builder: _showParticipants
    );
  }

  Widget _showParticipants(BuildContext context) {
    return new AlertDialog(
      title: Text('You are subscribed to the following players in this match:'),
      content: new Container(
        height: MediaQuery.of(context).size.height * 0.25,
        width: MediaQuery.of(context).size.width * 0.25,
        child: new ListView(
          shrinkWrap: true,
          children: _buildParticipants(),
        ),
      ),
      actions: <Widget>[
        new FlatButton(
          child: Text('Ok', style: TextStyle(fontSize: 18.0),),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }

  List<Widget> _buildParticipants() {
    List<Widget> list = new List<Widget>();
    for (int i = 0; i < participants.length; i++) {
      list.add(
        Text(
          participants[i]
        )
      );
    }
    return list;
  }
}

