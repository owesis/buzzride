// ignore: file_names
// ignore_for_file: file_names

import 'package:buzzride/Util/Colors.dart';
import 'package:buzzride/Util/Locale.dart';
import 'package:buzzride/Util/Preferences.dart';
import 'package:buzzride/Util/Util.dart';
import 'package:buzzride/Views/Home/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'phoneAuth.dart';

class AuthIntro extends StatefulWidget {
  const AuthIntro({Key? key}) : super(key: key);

  @override
  AuthIntroState createState() => AuthIntroState();
}

class AuthIntroState extends State<AuthIntro>
    with SingleTickerProviderStateMixin {
  // ignore: file_names
  bool isSwahili = false, isLoggedIn = false;
  Preferences prefs = Preferences();
  String? u;

  final RelativeRectTween relativeRectTween = RelativeRectTween(
    begin: RelativeRect.fromLTRB(240, 20, 200, 240),
    end: RelativeRect.fromLTRB(0, 0, 0, 0),
  );

  late AnimationController _controller;
  TextStyle style =
      TextStyle(fontSize: 1, color: OColors.white.withOpacity(.1));

  double carWidth = 0;

  @override
  void initState() {
    prefs.init();
    prefs.isLoggedIn().then((isLoggedIn) {
      if (isLoggedIn) {
        SchedulerBinding.instance
            .addPostFrameCallback((_) => pagerRemove(context, MyHomePage()));
      }
    });

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _controller.forward(from: 0.0);
    double st = 0;
    _controller.addListener(() {
      if (_controller.lastElapsedDuration?.inMilliseconds != null) {
        int mil = _controller.lastElapsedDuration!.inMilliseconds;

        setState(() {
          if (mil < 800) {
            carWidth += 3;
            st += 0.2;

            style = TextStyle(fontSize: 24, color: OColors.white);
          } else if (mil == 800) {
            carWidth = 200;
            style = TextStyle(fontSize: 16, color: OColors.white);
          }
        });
      }
    });

    _controller.addStatusListener((status) {
      if (status == "completed") {
        Future.delayed(Duration(milliseconds: 5000), () {
          _controller.forward(from: 0.0);
        });
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

                    // Car image Transiion
                    PositionedTransition(
                      rect: relativeRectTween.animate(_controller),
                      child: Container(
                        width: 200,
                        height: 200,
                        padding: EdgeInsets.all(70),
                        child: Image(
                          image: AssetImage("./assets/images/car.png"),
                          width: 200,
                        ),
                      ),
                    ),

                    //Description
                    Positioned(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: AnimatedDefaultTextStyle(
                          child: Text(
                            OLocale(false, 28).get(),
                            textAlign: TextAlign.center,
                          ),
                          style: style,
                          duration: const Duration(milliseconds: 1000),
                        ),
                      ),
                      bottom: MediaQuery.of(context).size.height / 4.0,
                    ),

                    // Logo
                    const Positioned(
                      top: 100,
                      left: 20,
                      child: Image(
                        image: AssetImage("assets/images/logo.png"),
                        width: 140,
                      ),
                    ),

                    Positioned(
                      bottom: MediaQuery.of(context).size.height * .10,
                      child: Center(
                        child: InkWell(
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 10, left: 70, right: 70),
                            decoration: BoxDecoration(
                                color: OColors.buttonColor,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30))),
                            child: Text(
                              OLocale(isSwahili, 32).get(),
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: OColors.white, fontSize: 18),
                            ),
                          ),
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const PhoneNumber())),
                        ),
                      ),
                    ), //BUTTON
                    // Positioned(
                    //   child: _backButton(),
                    //   top: 30,
                    //   left: 0,
                    // // ),
                    // Container(
                    //   margin: EdgeInsets.only(bottom: 15),
                    //   width: 150,
                    //   height: 4,
                    //   color: OColors.white.withOpacity(.2),
                    // )
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
