import 'package:buzzride/Util/Colors.dart';
import 'package:buzzride/Util/Drawer/drawer.dart';
import 'package:buzzride/Util/Util.dart';
import 'package:buzzride/Util/divider.dart';
import 'package:flutter/material.dart';

import '../../Util/Locale.dart';
import '../../Util/pallets.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController lct = TextEditingController();
  String location = '';

  late final _drawerController;

  bool isSwahili = false, isVisibleDrawer = true, paged = false, r = false;

  List<Widget> menus = [
    ListTile(
      onTap: () => () {},
      leading: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(color: Colors.blueAccent),
        child: Icon(Icons.category, color: OColors.whiteFade),
      ),
      title: Text(
        "Home",
        style: TextStyle(color: OColors.white, fontSize: 16),
      ),
    ),
  ];

  @override
  void initState() {
    _drawerController = ZiDrawerController();
    // TODO: implement initState
    super.initState();
  }

  void MenuCategories() {
    setState(() {
      menus.add(Spacer());

      menus.add(Container(
        height: MediaQuery.of(context).size.height / 1.6,
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
        alignment: Alignment.bottomCenter,
        child: ListView(
          children: [
            ListTile(
              onTap: () => () {},
              leading: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Icon(Icons.home_filled, color: OColors.whiteFade),
              ),
              title: Text(
                "Home",
                style: TextStyle(color: OColors.white, fontSize: 16),
              ),
            ),
            ListTile(
              onTap: () => () {},
              leading: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Icon(Icons.history, color: OColors.whiteFade),
              ),
              title: Text(
                "Travel History",
                style: TextStyle(color: OColors.white, fontSize: 16),
              ),
            ),
            ListTile(
              onTap: () => () {},
              leading: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Icon(Icons.notifications_outlined,
                    color: OColors.whiteFade),
              ),
              title: Text(
                "Notifications",
                style: TextStyle(color: OColors.white, fontSize: 16),
              ),
            ),
            ListTile(
              onTap: () => () {},
              leading: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Icon(Icons.settings, color: OColors.whiteFade),
              ),
              title: Text(
                "Settings",
                style: TextStyle(color: OColors.white, fontSize: 16),
              ),
            )
          ],
        ),
      ));

      menus.add(Spacer());

      menus.add(DefaultTextStyle(
        style: TextStyle(
          fontSize: 12,
          color: Colors.white54,
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 16.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 20,
              ),
              Text(
                'Designed & Developed with ',
                style: TextStyle(
                    color: OColors.white.withOpacity(.4),
                    fontWeight: FontWeight.w800),
              ),
              Icon(
                Icons.favorite,
                color: Colors.white.withOpacity(.6),
              ),
              SizedBox(
                width: 5,
              ),
              InkWell(
                child: Text(
                  "by OWESIS",
                  style: TextStyle(
                      color: OColors.white.withOpacity(.4),
                      fontWeight: FontWeight.w800),
                ),
                onTap: () => launchURL("https://owesis.com"),
              )
            ],
          ),
        ),
      ));
    });
  }

  search() {
    if (lct.text.isNotEmpty) {
      setState(() {
        location = lct.text.toString();
      });
    }
  }

  go() {
    if (lct.text.isNotEmpty) {
      setState(() {
        paged = true;
      });
    }
  }

  send() {
    if (lct.text.isNotEmpty) {
      setState(() {
        paged = false;
        r = true;
      });
    }
  }

  Widget? _menuButton(BuildContext context) {
    setState(() {
      menus.clear();
      MenuCategories();
    });

    return SizedBox(
      child: InkWell(
        child: isVisibleDrawer
            ? Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                    color: OColors.primary,
                    borderRadius: BorderRadius.all(Radius.circular(100))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 3,
                      width: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: OColors.white,
                      ),
                    ),
                    Container(
                      height: 3,
                      margin: const EdgeInsets.only(top: 3),
                      width: 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: OColors.white),
                    ),
                    Container(
                      height: 3,
                      margin: EdgeInsets.only(top: 4),
                      width: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: OColors.white,
                      ),
                    ),
                  ],
                ),
              )
            : Icon(
                Icons.cancel,
                size: 32,
                color: OColors.buttonColor,
              ),
        onTap: () {
          _drawerController.showDrawer();
          setState(() {
            if (_drawerController.value.visible) {
              isVisibleDrawer = false;
            } else {
              isVisibleDrawer = true;
            }
          });

          _drawerController.addListener(() {
            setState(() {
              if (_drawerController.value.visible) {
                isVisibleDrawer = false;
              } else {
                isVisibleDrawer = true;
              }
            });
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawerer(
        backdropColor: OColors.whiteFade,
        controller: _drawerController,
        drawer: SafeArea(
          child: Container(
            alignment: Alignment.bottomCenter,
            color: OColors.primary,
            child: ListTileTheme(
              textColor: OColors.white,
              iconColor: OColors.primary,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  verticalDirection: VerticalDirection.down,
                  children: menus,
                ),
              ),
            ),
          ),
        ),
        child: Scaffold(
          body: SafeArea(
            child: Stack(alignment: Alignment.center, children: [
              // Map
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bizzmap.png'),
                    fit: BoxFit.fill,
                    // colorFilter:
                    //     const ColorFilter.mode(Colors.black54, BlendMode.darken),
                  ),
                ),
              ),

              !paged ? postion1 : postion2,

              !r ? SizedBox() : postion3,

              // Drawer
              MenuButton(context),

              // logo
              //logoOnMap(), // This logo may not be needed to rendered to the user
            ]),
          ),
        ));
  }

  Positioned MenuButton(BuildContext context) {
    return Positioned(
        top: 25,
        left: 0,
        child: Container(
          child: _menuButton(context),
        ));
  }

  Positioned logoOnMap() {
    return Positioned(
        top: 10,
        right: 0,
        child: Padding(
          padding: EdgeInsets.only(top: 8.0, right: 15),
          child: Image(
            image: AssetImage("assets/images/logo.png"),
            width: 50,
            height: 50,
          ),
        ));
  }

  Column iconInfo() {
    return Column(
      children: [
        const Icon(
          Icons.arrow_forward,
          size: 17,
          color: Colors.green,
        ),
        location.isNotEmpty
            ? Container(
                height: 60,
                child: VerticalDivider(
                  color: Colors.white54,
                  width: 10,
                  thickness: 1.5,
                ),
              )
            : const SizedBox(
                height: 1,
              ),
        location.isNotEmpty
            ? const Icon(
                Icons.arrow_forward,
                size: 17,
                color: Colors.green,
              )
            : SizedBox(),
      ],
    );
  }

  Widget get postion1 => Positioned(
      bottom: 20,
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width / 1.2,
        decoration: BoxDecoration(
            color: OColors.primary,
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(.3),
                  blurRadius: 16.0,
                  spreadRadius: 0.5,
                  offset: const Offset(0.7, 0.7))
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
          child: Row(
            children: [
              // Icons Widgets Column
              iconInfo(),

              //info Column
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      location.isEmpty
                          ? const Text(
                              'Hi there',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.white),
                            )
                          : const SizedBox(),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          location.isNotEmpty
                              ? const Text('PICK UP',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white70,
                                      fontSize: 14))
                              : const SizedBox(),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: RichText(
                                textAlign: TextAlign.start,
                                text: const TextSpan(children: [
                                  TextSpan(
                                      text: 'From : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12.0,
                                          color: Colors.white)),
                                  TextSpan(
                                      text: ' Posta-Shaban Robart str',
                                      style: TextStyle(
                                          fontSize: 13.0, color: Colors.white)),
                                ])),
                          ),
                        ],
                      ),

                      location.isNotEmpty
                          ? Divider(
                              color: OColors.borderColor.withOpacity(.5),
                            )
                          : const SizedBox(
                              height: 2,
                            ),

                      // Drop off inf0
                      location.isEmpty
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //Search box
                                SizedBox(
                                  width: 175,
                                  // decoration: BoxDecoration(
                                  //   // color: Colors.grey[500]!.withOpacity(0.5),
                                  //   // borderRadius: BorderRadius.circular(8),
                                  // ),
                                  child: Container(
                                      padding: const EdgeInsets.only(left: 4.0),
                                      child: TextField(
                                        controller: lct,
                                        decoration: InputDecoration(
                                            hintText: 'Where to?',
                                            hintStyle: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 19),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: OColors.white
                                                      .withOpacity(1)),
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white
                                                      .withOpacity(.5)),
                                            )),
                                        // obscureText: true,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 19),
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.search,
                                        onChanged: (value) {
                                          setState(() {
                                            //_email = value;
                                          });
                                        },
                                      )),
                                ),

                                // Search Icon
                                GestureDetector(
                                  onTap: () {
                                    search();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top: 16.0),
                                    decoration: BoxDecoration(
                                      color: OColors.buttonColor,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    // ignore: deprecated_member_use
                                    child: Padding(
                                      padding: const EdgeInsets.all(7.0),
                                      child: Icon(
                                        Icons.search,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //Search box
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('DROP OFF',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white70,
                                            fontSize: 14)),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(location,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18)),
                                  ],
                                ),

                                // Search Icon
                                GestureDetector(
                                  onTap: () {
                                    go();
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 16.0),
                                    decoration: BoxDecoration(
                                        color: OColors.buttonColor,
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(.4),
                                              blurRadius: 3.0,
                                              spreadRadius: 0.2,
                                              offset: Offset(0.3, 0.3))
                                        ]),
                                    // ignore: deprecated_member_use
                                    child: const Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Text('Go',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 19,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ));

  Widget get postion2 => Positioned(
      bottom: 15,
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 1.1,
        height: MediaQuery.of(context).size.height / 1.14,
        child: Column(
          children: [
            Expanded(
                child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: OColors.primary,
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(.4),
                        blurRadius: 16.0,
                        spreadRadius: 0.5,
                        offset: const Offset(0.7, 0.7))
                  ]),
              child: ListView(
                children: [
                  // Top Transport Info
                  Container(
                      decoration: BoxDecoration(
                          color: OColors.primary,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(.4),
                                blurRadius: 16.0,
                                spreadRadius: 0.5,
                                offset: const Offset(0.7, 0.7))
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 18.0,
                          right: 18.0,
                          bottom: 6,
                          top: 4,
                        ),
                        child: transportInfo(),
                      )),

                  const SizedBox(
                    height: 30,
                  ),

                  // Transport Type header
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28.0, vertical: 8),
                    child: Text(
                      OLocale(isSwahili, 40).get(),
                      style: TextStyle(
                          color: OColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),

                  //Transport Type View
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 10.0),
                          child: transportTypeInfo(OLocale(isSwahili, 41).get(),
                              'assets/images/logo.png'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 10.0),
                          child: transportTypeInfo(OLocale(isSwahili, 42).get(),
                              'assets/images/logo.png'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 10.0),
                          child: transportTypeInfo(OLocale(isSwahili, 43).get(),
                              'assets/images/logo.png'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 10.0),
                          child: transportTypeInfo(OLocale(isSwahili, 43).get(),
                              'assets/images/logo.png'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),

            const SizedBox(
              height: 20,
            ),

            // Send Request Buttons
            Center(
              child: Container(
                // height: 300,
                width: 250,
                decoration: BoxDecoration(
                  color: OColors.buttonColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                // ignore: deprecated_member_use
                child: FlatButton(
                  onPressed: () {
                    send();
                  },
                  child: Text(
                    OLocale(isSwahili, 46).get(),
                    style: buttonsText.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ));

  Widget get postion3 => Positioned(
      bottom: 15,
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 1.1,
        height: MediaQuery.of(context).size.height / 1.2,
        child: Column(
          children: [
            Expanded(
                child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: OColors.primary,
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(.4),
                        blurRadius: 16.0,
                        spreadRadius: 0.5,
                        offset: const Offset(0.7, 0.7))
                  ]),
              child: ListView(
                children: [
                  // Top Transport Info
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${OLocale(isSwahili, 41).get()} information',
                        style: transportTypeHeader,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 100,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        image: DecorationImage(
                          image: AssetImage('assets/images/bizzmap.png'),
                          fit: BoxFit.fill,

                          // colorFilter:
                          //     const ColorFilter.mode(Colors.black54, BlendMode.darken),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //Driver info
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('First Lastname',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12.0,
                                    color: Colors.white)),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text('Driver',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12.0,
                                    color: Colors.white)),
                            RichText(
                                textAlign: TextAlign.start,
                                text: const TextSpan(children: [
                                  TextSpan(
                                      text: 'Trips : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12.0,
                                          color: Colors.white)),
                                  TextSpan(
                                      text: ' 48',
                                      style: TextStyle(
                                          fontSize: 13.0, color: Colors.white)),
                                ])),
                          ],
                        ),
                      ),

                      // Driver profile
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 28,
                          backgroundColor: Colors.white,
                          child: Image(
                            image: AssetImage('assets/images/user.png'),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // TO BE CONTINUE ... GoING TO WORK now ..........................
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          width: 170, height: 120, child: transportInfo()),
                      Column(
                        children: [
                          Text(
                            'Distance 6.3 kms',
                            style: driverProfile2,
                          ),
                          Text(
                            'Cost 6,500/= Tsh',
                            style: driverProfile2,
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            )),
            const SizedBox(
              height: 10,
            ),

            // Send Request Buttons
            Center(
              child: Container(
                // height: 300,
                width: 250,
                decoration: BoxDecoration(
                  color: OColors.buttonColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                // ignore: deprecated_member_use
                child: FlatButton(
                  onPressed: () {
                    // getLogin();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const MyHomePage()));
                  },
                  child: Text(
                    'Confirm',
                    style: buttonsText.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ));

  Row transportTypeInfo(tType, image) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tType,
          style: transportType,
        ),
        Image(
          image: AssetImage(
            image,
          ),
          width: 50,
          height: 40,
        )
      ],
    );
  }

  Row transportInfo({buttoned = true}) {
    return Row(
      children: [
        // Icons Widgets Column
        iconInfo(),

        //info Column
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                location.isEmpty
                    ? const Text(
                        'Hi there',
                        style: TextStyle(fontSize: 12.0, color: Colors.white),
                      )
                    : const SizedBox(),
                const SizedBox(
                  height: 2,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    location.isNotEmpty
                        ? const Text('PICK UP',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white70,
                                fontSize: 14))
                        : const SizedBox(),
                    RichText(
                        textAlign: TextAlign.start,
                        text: const TextSpan(children: [
                          TextSpan(
                              text: 'From : ',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12.0,
                                  color: Colors.white)),
                          TextSpan(
                              text: ' Posta-Shaban Robart str',
                              style: TextStyle(
                                  fontSize: 13.0, color: Colors.white)),
                        ])),
                  ],
                ),
                SizedBox(
                  height: 3,
                ),
                location.isNotEmpty
                    ? Divider(
                        color: OColors.borderColor.withOpacity(.4),
                      )
                    : const SizedBox(),
                location.isEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //Search box
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            // decoration: BoxDecoration(
                            //   // color: Colors.grey[500]!.withOpacity(0.5),
                            //   // borderRadius: BorderRadius.circular(8),
                            // ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: TextField(
                                controller: lct,
                                decoration: const InputDecoration(
                                  hintText: 'Where to?',
                                  hintStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19),
                                ),
                                // obscureText: true,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19),
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.search,

                                onChanged: (value) {
                                  setState(() {
                                    //_email = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //Search box
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('DROP OFF',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white70,
                                      fontSize: 14)),
                              SizedBox(
                                height: 5,
                              ),
                              Text(location,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                            ],
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget get divDier => Column(children: const [
        SizedBox(height: 25),
        DividerWidget(),
        SizedBox(height: 10),
      ]);
}
