// ignore_for_file: file_names
// ignore: file_names
// import 'package:flare_flutter/flare_actor.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:zali/Util/Colors.dart';
// import 'package:zali/Util/Locale.dart';
//
// class PinAuth extends StatefulWidget {
//   PinAuth({Key key, this.email}) : super(key: key);
//   final email;
//   PinAuthState createState() => PinAuthState();
// }
//
// class PinAuthState extends State<PinAuth> with TickerProviderStateMixin {
//   var onTapRecognizer, email = '';
//   bool isSwahili = false;
//   AnimationController rotationController;
//   TextEditingController textEditingController = TextEditingController();
//
//   bool hasError = false;
//   String currentText = "";
//   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
//   @override
//   void initState() {
//     rotationController = AnimationController(
//       duration: const Duration(seconds: 5),
//       vsync: this,
//     );
//     rotationController.repeat();
//     email = widget.email;
//     email = email.substring(0, 6) + '******';
//     onTapRecognizer = TapGestureRecognizer()
//       ..onTap = () {
//         Navigator.pop(context);
//       };
//
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   Widget _backButton() {
//     return InkWell(
//       onTap: () {
//         Navigator.pop(context);
//       },
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 10),
//         child: Row(
//           children: <Widget>[
//             Container(
//               padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
//               child: Icon(Icons.keyboard_arrow_left, color: OColors.secondary),
//             ),
//             Text(OLocale(isSwahili, 30).get(),
//                 style: TextStyle(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w500,
//                     color: OColors.secondary))
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       backgroundColor: OColors.white,
//       key: scaffoldKey,
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         child: ListView(
//           children: <Widget>[
//             _backButton(),
//             SizedBox(height: 100),
//             RotationTransition(
//               turns: Tween(begin: 0.0, end: 1.0).animate(rotationController),
//               child: Container(
//                 width: MediaQuery.of(context).size.width / 2,
//                 height: 200,
//                 child: Center(
//                   child: Image.asset(
//                     "./assets/images/otp.png",
//                     width: 200,
//                   ),
//                 ),
//               ),
//             ),
//             // Image.asset(
//             //   'assets/verify.png',
//             //   height: MediaQuery.of(context).size.height / 3,
//             //   fit: BoxFit.fitHeight,
//             // ),
//             SizedBox(height: 8),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8.0),
//               child: Text(
//                 'Email Verification',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
//               child: RichText(
//                 text: TextSpan(
//                     text: "Enter the code sent to ",
//                     children: [
//                       TextSpan(
//                           text: email,
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 15)),
//                     ],
//                     style: TextStyle(color: Colors.black54, fontSize: 15)),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Container(
//               width: 100,
//               padding: EdgeInsets.only(left: 40, right: 40),
//               height: 70,
//               child: Theme(
//                 data: ThemeData(primaryColor: OColors.secondary),
//                 child: PinCodeTextField(
//                   length: 4,
//                   obsecureText: false,
//                   animationType: AnimationType.fade,
//                   shape: PinCodeFieldShape.box,
//                   autoFocus: false,
//                   animationDuration: Duration(milliseconds: 300),
//                   borderRadius: BorderRadius.circular(5),
//                   fieldHeight: 50,
//                   fieldWidth: 50,
//                   inactiveFillColor: OColors.buttonColor,
//                   activeFillColor: Colors.white,
//                   enableActiveFill: false,
//                   backgroundColor: Colors.transparent,
//                   controller: textEditingController,
//                   onCompleted: (v) {
// //                    print("Completed");
//                   },
//                   onChanged: (value) {
// //                    print(value);
// //                    setState(() {
// //                      currentText = value;
// //                    });
//                   },
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 30.0),
//               child: Text(
//                 hasError ? "*Please fill up all the cells properly" : "",
//                 style: TextStyle(color: Colors.red.shade300, fontSize: 15),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             RichText(
//               textAlign: TextAlign.center,
//               text: TextSpan(
//                   text: "Didn't receive the code? ",
//                   style: TextStyle(color: Colors.black54, fontSize: 15),
//                   children: [
//                     TextSpan(
//                         text: " RESEND",
//                         recognizer: onTapRecognizer,
//                         style: TextStyle(
//                             color: OColors.secondary,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16))
//                   ]),
//             ),
//             SizedBox(
//               height: 14,
//             ),
//             Container(
//               margin:
//                   const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
//               child: ButtonTheme(
//                 height: 50,
//                 child: FlatButton(
//                   onPressed: () {
//                     // conditions for validating
//                     if (currentText.length != 4 || currentText != "towtow") {
//                       setState(() {
//                         hasError = true;
//                       });
//                     } else {
//                       setState(() {
//                         hasError = false;
//                         scaffoldKey.currentState.showSnackBar(SnackBar(
//                           content: Text("Aye!!"),
//                           duration: Duration(seconds: 2),
//                         ));
//                       });
//                     }
//                   },
//                   child: Center(
//                       child: Text(
//                     "VERIFY".toUpperCase(),
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold),
//                   )),
//                 ),
//               ),
//               padding: EdgeInsets.only(top: 5, bottom: 5),
//               decoration: BoxDecoration(
//                   color: OColors.secondary,
//                   borderRadius: BorderRadius.circular(5),
//                   boxShadow: [
//                     BoxShadow(
//                         color: OColors.secondary.withOpacity(.2),
//                         offset: Offset(1, -2),
//                         blurRadius: 5),
//                     BoxShadow(
//                         color: OColors.secondary.withOpacity(.2),
//                         offset: Offset(-1, 2),
//                         blurRadius: 5)
//                   ]),
//             ),
//             SizedBox(
//               height: 16,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 FlatButton(
//                   child: Text("Clear"),
//                   onPressed: () {
//                     textEditingController.clear();
//                   },
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
