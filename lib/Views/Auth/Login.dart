// ignore: file_names
// ignore_for_file: file_names, non_constant_identifier_names, prefer_const_constructors

import 'package:buzzride/Models/Auth.dart';
import 'package:buzzride/Util/Colors.dart';
import 'package:buzzride/Util/Locale.dart';
import 'package:buzzride/Util/Preferences.dart';
import 'package:buzzride/Util/Util.dart';
import 'package:buzzride/Views/Auth/Password.dart';
import 'package:buzzride/Views/Auth/Register.dart';
import 'package:buzzride/Views/Home/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Login extends StatefulWidget {
  Login({Key? key, this.token}) : super(key: key);

  String? token;

  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  bool isSwahili = false, obscure = true, login = false, isLoggedIn = false;
  TextEditingController username = TextEditingController(),
      password = TextEditingController();
  String status = '';
  final Preferences _preferences = Preferences();

  @override
  void initState() {
    _preferences.init();
    _preferences.isLoggedIn().then((isLoggedIn) {
      if (isLoggedIn) {
        SchedulerBinding.instance
            .addPostFrameCallback((_) => pagerRemove(context, MyHomePage()));
      }
    });

    // TODO: implement initState
    super.initState();
  }

  _Login() async {
    String u = username.text, p = password.text;

    if (u.isEmpty || p.isEmpty) {
      return setState(() {
        status = "Invalid password or username!";

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Invalid password or username!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            backgroundColor: Colors.red,
            duration: Duration(milliseconds: 600),
          ),
        );
      });
    }

    setState(() {
      status = "Login...";
      login = true;
    });

    Auth(username: u, password: p, token: '', status: 0).login().then((res) {
      print(res.status);
      setState(() {
        login = false;
      });
      if (res.status == 200) {
        setState(() {
          status = '';
          _preferences.add("token", res.token);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => MyHomePage()),
              ModalRoute.withName('/'));
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              res.token,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 1),
          ),
        );
      }
    });
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: OColors.primary),
            ),
            Text(OLocale(isSwahili, 30).get(),
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: OColors.primary))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topCenter,
                      margin: EdgeInsets.only(top: 110),
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: MediaQuery.of(context).size.height / 1.2,
                      child: Column(
                        children: <Widget>[
                          Text(
                            OLocale(isSwahili, 0).get(),
                            style: TextStyle(
                                fontSize: 24,
                                color: OColors.primary,
                                fontWeight: FontWeight.bold),
                          ), //logo
                          SizedBox(
                            height: 60,
                          ),
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: OColors.primary.withOpacity(.1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: OColors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      padding:
                                          EdgeInsets.only(top: 13, bottom: 13),
                                      child: Text(
                                        OLocale(isSwahili, 27).get(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: OColors.primary,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(top: 13, bottom: 13),
                                      child: Text(
                                        OLocale(isSwahili, 26).get(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: OColors.primary,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      ),
                                    ),
                                    onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                Register())),
                                  ),
                                )
                              ],
                            ),
                          ), // options button
                          SizedBox(
                            height: 50,
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 10, left: 10, right: 10),
                            child: Theme(
                              data: ThemeData(primaryColor: OColors.introColor),
                              child: TextField(
                                keyboardType: TextInputType.text,
                                controller: username,
                                style: TextStyle(
                                    color: Colors.black.withOpacity(.5)),
                                decoration: InputDecoration(
                                    hintText: "Username/Email",
                                    focusColor: OColors.primary,
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              OColors.primary.withOpacity(.5)),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black.withOpacity(.3)),
                                    ),
                                    hintStyle: TextStyle(
                                        color: Colors.black.withOpacity(.5))),
                              ),
                            ),
                          ), // username field
                          Padding(
                            padding:
                                EdgeInsets.only(top: 30, left: 10, right: 10),
                            child: Theme(
                              data: ThemeData(primaryColor: OColors.primary),
                              child: TextField(
                                keyboardType: TextInputType.text,
                                obscureText: obscure,
                                controller: password,
                                style: TextStyle(
                                    color: Colors.black.withOpacity(.5)),
                                decoration: InputDecoration(
                                    hintText: "Password",
                                    suffixIcon: InkWell(
                                      child: FaIcon(
                                        obscure
                                            ? FontAwesomeIcons.eyeSlash
                                            : FontAwesomeIcons.eye,
                                        color: obscure
                                            ? Colors.black.withOpacity(.5)
                                            : OColors.primary,
                                      ),
                                      onTap: () => setState(() {
                                        obscure = obscure ? false : true;
                                      }),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              OColors.primary.withOpacity(.5)),
                                    ),
                                    focusColor: OColors.primary.withOpacity(.5),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black.withOpacity(.3)),
                                    ),
                                    hintStyle: TextStyle(
                                        color: Colors.black.withOpacity(.5))),
                                onSubmitted: (value) {
                                  return _Login();
                                },
                              ),
                            ),
                          ), //password filed
                          Container(
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.only(
                              top: 30,
                            ),
                            child: InkWell(
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Password())),
                              child: Text(
                                "Forgot passwords?",
                                textAlign: TextAlign.right,
                                style: TextStyle(color: OColors.primary),
                              ),
                            ),
                          ), // forgot passwords!
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: MediaQuery.of(context).size.height * .23,
                      right: 25,
                      left: 20,
                      child: InkWell(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(
                              top: 20, bottom: 20, left: 20, right: 20),
                          decoration: BoxDecoration(
                              color: OColors.primary,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: !login
                              ? Text(
                                  OLocale(isSwahili, 25).get(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: OColors.white, fontSize: 16),
                                )
                              : Text(status,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: OColors.white, fontSize: 16)),
                        ),
                        onTap: () => _Login(),
                      ),
                    ), //login button
                    Positioned(
                      child: _backButton(),
                      top: 30,
                      left: 0,
                    ), //back button
                    Positioned(
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            width: 80,
                            height: 2,
                            color: OColors.primary.withOpacity(.2),
                          ),
                          Text(
                            "OR",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w800),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            width: 80,
                            height: 2,
                            color: OColors.primary.withOpacity(.2),
                          ),
                        ],
                      ),
                      bottom: 118,
                    ), // OR
                    Positioned(
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            padding: EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 10),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                border: Border.all(
                                    color: OColors.primary.withOpacity(.2))),
                            child: Center(
                              child: InkWell(
                                child: FaIcon(
                                  FontAwesomeIcons.google,
                                  color: OColors.primary,
                                ),
                                onTap: () => print("Google"),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            padding: EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 10),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                border: Border.all(
                                    color: OColors.primary.withOpacity(.2))),
                            child: Center(
                              child: InkWell(
                                child: FaIcon(
                                  FontAwesomeIcons.facebookF,
                                  color: OColors.primary,
                                ),
                                onTap: () => print("Facebook"),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            padding: EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 10),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                border: Border.all(
                                    color: OColors.primary.withOpacity(.2))),
                            child: Center(
                              child: InkWell(
                                child: FaIcon(
                                  FontAwesomeIcons.apple,
                                  color: OColors.primary,
                                ),
                                onTap: () => print("Apple"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      bottom: 50,
                    ),
                    Positioned(
                      child: InkWell(
                        child: Text(
                          "Continue as guest",
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                              color: OColors.primary),
                        ),
                        onTap: () => Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    MyHomePage()),
                            ModalRoute.withName('/')),
                      ),
                    )
                  ],
                ),
              )
            ]),
          )
        ],
      ),
    );
  }
}
