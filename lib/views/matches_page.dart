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
  List participants = new List(); // participants in a single game that the user is subbed to
  bool _loading = true; // for our progress indicator during lengthy load time of match info

  @override
  void initState() {
    // call to get matches on init
    this._getMatches();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),
      body: Container(
        // either shows the progress indicator or the matches depending on loading bool
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

  // the child of the progressHUD is what displays after the loading stage
  Widget _buildProgressHUD () {
    return ModalProgressHUD(
        child: _buildMatches(),
        inAsyncCall: _loading, // represents the flag in the async call that notifies the modal when the data is loaded
        progressIndicator: new RefreshProgressIndicator(), // refresh progress indicator is the type of UI element the user sees
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
    String local = matches[index]['localteam_id'].toString();
    String visitor = matches[index]['visitorteam_id'].toString();
    participants = await data.participants(local, visitor);
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

