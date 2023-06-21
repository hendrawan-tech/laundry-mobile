import 'package:flutter/material.dart';
import 'package:medic_petcare/Utils/Themes.dart';
import 'package:medic_petcare/Widgets/TextWidget.dart';

class ButtonWidget extends StatelessWidget {
  final String type;
  final String theme;
  final String title;
  final String textSize;
  final Function() onPressed;
  final double customWidth;
  final double customHeight;
  final double customRadius;
  final bool isLoading, isEnable;
  final Map<String, String>? translateParams;
  final bool upperCase;

  const ButtonWidget({
    Key? key,
    this.type = "primary",
    this.theme = "primary",
    required this.title,
    required this.onPressed,
    this.customWidth = double.infinity,
    this.customHeight = 50,
    this.customRadius = 12,
    this.isLoading = false,
    this.translateParams,
    this.textSize = 'b2',
    this.upperCase = false,
    this.isEnable = true,
  }) : super(key: key);

  get finalButtonText {
    if (theme == 'primary' && type == 'primary') {
      return TextWidget(
        label: isLoading ? '' : title,
        weight: 'bold',
        color: whiteColor,
        upperCase: upperCase,
        type: textSize,
        translateParams: translateParams,
        textAlign: TextAlign.center,
      );
    } else if (theme == 'white' && type == 'text') {
      return TextWidget(
        label: isLoading ? '' : title,
        weight: 'bold',
        color: whiteColor,
        upperCase: upperCase,
        type: textSize,
        translateParams: translateParams,
      );
    } else if (theme == 'warning' && type == 'text') {
      return TextWidget(
        label: isLoading ? '' : title,
        weight: 'bold',
        color: warningColor,
        upperCase: upperCase,
        type: textSize,
        translateParams: translateParams,
      );
    } else {
      return TextWidget(
        label: isLoading ? '' : title,
        weight: 'bold',
        upperCase: upperCase,
        color: theme == "danger" ? redColor : primaryColor,
        type: textSize,
        translateParams: translateParams,
      );
    }
  }

  RoundedRectangleBorder get defaultRadius {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(customRadius),
    );
  }

  ButtonStyle get finalStyleWrapper {
    if (theme == 'primary') {
      return ElevatedButton.styleFrom(
        splashFactory: isLoading ? NoSplash.splashFactory : null,
        primary: primaryColor,
        shape: defaultRadius,
      );
    } else if (theme == 'white') {
      return ElevatedButton.styleFrom(
        splashFactory: isLoading ? NoSplash.splashFactory : null,
        primary: whiteColor,
        shape: defaultRadius,
        onPrimary: primaryColor,
      );
    } else if (theme == 'secondary') {
      return ElevatedButton.styleFrom(
        splashFactory: isLoading ? NoSplash.splashFactory : null,
        primary: secondaryColor,
        shape: defaultRadius,
      );
    } else if (theme == 'disable') {
      return ElevatedButton.styleFrom(
        splashFactory: isLoading ? NoSplash.splashFactory : null,
        primary: disableColorButton,
        shape: defaultRadius,
      );
    } else if (theme == 'danger') {
      return ElevatedButton.styleFrom(
        splashFactory: isLoading ? NoSplash.splashFactory : null,
        primary: redColor,
        shape: defaultRadius,
      );
    } else {
      return ElevatedButton.styleFrom(
        splashFactory: isLoading ? NoSplash.splashFactory : null,
        primary: primaryColor,
        shape: defaultRadius,
      );
    }
  }

  get finalButtonWrapper {
    if (type == 'text') {
      return TextButton(
        onPressed: isLoading ? () {} : onPressed,
        child: isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(
                        primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  finalButtonText,
                ],
              )
            : finalButtonText,
      );
    } else if (type == 'outline') {
      return OutlinedButton(
        onPressed: isLoading ? () {} : onPressed,
        child: isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(
                        theme == "danger" ? redColor : primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  finalButtonText,
                ],
              )
            : finalButtonText,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            width: 1,
            color: theme == "danger" ? redColor : primaryColor,
          ),
          splashFactory: isLoading ? NoSplash.splashFactory : null,
          shape: defaultRadius,
        ),
      );
    } else {
      return ElevatedButton(
        onPressed: isLoading ? () {} : onPressed,
        child: isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(
                        whiteColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  finalButtonText,
                ],
              )
            : finalButtonText,
        style: finalStyleWrapper,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: customHeight,
      child: finalButtonWrapper,
    );
  }
}
