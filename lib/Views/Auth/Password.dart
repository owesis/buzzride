// ignore: file_names
// ignore_for_file: file_names

import 'package:buzzride/Models/Password.dart';
import 'package:buzzride/Util/Colors.dart';
import 'package:buzzride/Util/Locale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Password extends StatefulWidget {
  Password({Key? key}) : super(key: key);

  @override
  _Password createState() => _Password();
}

class _Password extends State<Password> {
  bool isSwahili = false, obscure = true, page = false, checking = false;
  TextEditingController username = TextEditingController(),
      password = TextEditingController();
  String status = '', usern = '';

  SpinKitFadingFour spinkit = const SpinKitFadingFour(
    color: Colors.white,
    size: 50.0,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _checkUser() async {
    usern = username.text;
    setState(() {
      usern = usern;
    });

    if (usern.isEmpty && usern.length < 3) {
      return ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please enter your username/email!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }

    setState(() {
      checking = true;
    });

    return PasswordModel(username: usern, payload: '', status: 0)
        .passwordRequest()
        .then((value) {
      String message = value.payload;
      if (value.status == 200) {
        setState(() {
          if (!page) {
            page = true;
          } else {
            page = false;
          }
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            backgroundColor: Colors.red,
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
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: OColors.primary),
            ),
            Text(OLocale(isSwahili, 27).get(),
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: OColors.primary))
          ],
        ),
      ),
    );
  }

  Widget _checkUserPage() {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 140),
      width: MediaQuery.of(context).size.width / 1.2,
      height: MediaQuery.of(context).size.height / 1.27,
      child: Column(
        children: <Widget>[
          Text(
            OLocale(isSwahili, 0).get(),
            style: TextStyle(
                fontSize: 24,
                color: OColors.primary,
                fontWeight: FontWeight.bold),
          ), //logo
          const SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Theme(
              data: ThemeData(primaryColor: OColors.introColor),
              child: TextField(
                keyboardType: TextInputType.text,
                controller: username,
                style: TextStyle(color: Colors.black.withOpacity(.5)),
                decoration: InputDecoration(
                    hintText: "Username/Email",
                    focusColor: OColors.primary,
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: OColors.primary.withOpacity(.5)),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.black.withOpacity(.3)),
                    ),
                    hintStyle: TextStyle(color: Colors.black.withOpacity(.5))),
              ),
            ),
          ), //
          const SizedBox(
            height: 60,
          ),
          InkWell(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(
                  top: 20, bottom: 20, left: 20, right: 20),
              decoration: BoxDecoration(
                  color: OColors.primary,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: !checking
                  ? Text(
                      OLocale(isSwahili, 31).get(),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: OColors.white, fontSize: 16),
                    )
                  : spinkit,
            ),
            onTap: () => _checkUser(),
          ) ////
        ],
      ),
    );
  }

  Widget _thankyouPage({String? user}) {
    return Container(
      margin: const EdgeInsets.only(top: 200),
      width: MediaQuery.of(context).size.width / 1.2,
      height: MediaQuery.of(context).size.height / 1.27,
      child: user!.isEmpty
          ? const Text("User info required!")
          : Column(
              children: [
                Text(
                  "THANK YOU",
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 24,
                      color: OColors.primary),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Your Password reset is successful.",
                  style: TextStyle(
                      color: Color(0xff000000).withOpacity(.7),
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
                SizedBox(
                  child: Row(
                    children: [
                      Text(
                        "Your password is sent to",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            color: OColors.subTitleColor),
                      ),
                    ],
                  ),
                ),
                Text(
                  "$user",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: OColors.subTitleColor),
                ),
              ],
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
                    !page
                        ? _checkUserPage()
                        : _thankyouPage(user: "$usern"), //login button
                    Positioned(
                      child: _backButton(),
                      top: 30,
                      left: 0,
                    ), //back button
                    Positioned(
                      bottom: 0,
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 15),
                            width: 70,
                            height: 4,
                            color: page
                                ? OColors.primary.withOpacity(.2)
                                : OColors.primary,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 15),
                            width: 70,
                            height: 4,
                            color: !page
                                ? OColors.primary.withOpacity(.2)
                                : OColors.primary,
                          ),
                        ],
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
