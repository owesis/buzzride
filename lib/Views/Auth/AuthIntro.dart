// ignore: file_names
// ignore_for_file: file_names

import 'package:buzzride/Util/Colors.dart';
import 'package:buzzride/Util/Locale.dart';
import 'package:buzzride/Util/Preferences.dart';
import 'package:buzzride/Util/Util.dart';
import 'package:buzzride/Views/Auth/Register.dart';
import 'package:buzzride/Views/Home/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AuthIntro extends StatefulWidget {
  const AuthIntro({Key? key}) : super(key: key);

  @override
  AuthIntroState createState() => AuthIntroState();
}

class AuthIntroState extends State<AuthIntro> {
  // ignore: file_names
  bool isSwahili = false, isLoggedIn = false;
  Preferences prefs = Preferences();
  String? u;

  @override
  void initState() {
    prefs.init();
    prefs.isLoggedIn().then((isLoggedIn) {
      if (isLoggedIn) {
        SchedulerBinding.instance.addPostFrameCallback((_) => pagerRemove(
            context,
            MyHomePage(
              title: '',
            )));
      }
    });
    // TODO: implement initState
    super.initState();
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
              child: Icon(Icons.keyboard_arrow_left, color: OColors.white),
            ),
            Text('Back',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: OColors.white))
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
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.bottomCenter,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            "./assets/images/whole.png",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                              color: OColors.introColor.withOpacity(.99))),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: 350,
                      child: Column(
                        children: <Widget>[
                          Text(
                            OLocale(isSwahili, 0).get(),
                            style: TextStyle(
                                fontSize: 24,
                                color: OColors.white,
                                fontWeight: FontWeight.bold),
                          ), //logo
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 15, left: 25, right: 25),
                            child: Text(
                              OLocale(false, 28).get(),
                              style:
                                  TextStyle(fontSize: 16, color: OColors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * .20,
                      left: 20,
                      child: Image(
                        image: AssetImage("assets/images/header_logo.png"),
                      ),
                    ),
                    Positioned(
                      bottom: MediaQuery.of(context).size.height * .10,
                      left: 0,
                      child: InkWell(
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 20, bottom: 20, left: 70, right: 70),
                          decoration: BoxDecoration(
                              color: OColors.primary,
                              borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(30),
                                  topRight: Radius.circular(30))),
                          child: Text(
                            OLocale(isSwahili, 26).get(),
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: OColors.white, fontSize: 16),
                          ),
                        ),
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const Register())),
                      ),
                    ),
                    // Positioned(
                    //   child: _backButton(),
                    //   top: 30,
                    //   left: 0,
                    // ),
                    Container(
                      margin: EdgeInsets.only(bottom: 15),
                      width: 150,
                      height: 4,
                      color: OColors.white.withOpacity(.2),
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
