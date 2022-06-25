// ignore: file_names
// ignore_for_file: file_names, unnecessary_this

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// String Api = "http://192.168.43.30/";
String Api = "http://172.20.10.3/";
// String Api = "http://192.168.43.30/";
// String Api = "http://api.rd/";
int dark = 0xff000000;
Color mainColor = Color.fromRGBO(25, 25, 25, .8);
Color minerDarkColor = Color.fromRGBO(25, 25, 25, .7);
Color inputBackground = Color.fromRGBO(255, 255, 255, .2);
int background = 0xffF9F9F9;
int inputColor = 0xff606060;
Color minerColor = Color.fromRGBO(255, 255, 255, 1);

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

List<String> exceptions = [
  'a',
  'abaft',
  'about',
  'above',
  'afore',
  'after',
  'along',
  'amid',
  'among',
  'an',
  'apud',
  'as',
  'aside',
  'at',
  'atop',
  'below',
  'but',
  'by',
  'circa',
  'down',
  'for',
  'from',
  'given',
  'in',
  'into',
  'lest',
  'like',
  'mid',
  'midst',
  'minus',
  'near',
  'next',
  'of',
  'off',
  'on',
  'onto',
  'out',
  'over',
  'pace',
  'past',
  'per',
  'plus',
  'pro',
  'qua',
  'round',
  'sans',
  'save',
  'since',
  'than',
  'thru',
  'till',
  'times',
  'to',
  'under',
  'until',
  'unto',
  'up',
  'upon',
  'via',
  'vice',
  'with',
  'worth',
  'the","and',
  'nor',
  'or',
  'yet',
  'so'
];

String capitalize(String text) {
  return text.toLowerCase().replaceAllMapped(
      RegExp(
          r'[A-Z]{2,}(?=[A-Z][a-z]+[0-9]*|\b)|[A-Z]?[a-z]+[0-9]*|[A-Z]|[0-9]+'),
      (Match match) {
    if (exceptions.contains(match[0])) {
      return match[0].toString();
    }
    return "${match[0]![0].toUpperCase()}${match[0]!.substring(1).toLowerCase()}";
  }).replaceAll(RegExp(r'(_|-)+'), ' ');
}

bool isValidMail(String email) => RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
    .hasMatch(email);

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Future<Object?> Pager(BuildContext context, var page) => Navigator.of(context)
    .push(MaterialPageRoute(builder: (BuildContext context) => page));

Future<Object?> pagerRemove(BuildContext context, var page) =>
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => page,
        ),
        ModalRoute.withName('/'));

extension captalize on String {
  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';
  String get allInCaps => this.toUpperCase();
  String get capitalizeFirstofEach =>
      this.split(" ").map((str) => str.toUpperCase()).join(" ");
}

mixin InputValidationMixin {
  bool isContent(String content) => content.length >= 5;
  bool isPhone(String phone) => phone.length >= 5;
  bool isPrice(String price) => price.length >= 5;
  bool isImages(List images) => images.length > 0;

  bool isEmailValid(String email) {
    var pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }
}

void error(
        {required BuildContext context, required String error, Color? color}) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "${error}",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
        backgroundColor: color != null ? color : Colors.red,
        duration: Duration(milliseconds: 2000),
      ),
    );
