import 'package:buzzride/Util/Locale.dart';
import 'package:buzzride/Util/pallets.dart';
import 'package:flutter/material.dart';

import '../../Util/Colors.dart';
import '../Home/Home.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isSwahili = false, isVisibleDrawer = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OColors.primary,
      appBar: AppBar(
        backgroundColor: OColors.primary,
        leading: _bckButton(context),
        title: Text(
          OLocale(isSwahili, 50).get(),
          style: profileHeader.copyWith(fontSize: 23, letterSpacing: 1),
        ),
        actions: [_topheaderLogo()],
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),

          Center(
            child: Container(
                width: 90,
                height: 90,
                decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white,
                    child: Image(
                      image: AssetImage('assets/images/user.png'),
                    ),
                  ),
                )),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              "Frank Galos",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: OColors.white.withOpacity(.9)),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 1, bottom: 15),
                  child: Text(
                    "+255 743 500 123",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 13,
                        color: OColors.whiteFade.withOpacity(.9)),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 1, bottom: 15),
                  child: SizedBox(
                    height: 10,
                    child: VerticalDivider(
                      color: Colors.white,
                      width: 10,
                      thickness: 1.5,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 1, bottom: 15),
                  child: Text(
                    "EmailAddress@gmail.com",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 13,
                        color: OColors.whiteFade.withOpacity(.9)),
                  ),
                )
              ],
            ),
          ),

          //Circle Container

          //About Driver
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: SizedBox(
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('ABOUT DRIVER',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  const SizedBox(
                    height: 5,
                  ),
                  const SizedBox(
                      height: 55,
                      child: Text(
                          'My Name is First LastName. who dtives a Buzzride Fast but safe will greet you and dont worry . I drive better than anyone. Thank you',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Colors.white),
                          overflow: TextOverflow.clip)),
                  Divider(
                    color: OColors.borderColor.withOpacity(.5),
                  )
                ],
              ),
            ),
          ),

          //Vehicle
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: Container(
              height: 65,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('VEHECLE',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                      height: 25,
                      child: const Text('Maserati - KL 06 BN 1458',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Colors.white),
                          overflow: TextOverflow.clip)),
                  Divider(
                    color: OColors.borderColor.withOpacity(.5),
                  )
                ],
              ),
            ),
          ),

          //Vehicle
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: SizedBox(
              height: 65,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('CAREER',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                      height: 25,
                      child: const Text('1 Year',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Colors.white),
                          overflow: TextOverflow.clip)),
                  Divider(
                    color: OColors.borderColor.withOpacity(.5),
                  )
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: InkWell(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: OColors.buttonColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Text(
                    'Edit Profile',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: OColors.white, fontSize: 16),
                  )),
              // onTap: () => _checkUser(),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const Profile()));
              },
            ),
          ),

          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Padding _topheaderLogo() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Image(
        image: AssetImage("assets/images/logo.png"),
        width: 50,
        height: 50,
      ),
    );
  }

  InkWell _bckButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const MyHomePage()));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Container(
          decoration: BoxDecoration(
            color: OColors.buttonColor,
            borderRadius: BorderRadius.circular(9),
          ),
          padding: const EdgeInsets.all(5),
          child: Icon(Icons.keyboard_arrow_left, color: OColors.white),
        ),
      ),
    );
  }
}
