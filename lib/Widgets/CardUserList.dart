import 'package:flutter/material.dart';
import 'package:medic_petcare/Widgets/ImageWidget.dart';
import 'package:medic_petcare/Widgets/TextWidget.dart';

import '../Utils/Themes.dart';

class CardUserList extends StatelessWidget {
  final Map<String, dynamic> input;
  final bool;
  const CardUserList({
    super.key,
    required this.input,
    this.bool,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: borderColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ImageWidget(
            image: input["image"],
            width: 86,
          ),
          SizedBox(
            width: 14,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                ),
                child: TextWidget(
                  label: input["name"],
                  color: primaryColor,
                ),
              ),
              TextWidget(
                label: input["email"],
                type: "b2",
              ),
              TextWidget(
                label: input["nomor"],
                type: "b2",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
