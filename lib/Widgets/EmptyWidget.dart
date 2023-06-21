import 'package:flutter/material.dart';
import 'package:medic_petcare/Utils/Images.dart';
import 'package:medic_petcare/Utils/Themes.dart';
import 'package:medic_petcare/Widgets/ImageWidget.dart';
import 'package:medic_petcare/Widgets/TextWidget.dart';

class EmptyWidget extends StatelessWidget {
  final String text;
  const EmptyWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ImageWidget(
            image: vetIcon,
            width: 200,
          ),
          const SizedBox(
            height: 8,
          ),
          TextWidget(
            label: text,
            color: fontPrimaryColor,
            weight: 'bold',
          ),
        ],
      ),
    );
  }
}
