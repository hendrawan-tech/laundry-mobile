import 'package:flutter/material.dart';
import 'package:medic_petcare/Utils/Themes.dart';
import 'package:medic_petcare/Widgets/TextWidget.dart';

class CardListReportScreen extends StatelessWidget {
  final Map<String, dynamic> data;
  const CardListReportScreen({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
      ),
      height: 83,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 5,
          ),
          TextWidget(
            label: data["rawat"],
            type: "b2",
            color: primaryColor,
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              TextWidget(
                label: data["operasi"],
                weight: "medium",
                color: fontPrimaryColor,
              ),
              TextWidget(
                label: data["hewan"],
                weight: "medium",
                color: fontPrimaryColor,
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              TextWidget(
                label: data["sampai"],
                type: "b2",
              ),
              SizedBox(
                width: 10,
              ),
              TextWidget(
                label: "s/d",
                type: "b2",
              ),
              SizedBox(
                width: 10,
              ),
              TextWidget(
                label: data["dengan"],
                type: "b2",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
