import 'package:flutter/material.dart';
import 'package:medic_petcare/Utils/Themes.dart';

class TextWidget extends StatelessWidget {
  final String type, label, weight;
  final Color? color, shadowColor;
  final TextAlign textAlign;
  final Map<String, String>? translateParams;
  final bool upperCase, useEllipsis;
  final double lineHeight, ellipsisParentWidth;
  final TextOverflow textOverflow;
  final int maxLines;
  final TextDecoration textDecoration;
  const TextWidget({
    Key? key,
    this.type = 'b1',
    this.label = '',
    this.weight = 'regular',
    this.color,
    this.shadowColor,
    this.textAlign = TextAlign.left,
    this.translateParams,
    this.upperCase = false,
    this.lineHeight = 1.2,
    this.textOverflow = TextOverflow.visible,
    this.useEllipsis = false,
    this.ellipsisParentWidth = 100,
    this.maxLines = 10,
    this.textDecoration = TextDecoration.none,
  }) : super(key: key);

  int generateType() {
    switch (type) {
      case 'h1':
        return 36;
      case 'h2':
        return 32;
      case 'h3':
        return 28;
      case 's1':
        return 24;
      case 's2':
        return 20;
      case 's3':
        return 18;
      case 'b1':
        return 16;
      case 'b2':
        return 14;
      case 'l1':
        return 12;
      case 'l2':
        return 10;
      case 'l3':
        return 8;
      default:
        return 16;
    }
  }

  String generateFont() {
    switch (weight) {
      case 'bold':
        return 'NutinoSansBold';
      case 'medium':
        return 'NutinoSansMedium';
      case 'regular':
        return 'NutinoSansRegular';
      default:
        return 'NutinoSansRegular';
    }
  }

  Color generateFontColor() {
    switch (weight) {
      case 'bold':
        return fontPrimaryColor;
      case 'medium':
        return fontPrimaryColor;
      case 'regular':
        return fontSecondaryColor;
      case 'light':
        return fontSecondaryColor;
      default:
        return fontPrimaryColor;
    }
  }

  FontWeight generateFontWeight() {
    switch (weight) {
      case 'bold':
        return FontWeight.bold;
      case 'regular':
        return FontWeight.w400;
      case 'medium':
        return FontWeight.w600;
      case 'light':
        return FontWeight.w200;
      default:
        return FontWeight.w400;
    }
  }

  @override
  Widget build(BuildContext context) {
    return !useEllipsis
        ? Text(
            !upperCase ? label : label.toUpperCase(),
            textAlign: textAlign,
            overflow: textOverflow,
            maxLines: maxLines,
            textScaleFactor: 1.1,
            style: TextStyle(
              fontSize: generateType().toDouble(),
              color: color ?? generateFontColor(),
              fontWeight: generateFontWeight(),
              fontFamily: generateFont(),
              height: lineHeight,
              decoration: textDecoration,
            ),
          )
        : SizedBox(
            width: ellipsisParentWidth,
            child: Text(
              (!upperCase ? label : label.toUpperCase())
                  .replaceAll('', '\u200B')
                  .replaceAll(' ', '\u00A0'),
              textAlign: textAlign,
              overflow: TextOverflow.ellipsis,
              maxLines: maxLines,
              softWrap: false,
              style: TextStyle(
                fontSize: generateType().toDouble(),
                color: color ?? generateFontColor(),
                fontWeight: generateFontWeight(),
                fontFamily: generateFont(),
                height: lineHeight,
              ),
            ),
          );
  }
}
