import 'package:flutter/material.dart';
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
        child: new Image.asset(
          charity.imagePath,
          height: 60.0,
        ),
      ),
    );
  }
}