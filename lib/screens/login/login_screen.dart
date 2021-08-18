import 'dart:ui';

import 'package:ancalmo_manager/models/login_response.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:ancalmo_manager/screens/login/login_screen_presenter.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> implements LoginScreenContract {
  BuildContext _ctx;

  bool isLoggedIn = false;
  String name = '';

  @override
  void initState() {
    super.initState();
    autoLogIn();
  }

  void autoLogIn() async {
    /*
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userId = prefs.getString('username');
    print(userId);
    if (userId != null) {
      setState(() {
        isLoggedIn = true;
        name = userId;
      });
      Navigator.of(_ctx).pushReplacementNamed("/home");
      return;
    }
     */
  }

  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String _password, _username;

  LoginScreenPresenter _presenter;
  _LoginScreenState() {
    _presenter = new LoginScreenPresenter(this);
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() => _isLoading = true);
      form.save();
      _presenter.doLogin(_username, _password);
    }
  }

  void _showSnackBar(String text) {
    print(text);
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;

    return Scaffold(
        appBar: null,
        key: scaffoldKey,
        body: Container(
          decoration: BoxDecoration(
            //color: Color(0xffFEFEFE),
              image: DecorationImage(
                  image: AssetImage("assets/head_login.png"),
                  //colorFilter: ColorFilter.mode(Colors.black.withOpacity(0), BlendMode.dstATop),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter)),
          child: Form(
            key: formKey,
            child: ListView(
              //padding: EdgeInsets.all(50),
              padding: EdgeInsets.only(left: 20, right: 20, top: 50),
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2.1,
                ),
                Center(
                    child: Text('Iniciar sesión',
                        style: TextStyle(
                            color: Color(0xff0A2555),
                            fontSize: 17,
                            fontWeight: FontWeight.bold))),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onSaved: (val) => _username = val,
                  validator: (val) {
                    return !EmailValidator.validate(val, true)
                        ? "Please enter a valid email"
                        : null;
                  },
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      height: 1,
                      color: Colors.black,
                      fontFamily: "CentraleSansRegular"),
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        LineAwesomeIcons.user,
                        color: Color(0xffC7CFDC),
                        size: 30,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide:
                          BorderSide(color: Color(0xff8A99B2), width: 1)),
                      hintText: "Correo Electrónico",
                      labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontFamily: "CentraleSansRegular")),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  textAlign: TextAlign.center,
                  obscureText: true,
                  onSaved: (val) => _password = val,
                  validator: (val) {
                    return val.length < 1 ? "Please enter password" : null;
                  },
                  style: TextStyle(
                      height: 1,
                      color: Colors.black,
                      fontFamily: "CentraleSansRegular"),
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        LineAwesomeIcons.unlock_alt,
                        color: Color(0xffC7CFDC),
                        size: 30,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide:
                          BorderSide(color: Color(0xff8A99B2), width: 1)),
                      hintText: "Contraseña",
                      labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontFamily: "CentraleSansRegular")),
                ),
                SizedBox(
                  height: 30,
                ),
                FlatButton(
                  minWidth: 330,
                  height: 48,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: BorderSide(color: Color(0xff0A2555), width: 3)),
                  color: Color(0xff0A2555),
                  onPressed: _submit,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "CentraleSansRegular",
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Iniciar sesión',
                          style: TextStyle(
                              color: Color(0xff0A2555),
                              fontSize: 17,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  @override
  void onLoginError(String errorTxt) {
    //_onHideLoading();
    setState(() => _isLoading = false);
    _showSnackBar(errorTxt);
  }

  @override
  void onLoginSuccess(LoginResponse response) {
    //final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() => _isLoading = false);
    // _onHideLoading();
    print('onLoginSuccess');
    print(response.user_id);
    _showSnackBar("Login successful!");
    Navigator.of(_ctx).pushReplacementNamed("/home", arguments: response.user_id.toString());
    setState(() {
      //name = prefs.getString('username');
      isLoggedIn = true;
    });
  }

  void _showDialog(String message) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert"),
          content: new Text("$message"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _onLoading() {
    showDialog(
      context: scaffoldKey.currentState.context,
      barrierDismissible: false,
      child: new SimpleDialog(
        title: Container(
          child: Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new CircularProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 10.0),
                  child: new Text("Loading"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onHideLoading() {
    Navigator.pop(scaffoldKey.currentState.context); //pop dialog
  }

  Future<bool> getLoginState() async {
    //SharedPreferences pf = await SharedPreferences.getInstance();
    //bool loginState = pf.getBool('loginState');
    //return loginState;
    return false;
  }
}
