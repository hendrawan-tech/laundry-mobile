import 'package:flutter/material.dart';
import 'package:medic_petcare/Provider/UserProvider.dart';
import 'package:medic_petcare/Routes/Routes.dart';
import 'package:medic_petcare/Utils/Storage.dart';
import 'package:medic_petcare/Utils/StorageKey.dart';
import 'package:medic_petcare/Utils/Themes.dart';
import 'package:medic_petcare/Widgets/ImageWidget.dart';
import 'package:medic_petcare/Widgets/TextWidget.dart';
import 'package:provider/provider.dart';

import '../../Utils/Images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  getToken() async {
    var tokenAuth = await Storage.get(tokenStorageKey);
    if (tokenAuth != null) {
      await getUserData();
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(
        context,
        Routes.loginScreen,
      );
    }
  }

  getUserData() async {
    await Provider.of<UserProvider>(
      context,
      listen: false,
    ).getUser().then((value) {
      if (value['meta']['code'] == 200) {
        Navigator.pushReplacementNamed(
          context,
          Routes.homeScreen,
        );
      } else {
        Navigator.pushReplacementNamed(
          context,
          Routes.loginScreen,
        );
      }
    });
  }

  @override
  void initState() {
    getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: whiteColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageWidget(
              image: logo,
              width: 140,
              height: 140,
            ),
            const SizedBox(
              height: 34,
            ),
            ImageWidget(
              image: logoBlack,
              height: 40,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
