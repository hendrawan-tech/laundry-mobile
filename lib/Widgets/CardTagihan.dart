import 'package:flutter/material.dart';
import 'package:medic_petcare/Utils/Themes.dart';
import 'package:medic_petcare/Widgets/TextWidget.dart';

class CardTagihan extends StatelessWidget {
  final Map<String, dynamic> data;
  final Function onPress;
  final bool;
  const CardTagihan({
    super.key,
    required this.data,
    this.bool,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPress();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 5,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 16,
        ),
        height: 93,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            8,
          ),
          border: Border.all(
            color: borderColor,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                TextWidget(
                  label: "Rawat inap",
                  type: "b2",
                  color: primaryColor,
                ),
                Spacer(),
                TextWidget(
                  label: data["sampai"],
                  type: "l1",
                ),
              ],
            ),
            Row(
              children: [
                TextWidget(
                  label: data["name"],
                  type: "s3",
                  weight: "bold",
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 30,
                  ),
                  child: TextWidget(
                    label: "s/d",
                    type: "l1",
                  ),
                ),
              ],
            ),
            Row(
              children: [
                TextWidget(
                  label: data["kode"],
                  type: "b2",
                ),
                Spacer(),
                TextWidget(
                  label: data["dengan"],
                  type: "l1",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
