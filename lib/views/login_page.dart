import 'package:flutter/material.dart';
import'package:gfg_mobile/util//user_validator.dart';
import 'package:gfg_mobile/services/auth_service.dart';
import 'package:gfg_mobile/util/themes.dart';

class LoginPage extends StatefulWidget {

  LoginPage(this.onSignedIn, this.onCreateAccount);
  final VoidCallback onSignedIn;
  final VoidCallback onCreateAccount;

  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

enum FormType {
  login,
  register
}

class _LoginPageState extends State<LoginPage> {

  final validate = new UserValidator(); // RegEx to make sure user email and password are valid
  final auth = new AuthService();
  final theme = new Themes();

  final TextEditingController _emailFilter = new TextEditingController();
  final TextEditingController _passwordFilter = new TextEditingController();
  String _email = "";
  String _password = "";
  FormType _form = FormType.login; // default is login, only switch to register if the user taps that they don't have an account

  _LoginPageState() {
    _emailFilter.addListener(_emailListen);
    _passwordFilter.addListener(_passwordListen);
  }

  void _emailListen() {
    if (_emailFilter.text.isEmpty) {
      _email = "";
    } else {
      _email = _emailFilter.text;
    }
  }

  void _passwordListen() {
    if (_passwordFilter.text.isEmpty) {
      _password = "";
    } else {
      _password = _passwordFilter.text;
    }
  }


  // change to whichever form type is not currently being displayed
  void _formChange () async {
    setState(() {
      if (_form == FormType.register) {
        _form = FormType.login;
      } else {
        _form = FormType.register;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: _buildBar(context),
      body: new Container(
        padding: EdgeInsets.all(16.0),
        child: new Column(
          children: <Widget>[
            _buildTextFields(),
            _buildButtons(),
          ],
        ),
      )
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      title: theme.loginBarTitle,
      centerTitle: true,
    );

  }

  // returns the two text fields, one for email and one for password
  Widget _buildTextFields() {
    return new Container(
      child: new Column(
        children: <Widget>[
          new Container(
            child: new TextField(
              controller: _emailFilter,
              style: theme.textStyle,
              decoration: new InputDecoration(
                labelText: 'E-mail',
                labelStyle: theme.textStyle,
              ),
            )
          ),
          new Container(
            child: new TextField(
              controller: _passwordFilter,
              style: theme.textStyle,
              decoration: new InputDecoration(
                labelText: 'Password',
                labelStyle: theme.textStyle,
              ),
              obscureText: true,
            ),
          )
        ],
      ),
    );
  }

  // builds either the login or create account buttons as well as the transition button depending on which form is up
  Widget _buildButtons() {
    if (_form == FormType.login) {
      return new Container(
        child: new Column(
          children: <Widget>[
            new RaisedButton(
              child: new Text('Login', style: new TextStyle(
                fontSize: 20.0,
                color: theme.textColor,
              )),
              onPressed: _loginPressed,
            ),
            new FlatButton(
              child: new Text('Don\'t have an account? Tap here to register.', style: new TextStyle(fontSize: 14.0, color: theme.textColor)),
              onPressed: _formChange,
            ),
            new FlatButton(
              child: new Text('Forgot Password?', style: new TextStyle(fontSize: 14.0, color: theme.textColor)),
              onPressed: _passwordReset,
            )
          ],
        ),
      );
    } else {
      return new Container(
        child: new Column(
          children: <Widget>[
            new RaisedButton(
              child: new Text('Create an Account', style: new TextStyle(fontSize: 20.0, color: theme.textColor)),
              onPressed: _createAccountPressed,
            ),
            new FlatButton(
              child: new Text('Have an account? Click here to login.', style: new TextStyle(fontSize: 14.0, color: theme.textColor)),
              onPressed: _formChange,
            )
          ],
        ),
      );
    }
  }

  // handles call to backend to create account
  void _createAccountPressed () async {
      if (validate.isEmailAddressValid(_email) && validate.isPasswordValid(_password)) {
      auth.createAccount(_email, _password);
      widget.onCreateAccount();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('Account Creation Failed'),
            content: new Text('Please review your e-mail/pass and try again'),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
      );
      // TODO: add Widget for incorrect e-mail / pass?
    }
  }

  // handles call to Firebase Auth to login
  void _loginPressed () async {
    bool result = await auth.login(_email, _password);
    if (result) {
      widget.onSignedIn();
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text('Login Failed'),
              content: new Text('Please review your e-mail/pass and try again, if you have forgotten your password, use the link at the bottom of the page to reset it.'),
              actions: <Widget>[
                new FlatButton(
                  child: new Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          }
      );
    }
  }

  // sends password reset to user
  void _passwordReset () async {
    if (validate.isEmailAddressValid(_email)) {
      auth.passwordReset(_email);
    } else {
      // TODO: implement this as attempted sign-in that then e-mails the user if successful and logs out
    }
  }
}
