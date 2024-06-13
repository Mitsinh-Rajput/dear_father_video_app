import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    Key? key,
    this.verticalPadding = 20.0,
    this.horizontalPadding = 0,
    this.thickness = .5,
    this.color,
  }) : super(key: key);

  final double verticalPadding;
  final double horizontalPadding;
  final double thickness;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: Container(
        height: thickness,
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
            Colors.white,
            color ?? Theme.of(context).primaryColor,
            Colors.white,
            //darkPink
          ]),
        ),
      ),
    );
  }
}
