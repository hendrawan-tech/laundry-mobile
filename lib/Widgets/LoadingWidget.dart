import 'package:flutter/material.dart';
import 'package:medic_petcare/Utils/Themes.dart';
import 'package:medic_petcare/Widgets/ShimmerWidget.dart';

class CircleLoadingWidget extends StatelessWidget {
  final double customWidth, customHeight;
  const CircleLoadingWidget({
    Key? key,
    this.customWidth = 100,
    this.customHeight = 100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: customHeight,
        width: customWidth,
        margin: const EdgeInsets.only(
          right: 12,
          top: 12,
        ),
        child: CircularProgressIndicator(
          backgroundColor: primaryColor,
          color: whiteColor,
          strokeWidth: 2,
        ),
      ),
    );
  }
}

class LoadingCardPatient extends StatelessWidget {
  const LoadingCardPatient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          12,
        ),
        border: Border.all(
          color: borderColor,
        ),
        color: whiteColor,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: defaultMargin,
        vertical: 12,
      ),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(
              right: 12,
            ),
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: const ShimmeerWidget(
              width: 66,
              height: 66,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              ShimmeerWidget(
                width: 200,
                height: 16,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 8,
                  bottom: 4,
                ),
                child: ShimmeerWidget(
                  width: 160,
                  height: 12,
                ),
              ),
              ShimmeerWidget(
                width: 120,
                height: 12,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class LoadingPracticeSchedule extends StatelessWidget {
  const LoadingPracticeSchedule({Key? key}) : super(key: key);

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
        color: whiteColor,
        borderRadius: BorderRadius.circular(
          12,
        ),
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              ShimmeerWidget(
                width: 150,
                height: 16,
              ),
              SizedBox(
                height: 8,
              ),
              ShimmeerWidget(
                width: 100,
                height: 20,
              ),
            ],
          ),
          const Icon(
            Icons.calendar_today_rounded,
            color: Color(0xFFEDF3F6),
          ),
        ],
      ),
    );
  }
}
