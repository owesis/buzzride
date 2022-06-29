import 'dart:ui';

import 'package:flutter/material.dart';

import 'divider.dart';

class BizHome extends StatefulWidget {
  const BizHome({Key? key}) : super(key: key);

  @override
  State<BizHome> createState() => _BizHomeState();
}

class _BizHomeState extends State<BizHome> {
  TextEditingController lct = TextEditingController();
  String location = '';
  String goo = 'two';

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
        goo = 'one';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(children: [
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
      goo != 'one' ? postion1 : postion2
    ]));
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
      left: 15,
      right: 15,
      bottom: 15,
      child: Container(
        height: location.isEmpty ? 115.0 : 158,
        decoration: const BoxDecoration(
            color: Color(0xff0099cc),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
              bottomLeft: Radius.circular(25.0),
              bottomRight: Radius.circular(25.0),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black,
                  blurRadius: 16.0,
                  spreadRadius: 0.5,
                  offset: Offset(0.7, 0.7))
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
          child: Row(
            children: [
              const SizedBox(
                height: 2.0,
              ),

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
                        height: 2,
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

                      // Divider line
                      location.isNotEmpty ? divDier : const SizedBox(),

                      // Drop off inf0
                      location.isEmpty
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //Search box
                                SizedBox(
                                  height: 40,
                                  width: 180,
                                  // decoration: BoxDecoration(
                                  //   // color: Colors.grey[500]!.withOpacity(0.5),
                                  //   // borderRadius: BorderRadius.circular(8),
                                  // ),
                                  child: Center(
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
                                ),

                                // Search Icon
                                GestureDetector(
                                  onTap: () {
                                    search();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top: 16.0),
                                    decoration: BoxDecoration(
                                      color: const Color(0xfffdc50c),
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
                                    Text(location + ' ?',
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
                                        color: const Color(0xfffdc50c),
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black,
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
      left: 15,
      right: 15,
      bottom: 15,
      child: Column(
        children: [
          Container(
            height: 450.0,
            decoration: const BoxDecoration(
                color: Color(0xff0099cc),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                  bottomLeft: Radius.circular(25.0),
                  bottomRight: Radius.circular(25.0),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      blurRadius: 16.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7))
                ]),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
              child: Column(
                children: [
                  transportInfo(),
                  const SizedBox(
                    height: 2.0,
                  ),
                  Column(
                    children: [Text('data')],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              // height: 300,
              width: 250,
              decoration: BoxDecoration(
                color: const Color(0xfffdc50c),
                borderRadius: BorderRadius.circular(16),
              ),
              // ignore: deprecated_member_use
              child: FlatButton(
                onPressed: () {
                  // getLogin();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => const BizHome()));
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
      ));

  Row transportInfo() {
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
                location.isNotEmpty ? divDier : const SizedBox(),
                location.isEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //Search box
                          SizedBox(
                            height: 40,
                            width: 180,
                            // decoration: BoxDecoration(
                            //   // color: Colors.grey[500]!.withOpacity(0.5),
                            //   // borderRadius: BorderRadius.circular(8),
                            // ),
                            child: Center(
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
                          ),

                          // Search Icon
                          GestureDetector(
                            onTap: () {
                              search();
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 16.0),
                              decoration: BoxDecoration(
                                color: const Color(0xfffdc50c),
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
                              Text(location + ' ?',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                            ],
                          ),

                          // Search Icon

                          GestureDetector(
                            onTap: () {
                              search();
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 16.0),
                              decoration: BoxDecoration(
                                  color: const Color(0xfffdc50c),
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black,
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
    );
  }

  Widget get divDier => Column(children: [
        SizedBox(height: 25),
        DividerWidget(),
        SizedBox(height: 10),
      ]);
}
