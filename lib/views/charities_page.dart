import 'package:flutter/material.dart';
import 'dart:async';
import 'package:gfg_mobile/views/charity_details_page.dart';
import 'package:gfg_mobile/services/data_service.dart';
import 'package:gfg_mobile/services/auth_service.dart';
import 'package:gfg_mobile/models/charity.dart';

class CharitiesPage extends StatefulWidget {
  @override
  CharitiesPageState createState() => new CharitiesPageState();
}

class CharitiesPageState extends State<CharitiesPage> {
  final auth = new AuthService();
  final data = new DataService();
  List charities;
  List filteredCharities;

  @override
  void initState(){
    this._getCharities();
    super.initState();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text('Charities'),
        centerTitle: true,
        actions: <Widget>[
          new FlatButton(
            child: new Text('Logout', style: new TextStyle(fontSize: 17.0, color: Colors.white)),
            onPressed: auth.signOut,
          ),
        ]
      ),
      body: Container(
        child: _buildCharities(),
      )
    );
  }

  Future<String> _getCharities() async {
    List allCharities = await data.charities();
    this.setState((){
      charities = allCharities;
      filteredCharities = allCharities;
    });
    return "Completed";
  }

  Widget _buildCharities() {
    return ListView.builder(
      itemCount: charities == null ? 0 : filteredCharities.length,
      itemBuilder: (BuildContext content, int index) {
        return new ListTile(
          title: Text(filteredCharities[index]['name']),
          subtitle: Text(filteredCharities[index]['website']),
          leading: CircleAvatar(child: Text(filteredCharities[index]['name'][0])),
          onTap: () => _charityTapped(index),
        );
      }
    );
  }

  void _charityTapped(int index) {
    String name = filteredCharities[index]['name'];
    String id = filteredCharities[index]['id'];
    String description = filteredCharities[index]['description'];
    String website = filteredCharities[index]['website'];
    String paymentInfo = filteredCharities[index]['payment_info'];
    Charity charity = new Charity(name, id, description, website, paymentInfo);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CharityDetailsPage(charity))
    );


  }


}
