import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // allows us to launch each charities external website from the client on push of a button
import 'package:gfg_mobile/models/charity.dart';
import 'package:gfg_mobile/util/themes.dart';

class CharityDetailsPage extends StatefulWidget {
  CharityDetailsPage(this.charity);
  final Charity charity; // the charity this page is being built for

  @override
  State<StatefulWidget> createState() => CharityDetailsPageWidgetState(charity);
}

class CharityDetailsPageWidgetState extends State<CharityDetailsPage> {
  final theme = new Themes();
  CharityDetailsPageWidgetState(this.charity);
  final Charity charity;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          leading: new IconButton( // replace the default leading arrow to change color
            icon: new Icon(
              Icons.arrow_back,
              color: theme.textColor,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
            title: Text(
              charity.name,
              style: theme.textStyle,
            ),
            centerTitle: true,
        ),
      body: new Container(
        padding: EdgeInsets.only(
          left: 50.0,
          right: 50.0,
          top: 50.0,
        ),
        child: new Column(
          children: [
            new Container(
              child: new Image.asset(
                charity.imagePath ?? 'assets/images/charities/Charity_Not_Found.png', // image path in backend should reflect image path in client pubspec.yaml
                height: 200.0,
                width: 200.0,
              )
            ),
            new Container(
              padding: EdgeInsets.only(
                top: 50.0,
              ),
              child: new Text(
                charity.description,
                style: theme.textStyle,
              ),
            ),
            new Container(
              padding: EdgeInsets.only(
                top: 150.0,
              ),
              child: new RaisedButton(

                onPressed: _launchUrl,
                child: new Text(
                  'Visit Website',
                  style: theme.textStyle,
                ),
              )
            ),
          ],
        )
      ),
    );
  }

  // takes the charity URL and launches it in the phone's browser
  _launchUrl() async {
    String url = charity.website;
    try {
      await launch(url);
    } catch (error) {
      throw 'error $error trying to launch $url';

    }
  }
}