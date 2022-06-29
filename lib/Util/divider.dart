import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 1.0,
      color: Colors.black,
      thickness: 1.0,
    );
  }
}



  // Positioned(
  //         left: 15,
  //         right: 15,
  //         bottom: 15,
  //         child: Container(
  //           height: 115.0,
  //           decoration: const BoxDecoration(
  //               color: Color(0xff0099cc),
  //               borderRadius: BorderRadius.only(
  //                 topLeft: Radius.circular(25.0),
  //                 topRight: Radius.circular(25.0),
  //                 bottomLeft: Radius.circular(25.0),
  //                 bottomRight: Radius.circular(25.0),
  //               ),
  //               boxShadow: [
  //                 BoxShadow(
  //                     color: Colors.black,
  //                     blurRadius: 16.0,
  //                     spreadRadius: 0.5,
  //                     offset: Offset(0.7, 0.7))
  //               ]),
  //           child: Padding(
  //             padding:
  //                 const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 const SizedBox(
  //                   height: 3.0,
  //                 ),
  //                 const Text(
  //                   'Hi there',
  //                   style: TextStyle(fontSize: 12.0, color: Colors.white),
  //                 ),
  //                 const SizedBox(
  //                   height: 3.0,
  //                 ),
  //                 Row(
  //                   children: [
  //                     const Icon(
  //                       Icons.arrow_forward,
  //                       size: 17,
  //                       color: Colors.green,
  //                     ),
  //                     const SizedBox(
  //                       width: 3.0,
  //                     ),
  //                     RichText(
  //                         textAlign: TextAlign.start,
  //                         text: const TextSpan(children: [
  //                           TextSpan(
  //                               text: 'From : ',
  //                               style: TextStyle(
  //                                   fontWeight: FontWeight.normal,
  //                                   fontSize: 12.0,
  //                                   color: Colors.white)),
  //                           TextSpan(
  //                               text: ' Posta-Shaban Robart str',
  //                               style: TextStyle(
  //                                   fontSize: 13.0, color: Colors.white)),
  //                         ])),
  //                   ],
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.symmetric(
  //                     horizontal: 20.0,
  //                   ),
  //                   child: SizedBox(
  //                     height: 40,
  //                     width: 200,
  //                     // decoration: BoxDecoration(
  //                     //   // color: Colors.grey[500]!.withOpacity(0.5),
  //                     //   // borderRadius: BorderRadius.circular(8),
  //                     // ),
  //                     child: Center(
  //                       child: Padding(
  //                         padding: const EdgeInsets.only(left: 8.0),
  //                         child: TextField(
  //                           // controller: username,
  //                           decoration: const InputDecoration(
  //                             hintText: 'Where to?',
  //                             hintStyle: TextStyle(
  //                                 color: Colors.white,
  //                                 fontWeight: FontWeight.bold,
  //                                 fontSize: 19),
  //                           ),
  //                           // obscureText: true,
  //                           style: const TextStyle(
  //                               color: Colors.white,
  //                               fontWeight: FontWeight.bold,
  //                               fontSize: 19),
  //                           keyboardType: TextInputType.text,
  //                           textInputAction: TextInputAction.search,

  //                           onChanged: (value) {
  //                             setState(() {
  //                               //_email = value;
  //                             });
  //                           },
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ))















    // Positioned(
    //       left: 0,
    //       right: 0,
    //       bottom: 0,
    //       child: Container(
    //         height: 320.0,
    //         decoration: const BoxDecoration(
    //             color: Colors.white,
    //             borderRadius: BorderRadius.only(
    //                 topLeft: Radius.circular(18.0),
    //                 topRight: Radius.circular(18.0)),
    //             boxShadow: [
    //               BoxShadow(
    //                   color: Colors.black,
    //                   blurRadius: 16.0,
    //                   spreadRadius: 0.5,
    //                   offset: Offset(0.7, 0.7))
    //             ]),
    //         child: Padding(
    //           padding:
    //               const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               SizedBox(
    //                 height: 6.0,
    //               ),
    //               Text(
    //                 'Hi there',
    //                 style: TextStyle(fontSize: 12.0),
    //               ),
    //               Text(
    //                 'Where to',
    //                 style: TextStyle(
    //                   fontSize: 20.0,
    //                 ),
    //               ),
    //               SizedBox(
    //                 height: 20.0,
    //               ),
    //               Container(
    //                 decoration: BoxDecoration(
    //                     color: Colors.white,
    //                     borderRadius: BorderRadius.circular(5.0),
    //                     boxShadow: [
    //                       BoxShadow(
    //                           color: Colors.black54,
    //                           blurRadius: 6.0,
    //                           spreadRadius: 0.5,
    //                           offset: Offset(0.7, 0.7))
    //                     ]),
    //                 child: Padding(
    //                   padding: const EdgeInsets.all(8.0),
    //                   child: Row(
    //                     children: [
    //                       Icon(Icons.search, color: Colors.yellowAccent),
    //                       SizedBox(
    //                         width: 10.0,
    //                       ),
    //                       Text('Search Drop Off'),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //               SizedBox(
    //                 height: 24.0,
    //               ),
    //               Row(
    //                 children: [
    //                   Icon(
    //                     Icons.home,
    //                     color: Colors.grey,
    //                   ),
    //                   SizedBox(width: 12),
    //                   Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       Text('Add Home'),
    //                       SizedBox(height: 4.0),
    //                       Text("Your living home addres",
    //                           style: TextStyle(
    //                               color: Colors.black54, fontSize: 12.0))
    //                     ],
    //                   )
    //                 ],
    //               ),
    //               SizedBox(
    //                 height: 10.0,
    //               ),
    //               DividerWidget(),
    //               SizedBox(
    //                 height: 16.0,
    //               ),
    //               Row(
    //                 children: [
    //                   Icon(
    //                     Icons.work,
    //                     color: Colors.grey,
    //                   ),
    //                   SizedBox(width: 12),
    //                   Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       Text('Add Work'),
    //                       SizedBox(height: 4.0),
    //                       Text("Your office address",
    //                           style: TextStyle(
    //                               color: Colors.black54, fontSize: 12.0))
    //                     ],
    //                   )
    //                 ],
    //               )
    //             ],
    //           ),
    //         ),
    //       ))
    
  