import 'package:flutter/material.dart';
import'package:gfg_mobile/util//user_validator.dart';
import 'package:gfg_mobile/services/auth_service.dart';
import 'package:gfg_mobile/util/themes.dart';

class LoginPage extends StatefulWidget {

  LoginPage(this.onSignedIn);
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

enum FormType {
  login,
  register
}

class _LoginPageState extends State<LoginPage> {

  final formKey = new GlobalKey<FormState>();
  final validate = new UserValidator();
  final auth = new AuthService();
  final theme = new Themes();

  String _email;
  String _password;
  FormType _form = FormType.login;

  void _formChange () async {
    setState(() {
      if (_form == FormType.register) {
        _form = FormType.login;
      } else {
        _form = FormType.register;
      }
    });
  }

  void _createAccountPressed () async {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      auth.createAccount(_email, _password);
      widget.onSignedIn();
    } else {
      print("the form was invalid somehow");
      // TODO: add Widget for incorrect e-mail / pass?
    }
  }

  void _loginPressed () async {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      auth.login(_email, _password);
      widget.onSignedIn();
    } else {
      // either email or pass is invalid
      // TODO: add Widget for incorrect e-mail / pass?
    }
  }

  void _passwordReset () async {
    final form = formKey.currentState;
    form.save();
    if (validate.isEmailAddressValid(_email)) {
      auth.passwordReset(_email);
    } else {
      form.validate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: new AppBar(
        title: new Text(
          'Login',
          style: theme.textStyle,
        ),
        centerTitle: true,
      ),
      body: new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: formKey,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: buildTextFields() + buildButtons(),
          ),
        )
      )
    );
  }

  List<Widget> buildTextFields() {
    return [
      new TextFormField(
        style: theme.textStyle,
        decoration: new InputDecoration(labelText: 'Email', labelStyle: theme.textStyle),
        validator: (value) => validate.isEmailAddressValid(value) ? null : 'Invalid E-mail',
        onSaved: (value) => _email = value,
      ),
      new TextFormField(
        style: theme.textStyle,
        decoration: new InputDecoration(labelText: 'Password', labelStyle: theme.textStyle),
        validator: (value) => validate.isPasswordValid(value) ? null : 'Invalid Password',
        onSaved: (value) => _password = value,
        obscureText: true,
      )
    ];
  }

  List<Widget> buildButtons() {
    if (_form == FormType.login) {
      return [
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
      ];
    } else {
      return [
        new RaisedButton(
          child: new Text('Create an Account', style: new TextStyle(fontSize: 20.0, color: theme.textColor)),
          onPressed: _createAccountPressed,
        ),
        new FlatButton(
          child: new Text('Have an account? Click here to login.', style: new TextStyle(fontSize: 14.0, color: theme.textColor)),
          onPressed: _formChange,
        )
      ];
    }
  }
}
