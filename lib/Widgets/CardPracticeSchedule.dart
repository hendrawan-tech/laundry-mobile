import "package:flutter/material.dart";
import 'package:medic_petcare/Utils/Themes.dart';

import 'package:medic_petcare/Widgets/TextWidget.dart';

class CardPracticeScheduleWidget extends StatelessWidget {
  final Map data;
  final Color color;

  const CardPracticeScheduleWidget({
    super.key,
    required this.data,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: defaultMargin,
        vertical: 12,
      ),
      margin: EdgeInsets.only(
        top: defaultMargin,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(.2),
        borderRadius: BorderRadius.circular(
          12,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                label: "${data['start_time']} - ${data['end_time']} WIB",
                color: fontSecondaryColor,
                type: 'l1',
              ),
              const SizedBox(
                height: 8,
              ),
              TextWidget(
                label: data['day'],
                color: fontPrimaryColor,
                weight: 'bold',
              ),
            ],
          ),
          Icon(
            Icons.calendar_today_rounded,
            color: color,
          ),
        ],
      ),
    );
  }
}
