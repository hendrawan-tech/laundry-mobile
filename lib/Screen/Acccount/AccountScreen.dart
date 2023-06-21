import 'package:flutter/material.dart';
import 'package:medic_petcare/Provider/UserProvider.dart';
import 'package:medic_petcare/Routes/Routes.dart';
import 'package:medic_petcare/Utils/Storage.dart';
import 'package:medic_petcare/Utils/StorageKey.dart';
import 'package:medic_petcare/Utils/Themes.dart';
import 'package:medic_petcare/Utils/Utils.dart';
import 'package:medic_petcare/Widgets/ImageWidget.dart';
import 'package:medic_petcare/Widgets/ModalOptionWidget.dart';
import 'package:medic_petcare/Widgets/TextWidget.dart';
import 'package:provider/provider.dart';

class AccountLandingScreen extends StatefulWidget {
  const AccountLandingScreen({super.key});

  @override
  State<AccountLandingScreen> createState() => _AccountLandingScreenState();
}

class _AccountLandingScreenState extends State<AccountLandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          const HeaderProfile(),
          Container(
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(
                  25,
                ),
              ),
            ),
            transform: Matrix4.translationValues(0.0, -50.0, 0.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16,
                  ),
                  child: MenuItem(
                    label: "Edit Akun",
                    icon: const Icon(
                      Icons.account_circle_outlined,
                    ),
                    onPress: () {
                      Navigator.pushNamed(
                        context,
                        Routes.settingsAccountScreen,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          TextWidget(
            label: "Version 1.0.0",
            color: fontGreyColor3,
            type: 'l1',
          ),
          const SizedBox(
            height: 8,
          ),
          TextWidget(
            label: "Copyright 2023 E-Laundry",
            color: fontGreyColor3,
            type: 'l1',
          ),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String label;
  final Icon icon;
  final Function onPress;
  const MenuItem({
    Key? key,
    required this.label,
    required this.icon,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPress();
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: whiteColor,
          border: Border(
            bottom: BorderSide(
              color: borderColor,
              width: 1,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 20,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                icon,
                SizedBox(
                  width: defaultMargin,
                ),
                TextWidget(
                  label: label,
                  type: "medium",
                  color: fontPrimaryColor,
                ),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderProfile extends StatefulWidget {
  const HeaderProfile({Key? key}) : super(key: key);

  @override
  State<HeaderProfile> createState() => _HeaderProfileState();
}

class _HeaderProfileState extends State<HeaderProfile> {
  modalConfirmLogout() async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ModalOptionWidget(
          title: "Konfirmasi",
          subtitle: "Apakah anda yakin ingin keluar dari akun ini?",
          titleButtonTop: 'Iya',
          titleButtonBottom: 'Tidak',
          onPressButtonTop: onLogoutAction,
          onPressButtonBottom: () {
            Navigator.pop(context);
          },
          imageTopHeight: 125,
          textAlign: TextAlign.left,
          axisText: CrossAxisAlignment.start,
          alignmentText: Alignment.centerLeft,
        );
      },
    );
  }

  onSuccessLogout() {
    Navigator.pop(context);
    Navigator.pushReplacementNamed(
      context,
      Routes.loginScreen,
    );
  }

  onLogoutAction() async {
    await Storage.get(tokenStorageKey);
    onSuccessLogout();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, value, child) {
        var user = value.getUserData;
        return Container(
          width: double.infinity,
          height: 240,
          padding: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          transform: Matrix4.translationValues(0.0, -20.0, 0.0),
          decoration: BoxDecoration(
            color: primaryColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    width: 60,
                    height: 60,
                    margin: EdgeInsets.only(
                      right: defaultMargin,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: whiteColor,
                        width: 2,
                      ),
                    ),
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ImageWidget(
                        image: getPhotoUrl(
                          user['avatar'] ?? "",
                        ),
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        label: user['name'],
                        type: 's3',
                        weight: 'bold',
                        color: whiteColor,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      TextWidget(
                        label: user['email'],
                        type: 'b2',
                        color: whiteColor,
                      ),
                    ],
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  modalConfirmLogout();
                },
                child: Container(
                  padding: const EdgeInsets.all(
                    8,
                  ),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.power_settings_new_rounded,
                    color: redColor,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
