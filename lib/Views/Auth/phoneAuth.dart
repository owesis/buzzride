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
      alignment: Alignment.bottomCenter,
      width: MediaQuery.of(context).size.width / 1.2,
      height: MediaQuery.of(context).size.height / 1.32,
      child: Container(
        width: 400,
        height: 230,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                OLocale(isSwahili, 33).get(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: OColors.whiteFade,
                ),
              ),
            ), //logo
            const SizedBox(
              height: 10,
            ),

            //TextField: phone Number
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 40,
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
                            borderSide: BorderSide(
                                color: Colors.black12.withOpacity(.3)),
                          ),
                          hintStyle: const TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.3 - 40,
                  child: Theme(
                    data: ThemeData(primaryColor: OColors.introColor),
                    child: TextField(
                      controller: suffixPhoneNumber,
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: OLocale(isSwahili, 37).get(),
                        focusColor: OColors.white,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: OColors.buttonColor.withOpacity(.5)),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black12.withOpacity(.3)),
                        ),
                        hintStyle: TextStyle(color: Colors.white),
                      ),
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
            ),

            const SizedBox(
              height: 40,
            ),
          ],
        ),
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
