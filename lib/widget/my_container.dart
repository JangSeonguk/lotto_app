import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  const MyContainer(
      {super.key,
      required this.width,
      required this.height,
      required this.bgcolor,
      required this.radius,
      this.imagePath,
      this.icon});

  final double width;
  final double height;
  final Color? bgcolor;
  final String? imagePath;
  final double radius;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(radius),
            color: bgcolor,
            image: imagePath != null
                ? DecorationImage(
                    image: AssetImage(imagePath!), fit: BoxFit.fill)
                : null),
        child: icon);
  }
}
