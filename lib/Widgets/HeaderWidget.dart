import 'package:flutter/material.dart';
import 'package:medic_petcare/Utils/Themes.dart';
import 'package:medic_petcare/Widgets/TextWidget.dart';

class HeaderWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? title, param, translate;
  final String fontWeight;
  final List<IconButton>? rightIcons;
  final List<Widget>? rightWidget;
  final bool? centerTitle;
  final double? elevation;
  final Color? colorTitle, customLeadingIconColor, bgColor, frontColor;
  final Widget? widgetTitle;
  final Function? customBackAction;
  final Function? customLeftAction;
  final bool useBackButton;

  @override
  Size get preferredSize => const Size.fromHeight(60);

  const HeaderWidget({
    Key? key,
    this.title = "",
    this.bgColor,
    this.frontColor,
    this.rightIcons,
    this.centerTitle = true,
    this.elevation = .5,
    this.colorTitle,
    this.fontWeight = "bold",
    this.widgetTitle,
    this.rightWidget,
    this.customBackAction,
    this.customLeftAction,
    this.customLeadingIconColor,
    this.translate = "",
    this.param = "",
    this.useBackButton = true,
  }) : super(key: key);

  onBackIconTapped(context) {
    customBackAction != null
        ? customBackAction!()
        : Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(56),
      child: AppBar(
        title: widgetTitle ??
            TextWidget(
              label: title!,
              type: 's3',
              weight: fontWeight,
              color: colorTitle ?? blackColor,
              lineHeight: 1,
              translateParams: {
                param!: translate!,
              },
            ),
        centerTitle: centerTitle,
        elevation: elevation,
        actions: rightWidget != null
            ? rightWidget
                ?.map(
                  (icon) => icon,
                )
                .toList()
            : rightIcons
                ?.map(
                  (icon) => icon,
                )
                .toList(),
        backgroundColor: bgColor.runtimeType == Null ? whiteColor : bgColor,
        foregroundColor:
            frontColor.runtimeType == Null ? fontPrimaryColor : frontColor,
        leading: useBackButton
            ? IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: customLeadingIconColor ?? primaryColor,
                ),
                onPressed: () {
                  if (customLeftAction != null) {
                    customLeftAction!();
                  } else if (onBackIconTapped != null) {
                    onBackIconTapped(context);
                  } else {
                    Navigator.pop(context);
                  }
                },
              )
            : Container(),
      ),
    );
  }
}
