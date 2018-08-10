import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gfg_mobile/models/charity.dart';

class CharityDetailsPage extends StatefulWidget {
  CharityDetailsPage(this.charity);
  final Charity charity;

  @override
  State<StatefulWidget> createState() => CharityDetailsPageWidgetState(charity);
}

class CharityDetailsPageWidgetState extends State<CharityDetailsPage> {
  CharityDetailsPageWidgetState(this.charity);
  final Charity charity;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
            title: Text(charity.name),
            centerTitle: true,
        ),
      body: new Container(
        padding: EdgeInsets.only(
          left: 90.0,
          right: 90.0,
          top: 50.0,
        ),
        child: new Column(
          children: [
            new Image.asset(
              charity.imagePath,
              height: 200.0,
              width: 200.0,
            ),
            new Text(charity.description),
            new RaisedButton(
              onPressed: _launchUrl,
              child: new Text('Visit Website'),
            )
          ],
        )
      ),
    );
  }

  _launchUrl() async {
    String url = charity.website;
    try {
      await launch(url);
    } catch (error) {
      throw 'error $error trying to launch $url';

    }
  }
}