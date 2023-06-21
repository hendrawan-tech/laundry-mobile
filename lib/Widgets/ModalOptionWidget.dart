import 'package:flutter/material.dart';
import 'package:medic_petcare/Utils/Themes.dart';
import 'package:medic_petcare/Widgets/ButtonWidget.dart';
import 'package:medic_petcare/Widgets/TextWidget.dart';

class ModalOptionWidget extends StatefulWidget {
  final String title, subtitle, imageTop, titleButtonTop, titleButtonBottom;
  final CrossAxisAlignment axisText;
  final Alignment alignmentText;
  final double imageTopWidth, contraintHeight, imageTopHeight;
  final TextAlign textAlign;
  final double imageWidth, imageHeight;
  final Widget? customSubtitle;
  final bool isLoading, isLoadingBottom, isEnable;
  final Map<String, String>? translateParam;
  final void Function()? onPressButtonTop, onPressButtonBottom;
  const ModalOptionWidget({
    Key? key,
    this.title = '',
    this.subtitle = '',
    this.imageTop = '',
    this.imageTopWidth = 100,
    this.imageTopHeight = 100,
    this.axisText = CrossAxisAlignment.center,
    this.alignmentText = Alignment.centerLeft,
    this.textAlign = TextAlign.left,
    this.titleButtonTop = '',
    this.titleButtonBottom = '',
    this.onPressButtonTop,
    this.onPressButtonBottom,
    this.imageWidth = 100,
    this.contraintHeight = 325,
    this.imageHeight = 100,
    this.isLoadingBottom = false,
    this.isLoading = false,
    this.isEnable = true,
    this.customSubtitle,
    this.translateParam,
  }) : super(key: key);

  @override
  State<ModalOptionWidget> createState() => ModalOptionWidgetState();
}

class ModalOptionWidgetState extends State<ModalOptionWidget> {
  bool isLoading = false, isLoadingButtom = false;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultBorderRadius),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: widget.axisText,
        children: [
          Container(
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 24,
            ),
            alignment: widget.alignmentText,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: widget.axisText,
              children: [
                widget.imageTop != ''
                    ? Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(
                          vertical: 24,
                        ),
                        child: widget.imageTop.contains('http')
                            ? Image.network(
                                widget.imageTop,
                                height: widget.imageTopHeight,
                                width: widget.imageTopWidth,
                              )
                            : Image.asset(
                                widget.imageTop,
                                height: widget.imageTopHeight,
                                width: widget.imageTopWidth,
                              ),
                      )
                    : Container(),
                widget.title != ''
                    ? Container(
                        padding: EdgeInsets.only(
                          bottom: 8,
                          top: widget.imageTop != "" ? 0 : 8,
                        ),
                        child: TextWidget(
                          label: widget.title,
                          weight: 'bold',
                          type: 's2',
                          textAlign: widget.textAlign,
                        ),
                      )
                    : Container(),
                widget.customSubtitle ??
                    (widget.subtitle != ''
                        ? TextWidget(
                            label: widget.subtitle,
                            weight: 'regular',
                            type: 'b1',
                            textAlign: widget.textAlign,
                          )
                        : Container()),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      widget.titleButtonTop != ""
                          ? Container(
                              margin: const EdgeInsets.only(
                                top: 24,
                              ),
                              width: MediaQuery.of(context).size.width * 1 - 80,
                              height: 48,
                              child: ButtonWidget(
                                upperCase: true,
                                title: widget.titleButtonTop,
                                isLoading: isLoading,
                                theme: isLoading ? 'disable' : 'primary',
                                onPressed: () {
                                  if (widget.onPressButtonTop != null &&
                                      !isLoading) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    widget.onPressButtonTop!();
                                  }
                                },
                              ),
                            )
                          : Container(),
                      widget.titleButtonBottom != ""
                          ? Container(
                              width: MediaQuery.of(context).size.width * 1 - 80,
                              height: 45,
                              margin: const EdgeInsets.symmetric(
                                vertical: 12,
                              ),
                              child: ButtonWidget(
                                title: widget.titleButtonBottom,
                                isLoading: isLoadingButtom,
                                type: isLoadingButtom ? '' : 'outline',
                                theme: isLoadingButtom ? 'disable' : '',
                                onPressed: () {
                                  if (widget.onPressButtonBottom != null &&
                                      !isLoadingButtom) {
                                    setState(() {
                                      isLoadingButtom = true;
                                    });
                                    widget.onPressButtonBottom!();
                                  }
                                },
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
