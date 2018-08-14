import 'package:flutter/material.dart';
import 'dart:async';
import 'package:gfg_mobile/views/charity_details_page.dart';
import 'package:gfg_mobile/services/data_service.dart';
import 'package:gfg_mobile/services/auth_service.dart';
import 'package:gfg_mobile/models/charity.dart';
import 'package:gfg_mobile/util/themes.dart';

class CharitiesPage extends StatefulWidget {
  CharitiesPage({ Key key }) : super(key: key);
  @override
  CharitiesPageState createState() => new CharitiesPageState();
}

class CharitiesPageState extends State<CharitiesPage> {
  final formKey = new GlobalKey<FormState>();
  final auth = new AuthService();
  final data = new DataService();
  final theme = new Themes();
  final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _filter = new TextEditingController();
  List charities = new List();
  List filteredCharities = new List();
  Widget _appBarTitle;
  Icon _searchIcon;
  String _searchText = "";

  CharitiesPageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredCharities = charities;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  @override
  void initState(){
    _searchIcon = theme.searchIcon;
    _appBarTitle = theme.charitiesBarTitle;
    this._getCharities();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildBar(context),
      body: Container(
        child: _buildCharities(),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget buildBar(BuildContext context) {
    return new AppBar(
      centerTitle: true,
      title: _appBarTitle,
      leading: new IconButton(icon: _searchIcon, onPressed: () {
        setState(() {
          if (this._searchIcon.icon == Icons.search) {
            this._searchIcon = new Icon(Icons.close, color: theme.textColor,);
            this._appBarTitle = new TextField(
              controller: _filter,
              style: new TextStyle(
                color: theme.textColor,
              ),
              decoration: new InputDecoration(
                prefixIcon: new Icon(Icons.search, color: theme.textColor),
                hintText: 'Search...',
                hintStyle: new TextStyle(color: theme.textColor)
              ),
            );
          } else {
            _searchEnd();
          }
        });
      },),
      actions: <Widget>[
        new FlatButton(
          child: theme.logout,
          onPressed: auth.signOut,
        )
      ],
    );
  }

  _searchEnd() {
    setState(() {
      this._searchIcon = theme.searchIcon;
      this._appBarTitle = theme.charitiesBarTitle;
      filteredCharities = charities;
      _filter.clear();
    });
  }

  Future<void> _getCharities() async {
    List allCharities = await data.charities();
    this.setState((){
      charities = allCharities;
      charities.shuffle();
      filteredCharities = allCharities;
    });
    return;
  }

  Widget _buildCharities() {
    if (!(_searchText.isEmpty)) {
      List tempList = new List();
      for (int i = 0; i < filteredCharities.length; i++) {
        if (filteredCharities[i]['name'].toLowerCase().contains(_searchText.toLowerCase())) {
          tempList.add(filteredCharities[i]);
        }
      }
      filteredCharities = tempList;
    }
    return ListView.builder(
      itemCount: charities == null ? 0 : filteredCharities.length,
      itemBuilder: (BuildContext context, int index) {
        return new ListTile(
          title: Text(
            filteredCharities[index]['name'],
            style: theme.textStyle,
          ),
          subtitle: Text(
            filteredCharities[index]['website'],
            style: theme.textStyle,
          ),
          leading: CircleAvatar(
            backgroundColor: Colors.black,
            child: Text(
              filteredCharities[index]['name'][0],
              style: theme.textStyle,
            )
          ),
          onTap: () => _charityTapped(index),
        );
      },
    );
  }

  void _charityTapped(int index) {
    String name = filteredCharities[index]['name'];
    String id = filteredCharities[index]['id'];
    String description = filteredCharities[index]['description'];
    String website = filteredCharities[index]['website'];
    String imagePath = filteredCharities[index]['imagePath'];
    String paymentInfo = filteredCharities[index]['payment_info'];
    Charity charity = new Charity(name, id, description, website, imagePath, paymentInfo);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CharityDetailsPage(charity))
    );


  }


}
