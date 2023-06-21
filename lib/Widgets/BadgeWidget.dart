import 'package:flutter/material.dart';
import 'package:medic_petcare/Utils/Themes.dart';
import 'package:medic_petcare/Widgets/TextWidget.dart';

class BadgeWidget extends StatelessWidget {
  final String label, typeFont;
  final Color? bgColor;
  final EdgeInsets customPadding;
  final double customRadius;
  const BadgeWidget({
    Key? key,
    required this.label,
    this.bgColor,
    this.customPadding = const EdgeInsets.symmetric(
      vertical: 2,
      horizontal: 10,
    ),
    this.customRadius = 8,
    this.typeFont = 'b2',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: customPadding,
      decoration: BoxDecoration(
        color: bgColor.runtimeType == Null ? primaryColor : bgColor,
        borderRadius: BorderRadius.circular(
          customRadius,
        ),
      ),
      child: TextWidget(
        label: label,
        type: typeFont,
        color: whiteColor,
      ),
    );
  }
}
