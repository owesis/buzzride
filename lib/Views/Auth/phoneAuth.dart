// ignore: file_names
// ignore_for_file: file_names

import 'package:buzzride/Models/Password.dart';
import 'package:buzzride/Util/Colors.dart';
import 'package:buzzride/Util/Locale.dart';
import 'package:buzzride/Views/Auth/codeAuth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PhoneNumber extends StatefulWidget {
  const PhoneNumber({Key? key}) : super(key: key);

  @override
  State<PhoneNumber> createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  bool isSwahili = false, obscure = true, page = false, checking = false;
  TextEditingController username = TextEditingController(),
      prefixPhoneNumber = TextEditingController(),
      suffixPhoneNumber = TextEditingController(),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: OColors.buttonColor,
                  borderRadius: BorderRadius.circular(9),
                ),
                padding: const EdgeInsets.all(5),
                child: Icon(Icons.keyboard_arrow_left, color: OColors.white),
              ),
            ),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            OLocale(isSwahili, 33).get(),
            style: TextStyle(
              fontSize: 18,
              color: OColors.whiteFade,
            ),
          ), //logo
          const SizedBox(
            height: 10,
          ),

          //TextField: phone Number
          Row(
            children: [
              SizedBox(
                width: 50,
                child: Theme(
                  data: ThemeData(primaryColor: OColors.introColor),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    controller: prefixPhoneNumber,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        hintText: OLocale(isSwahili, 38).get(),
                        focusColor: OColors.primary,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: OColors.primary.withOpacity(.5)),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black.withOpacity(.3)),
                        ),
                        hintStyle: const TextStyle(color: Colors.white)),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 200,
                child: Theme(
                  data: ThemeData(primaryColor: OColors.introColor),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    controller: suffixPhoneNumber,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        hintText: OLocale(isSwahili, 37).get(),
                        focusColor: OColors.white,
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: OColors.white.withOpacity(.5)),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black.withOpacity(.3)),
                        ),
                        hintStyle: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ],
          ), //

          const Spacer(),

          InkWell(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: OColors.buttonColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: !checking
                  ? Text(
                      OLocale(isSwahili, 34).get(),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: OColors.white, fontSize: 16),
                    )
                  : spinkit,
            ),
            // onTap: () => _checkUser(),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const CodeAuth()));
            },
          ) ////
          ,

          const SizedBox(
            height: 40,
          ),
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
      backgroundColor: const Color(0xff00AFCA),
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

                    // top header
                    Positioned(
                      top: 30,
                      left: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _backButton(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                          ),
                          headerLogo()
                        ],
                      ),
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

  Padding headerLogo() {
    return const Padding(
      padding: EdgeInsets.only(top: 8.0, left: 15),
      child: Image(
        image: AssetImage("assets/images/logo.png"),
        width: 50,
        height: 50,
      ),
    );
  }
}
