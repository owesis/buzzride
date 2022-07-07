import 'package:buzzride/Util/Util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Rider extends StatelessWidget {
  const Rider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(top: defaultPadding),
        child: ListTile(
          leading: const CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage("assets/images/Avatar.png"),
          ),
          title: const Text(
            "Mike Rojnidoost",
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: const Text("860m - 28min"),
          trailing: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: primaryColor,
              shape: const CircleBorder(),
              minimumSize: const Size(48, 48),
            ),
            onPressed: () {},
            child: SvgPicture.asset(
              "assets/images/chat.svg",
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
