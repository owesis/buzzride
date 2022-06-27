// ignore: file_names
// ignore_for_file: file_names, non_constant_identifier_names

import 'package:buzzride/Models/User.dart';
import 'package:buzzride/Util/Colors.dart';
import 'package:buzzride/Util/Locale.dart';
import 'package:buzzride/Util/Util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _Register createState() => _Register();
}

class _Register extends State {
  bool isSwahili = false,
      registering = false,
      obscure = true,
      registered = false;
  TextEditingController username = TextEditingController(),
      fname = TextEditingController(),
      lname = TextEditingController(),
      addr = TextEditingController(),
      email = TextEditingController(),
      phone = TextEditingController(),
      password = TextEditingController();
  String status = '', _dropDownValue = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _Signup() async {
    String fn = fname.text,
        ln = lname.text,
        e = email.text,
        ad = addr.text,
        pn = phone.text,
        g = _dropDownValue,
        u = username.text,
        p = password.text;

    if (fn.isEmpty ||
        ln.isEmpty ||
        g.isEmpty ||
        e.isEmpty ||
        u.isEmpty ||
        ad.isEmpty ||
        pn.isEmpty ||
        p.isEmpty) {
      return ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "All fields are required!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          backgroundColor: Colors.red,
          duration: Duration(milliseconds: 300),
        ),
      );
    }

    if (!isValidMail(e)) {
      return ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Invalid email address!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          backgroundColor: Colors.red,
          duration: Duration(milliseconds: 300),
        ),
      );
    }

    setState(() {
      status = "Processing...";
      registering = true;
    });

    User(
            gender: g,
            lastName: ln,
            bio: '',
            password: p,
            role: '0',
            avatar: '',
            username: u,
            phone: pn,
            status: 204,
            address: ad,
            payload: '',
            email: e,
            firstName: fn,
            id: '')
        .set()
        .then((res) {
      setState(() {
        status = '';
        registering = false;
      });

      String? message = res.payload;
      if (message != null && res.status == 200) {
        registered = true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "$message",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      }
    });
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
                  "THANK YOU FOR CREATING AN ACCOUNT WITH US!",
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 24,
                      color: OColors.primary),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Your account was successful set.",
                  style: TextStyle(
                      color: Color(0xff000000).withOpacity(.7),
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
                SizedBox(
                  child: Row(
                    children: [
                      Text(
                        " A confirmation email was sent to",
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
                Text(
                  "Kindly navigate to it to activate your account",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: OColors.subTitleColor),
                ),
              ],
            ),
    );
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: SizedBox(
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 15),
              child: Icon(
                Icons.arrow_back_ios,
                color: OColors.primary,
              ),
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: _backButton(),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    !registered
                        ? Container(
                            alignment: Alignment.topCenter,
                            margin: const EdgeInsets.only(top: 30),
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: Form(
                              child: Column(
                                children: <Widget>[
                                  Center(
                                    child: Text(
                                      OLocale(isSwahili, 0).get(),
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: OColors.primary,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ), //logo
                                  const SizedBox(
                                    height: 60,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.only(right: 10),
                                          padding: const EdgeInsets.only(
                                              left: 30,
                                              right: 30,
                                              top: 10,
                                              bottom: 10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              border: Border.all(
                                                  color: OColors.primary
                                                      .withOpacity(.2))),
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
                                          margin:
                                              const EdgeInsets.only(right: 10),
                                          padding: const EdgeInsets.only(
                                              left: 30,
                                              right: 30,
                                              top: 10,
                                              bottom: 10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              border: Border.all(
                                                  color: OColors.primary
                                                      .withOpacity(.2))),
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
                                          margin:
                                              const EdgeInsets.only(right: 10),
                                          padding: const EdgeInsets.only(
                                              left: 30,
                                              right: 30,
                                              top: 10,
                                              bottom: 10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              border: Border.all(
                                                  color: OColors.primary
                                                      .withOpacity(.2))),
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
                                  ),
                                  Container(
                                    child: Text(
                                      "Or, register with email...",
                                      style: TextStyle(
                                          color:
                                              OColors.opacity.withOpacity(.7)),
                                    ),
                                    padding: EdgeInsets.zero,
                                    margin: const EdgeInsets.only(
                                        top: 10, bottom: 30),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 10, right: 10),
                                    child: Theme(
                                      data: ThemeData(
                                          primaryColor: OColors.introColor),
                                      child: TextField(
                                        keyboardType: TextInputType.text,
                                        controller: fname,
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(.5)),
                                        decoration: InputDecoration(
                                            prefixIcon: const FaIcon(
                                                FontAwesomeIcons.user),
                                            hintText: "First Name",
                                            focusColor: OColors.primary,
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: OColors.primary
                                                      .withOpacity(.5)),
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black
                                                      .withOpacity(.2)),
                                            ),
                                            hintStyle: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(.3))),
                                      ),
                                    ),
                                  ), // First Name field
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 25, left: 10, right: 10),
                                    child: Theme(
                                      data: ThemeData(
                                          primaryColor: OColors.introColor),
                                      child: TextField(
                                        keyboardType: TextInputType.text,
                                        controller: lname,
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(.5)),
                                        decoration: InputDecoration(
                                            prefixIcon: const FaIcon(
                                                FontAwesomeIcons.user),
                                            hintText: "Last Name",
                                            focusColor: OColors.primary,
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: OColors.primary
                                                      .withOpacity(.5)),
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black
                                                      .withOpacity(.2)),
                                            ),
                                            hintStyle: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(.3))),
                                      ),
                                    ),
                                  ), // First Name field
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 25, left: 10, right: 10),
                                    child: Theme(
                                      data: ThemeData(
                                          primaryColor: OColors.introColor),
                                      child: TextField(
                                        keyboardType: TextInputType.text,
                                        controller: username,
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(.5)),
                                        decoration: InputDecoration(
                                            prefixIcon: const FaIcon(
                                                FontAwesomeIcons.user),
                                            hintText: "Username",
                                            focusColor: OColors.primary,
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: OColors.primary
                                                      .withOpacity(.5)),
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black
                                                      .withOpacity(.2)),
                                            ),
                                            hintStyle: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(.3))),
                                      ),
                                    ),
                                  ), // username field
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 25, left: 10, right: 10),
                                    child: Theme(
                                      data: ThemeData(
                                          primaryColor: OColors.introColor),
                                      child: TextField(
                                        keyboardType: TextInputType.text,
                                        controller: addr,
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(.5)),
                                        decoration: InputDecoration(
                                            prefixIcon: const FaIcon(
                                                FontAwesomeIcons
                                                    .searchLocation),
                                            hintText: "Address",
                                            focusColor: OColors.primary,
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: OColors.primary
                                                      .withOpacity(.5)),
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black
                                                      .withOpacity(.2)),
                                            ),
                                            hintStyle: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(.3))),
                                      ),
                                    ),
                                  ), // username field
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 25, left: 10, right: 10),
                                    child: Theme(
                                      data: ThemeData(
                                          primaryColor: OColors.introColor),
                                      child: DropdownButton(
                                        hint: _dropDownValue == ''
                                            ? Text(
                                                'Select gender',
                                                style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(.4)),
                                              )
                                            : Text(
                                                _dropDownValue,
                                                style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(.4)),
                                              ),
                                        isExpanded: true,
                                        iconSize: 30.0,
                                        style: TextStyle(
                                            color: OColors.introColor),
                                        items: ['Male', 'Female'].map(
                                          (val) {
                                            return DropdownMenuItem<String>(
                                              value: val,
                                              child: Text(val),
                                            );
                                          },
                                        ).toList(),
                                        onChanged: (val) {
                                          setState(
                                            () {
                                              _dropDownValue = val.toString();
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ), // username field
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 25, left: 10, right: 10),
                                    child: Theme(
                                      data: ThemeData(
                                          primaryColor: OColors.introColor),
                                      child: TextField(
                                        keyboardType: TextInputType.phone,
                                        controller: phone,
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(.5)),
                                        decoration: InputDecoration(
                                            prefixIcon: const FaIcon(
                                                FontAwesomeIcons.phone),
                                            hintText: "Phone Number",
                                            focusColor: OColors.primary,
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: OColors.primary
                                                      .withOpacity(.5)),
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black
                                                      .withOpacity(.2)),
                                            ),
                                            hintStyle: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(.3))),
                                      ),
                                    ),
                                  ), // username field
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 25, left: 10, right: 10),
                                    child: Theme(
                                      data: ThemeData(
                                          primaryColor: OColors.introColor),
                                      child: TextField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        controller: email,
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(.5)),
                                        decoration: InputDecoration(
                                            prefixIcon: const FaIcon(
                                                FontAwesomeIcons.at),
                                            hintText: "Email Address",
                                            focusColor: OColors.primary,
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: OColors.primary
                                                      .withOpacity(.5)),
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black
                                                      .withOpacity(.2)),
                                            ),
                                            hintStyle: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(.3))),
                                      ),
                                    ),
                                  ), // username field
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 30, left: 10, right: 10),
                                    child: Theme(
                                      data: ThemeData(
                                          primaryColor: OColors.primary),
                                      child: TextField(
                                        keyboardType: TextInputType.text,
                                        obscureText: obscure,
                                        controller: password,
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(.5)),
                                        decoration: InputDecoration(
                                            prefixIcon: const FaIcon(
                                                FontAwesomeIcons.userLock),
                                            hintText: "Password",
                                            suffixIcon: InkWell(
                                              child: FaIcon(
                                                obscure
                                                    ? FontAwesomeIcons.eyeSlash
                                                    : FontAwesomeIcons.eye,
                                                color: obscure
                                                    ? Colors.black
                                                        .withOpacity(.5)
                                                    : OColors.primary,
                                              ),
                                              onTap: () => setState(() {
                                                obscure =
                                                    obscure ? false : true;
                                              }),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: OColors.primary
                                                      .withOpacity(.2)),
                                            ),
                                            focusColor:
                                                OColors.primary.withOpacity(.5),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black
                                                      .withOpacity(.2)),
                                            ),
                                            hintStyle: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(.3))),
                                        onSubmitted: (value) {
                                          return _Signup();
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 60,
                                  ),
                                  SizedBox(
                                    child: InkWell(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.2,
                                        padding: const EdgeInsets.only(
                                            top: 20,
                                            bottom: 20,
                                            left: 20,
                                            right: 20),
                                        decoration: BoxDecoration(
                                            color: OColors.primary,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(8))),
                                        child: Text(
                                          registering
                                              ? status
                                              : OLocale(isSwahili, 26).get(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: OColors.white,
                                              fontSize: 16),
                                        ),
                                      ),
                                      onTap: () => _Signup(),
                                    ),
                                  ), //register button//password
                                  const SizedBox(
                                    height: 50,
                                  )
                                ],
                              ),
                            ),
                          )
                        : _thankyouPage(user: email.text), //b OR
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
