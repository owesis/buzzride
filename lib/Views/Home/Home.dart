import 'package:buzzride/Util/Colors.dart';
import 'package:buzzride/Util/Drawer/drawer.dart';
import 'package:buzzride/Util/Util.dart';
import 'package:buzzride/Util/divider.dart';
import 'package:flutter/material.dart';

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

  bool isVisibleDrawer = true, paged = false;

  List<Widget> menus = [];

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
        child: ListView.builder(
          itemBuilder: (BuildContext context, index) => ListTile(
            onTap: () => () {},
            leading:
                Icon(Icons.category, color: OColors.whiteFade.withOpacity(.6)),
            title: Text(
              "Home",
              style: TextStyle(color: OColors.white, fontSize: 16),
            ),
          ),
          itemCount: 2,
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
                      width: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: OColors.white,
                      ),
                    ),
                    Container(
                      height: 3,
                      margin: EdgeInsets.only(top: 7),
                      width: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: OColors.white),
                    ),
                    Container(
                      height: 3,
                      margin: EdgeInsets.only(top: 7),
                      width: 20,
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
    Size size = MediaQuery.of(context).size;

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
              Positioned(
                  top: 10,
                  left: 0,
                  child: Container(
                    child: _menuButton(context),
                  )),
            ]),
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
            borderRadius: BorderRadius.all(Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(.3),
                  blurRadius: 16.0,
                  spreadRadius: 0.5,
                  offset: Offset(0.7, 0.7))
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
                      SizedBox(
                        height: 1,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          location.isNotEmpty
                              ? Text('PICK UP',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white70,
                                      fontSize: 14))
                              : SizedBox(),
                          Padding(
                            padding: EdgeInsets.only(top: 5, bottom: 5),
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

                      Divider(
                        color: OColors.borderColor.withOpacity(.5),
                      ),

                      // Drop off inf0
                      location.isEmpty
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //Search box
                                SizedBox(
                                  width: 180,
                                  // decoration: BoxDecoration(
                                  //   // color: Colors.grey[500]!.withOpacity(0.5),
                                  //   // borderRadius: BorderRadius.circular(8),
                                  // ),
                                  child: Container(
                                      padding: EdgeInsets.only(left: 4.0),
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
                                      padding: const EdgeInsets.all(8.0),
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
      child: Container(
        width: MediaQuery.of(context).size.width / 1.1,
        height: MediaQuery.of(context).size.height / 1.34,
        child: Column(
          children: [
            Expanded(
                child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: OColors.primary,
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(.4),
                        blurRadius: 16.0,
                        spreadRadius: 0.5,
                        offset: Offset(0.7, 0.7))
                  ]),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 18.0),
                child: ListView(
                  children: [
                    transportInfo(),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'data',
                      style: TextStyle(
                          color: OColors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            )),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                // height: 300,
                width: 250,
                decoration: BoxDecoration(
                  color: OColors.primary,
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
                    'Send Request',
                    style: TextStyle(fontSize: 22, color: Colors.white)
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ));

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

  Widget get divDier => Column(children: [
        SizedBox(height: 25),
        DividerWidget(),
        SizedBox(height: 10),
      ]);
}
