// ignore_for_file: file_names, prefer_const_constructors

import 'package:buzzride/Util/CenterButton.dart';
import 'package:buzzride/Util/button.view.dart';
import 'package:flutter/material.dart';

class BottomNavi extends StatefulWidget {
  final Color? backgroundColor;
  final List<ButtonData> buttonData;
  final CenterButton? centerButton;
  final Widget? fabIcon;
  final int? selected;

  final Color? buttonColor;
  final Color? buttonSelectedColor;
  final List<Color>? fabColors;

  final Function(dynamic selectedPage) onChange;
  final VoidCallback? onFabButtonPressed;

  const BottomNavi({
    Key? key,
    required this.buttonData,
    required this.onChange,
    this.backgroundColor,
    this.centerButton,
    this.fabIcon,
    this.fabColors,
    this.onFabButtonPressed,
    this.buttonColor,
    this.buttonSelectedColor,
    this.selected,
  }) : super(key: key);

  @override
  _BottomNaviState createState() => _BottomNaviState();
}

class _BottomNaviState extends State<BottomNavi> {
  final double ZSize = 60;
  final Color unSelectedColor = Colors.grey;
  late CenterButton _centerButton;

  dynamic selectedId = 0;

  @override
  void initState() {
    selectedId = widget.selected ?? selectedId;

    _centerButton = widget.centerButton ??
        CenterButton(
          size: ZSize,
          icon: widget.fabIcon,
          onTap: widget.onFabButtonPressed,
          colors: widget.fabColors,
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final clipper = _BottomNaviClipper(ZSize: ZSize);

    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        CustomPaint(
          painter: _ClipShadowPainter(
            shadow: Shadow(
                color: Colors.white.withOpacity(.1),
                blurRadius: 30,
                offset: Offset(0, -3)),
            clipper: clipper,
          ),
          child: ClipPath(
            clipper: clipper,
            child: Container(
              height: 63,
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  color: widget.backgroundColor ?? Color(0xFF222427),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Builder(builder: (context) {
                List<Widget> leadingChildren = [];
                List<Widget> trailingChildren = [];

                widget.buttonData.asMap().forEach((i, data) {
                  Widget btn = ZButton(
                    icon: data.icon,
                    title: data.title,
                    isSelected: selectedId == i,
                    unselectedColor: widget.buttonColor,
                    selectedColor: widget.buttonSelectedColor,
                    onTap: () {
                      setState(() {
                        selectedId = i;
                      });
                      this.widget.onChange(i);
                    },
                  );

                  if (i < 2) {
                    leadingChildren.add(btn);
                  } else {
                    trailingChildren.add(btn);
                  }
                });

                return Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: leadingChildren,
                      ),
                    ),
                    Container(width: ZSize),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: trailingChildren,
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
        _centerButton,
      ],
    );
  }
}

class _BottomNaviClipper extends CustomClipper<Path> {
  final double ZSize;
  final double padding = 50;
  final double centerRadius = 25;
  final double cornerRadius = 5;

  _BottomNaviClipper({this.ZSize = 100});

  @override
  Path getClip(Size size) {
    final xCenter = (size.width / 2);

    final fabSizeWithPadding = ZSize + padding - 30;

    final path = Path();
    path.lineTo((xCenter - (fabSizeWithPadding / 2) - cornerRadius), 0);
    path.quadraticBezierTo(xCenter - (fabSizeWithPadding / 2), 0,
        (xCenter - (fabSizeWithPadding / 2)) + cornerRadius, cornerRadius);
    path.lineTo(
        xCenter - centerRadius, (fabSizeWithPadding / 2) - centerRadius);
    path.quadraticBezierTo(xCenter, (fabSizeWithPadding / 2),
        xCenter + centerRadius, (fabSizeWithPadding / 2) - centerRadius);
    path.lineTo(
        (xCenter + (fabSizeWithPadding / 2) - cornerRadius), cornerRadius);
    path.quadraticBezierTo(xCenter + (fabSizeWithPadding / 2), 0,
        (xCenter + (fabSizeWithPadding / 2) + cornerRadius), 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(oldClipper) => false;
}

class _ClipShadowPainter extends CustomPainter {
  final Shadow shadow;
  final CustomClipper<Path> clipper;

  _ClipShadowPainter({required this.shadow, required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint();
    var clipPath = clipper.getClip(size).shift(shadow.offset);
    canvas.drawPath(clipPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class ButtonData {
  final dynamic id;
  final IconData icon;
  final String title;

  ButtonData({
    this.id,
    this.icon = Icons.home,
    this.title = '',
  });
}
