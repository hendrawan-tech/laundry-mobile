import 'package:flutter/material.dart';
import 'package:medic_petcare/Utils/Themes.dart';
import 'package:shimmer/shimmer.dart';

class ShimmeerWidget extends StatelessWidget {
  final double width, height, radius;
  final Color bgColor;
  const ShimmeerWidget({
    Key? key,
    this.height = 64,
    this.width = 64,
    this.radius = 6,
    this.bgColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFEDF3F6),
      highlightColor: backgroundColor,
      enabled: true,
      loop: 100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(
            radius,
          ),
        ),
      ),
    );
  }
}
