import 'dart:io';
import 'package:flutter/material.dart';
import 'package:medic_petcare/Provider/UserProvider.dart';
import 'package:medic_petcare/Screen/Acccount/AccountScreen.dart';

import 'package:medic_petcare/Screen/Home/HomeScreen.dart';
import 'package:medic_petcare/Screen/Product/ProductLandingScreen.dart';

import 'package:medic_petcare/Utils/Themes.dart';
import 'package:medic_petcare/Widgets/ModalOptionWidget.dart';
import 'package:provider/provider.dart';

class BottomNavigationWidget extends StatefulWidget {
  int selectedIndex = 0;

  BottomNavigationWidget({
    Key? key,
    this.selectedIndex = 0,
  }) : super(key: key);

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  final List<Widget> _pages = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() {
    var user = Provider.of<UserProvider>(
      context,
      listen: false,
    ).getUserData;
    if (user['role'] == 'Admin') {
      _pages.add(const HomeScreen());
      _pages.add(const ProductLandingScreen());
      _pages.add(const AccountLandingScreen());
      setState(() {});
    } else {
      _pages.add(const HomeScreen());
      _pages.add(const AccountLandingScreen());
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      widget.selectedIndex = index;
    });
  }

  onPressBottomTop() async {
    exit(0);
  }

  onPressButtonBottom() async {
    Navigator.pop(context);
  }

  Future<bool> onWillPop() async {
    return (await showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return ModalOptionWidget(
              title: "Konfirmasi",
              subtitle: "Apakah anda yakin ingin keluar dari aplikasi?",
              titleButtonTop: 'Iya',
              titleButtonBottom: 'Tidak',
              onPressButtonTop: onPressBottomTop,
              onPressButtonBottom: onPressButtonBottom,
              imageTopHeight: 125,
              textAlign: TextAlign.left,
              axisText: CrossAxisAlignment.start,
              alignmentText: Alignment.centerLeft,
            );
          },
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(
      context,
      listen: false,
    ).getUserData;
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: _pages.elementAt(widget.selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: whiteColor,
          selectedFontSize: 12,
          selectedItemColor: fontPrimaryColor,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            height: 1.5,
          ),
          currentIndex: widget.selectedIndex, //New
          onTap: _onItemTapped,
          items: user['role'] == 'Admin'
              ? <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.dashboard_outlined,
                      color: fontSecondaryColor,
                    ),
                    activeIcon: Icon(
                      Icons.dashboard,
                      color: primaryColor,
                    ),
                    label: "Beranda",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.local_laundry_service_outlined,
                      color: fontSecondaryColor,
                    ),
                    activeIcon: Icon(
                      Icons.local_laundry_service,
                      color: primaryColor,
                    ),
                    label: "Laundry",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.account_circle_outlined,
                      color: fontSecondaryColor,
                    ),
                    activeIcon: Icon(
                      Icons.account_circle,
                      color: primaryColor,
                    ),
                    label: "Akun",
                  ),
                ]
              : <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.dashboard_outlined,
                      color: fontSecondaryColor,
                    ),
                    activeIcon: Icon(
                      Icons.dashboard,
                      color: primaryColor,
                    ),
                    label: "Beranda",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.account_circle_outlined,
                      color: fontSecondaryColor,
                    ),
                    activeIcon: Icon(
                      Icons.account_circle,
                      color: primaryColor,
                    ),
                    label: "Akun",
                  ),
                ],
        ),
      ),
    );
  }
}

Widget getIcon(icon) {
  return ConstrainedBox(
    constraints: const BoxConstraints(
      minHeight: 24,
    ),
    child: Image.asset(
      icon,
      width: 24,
      fit: BoxFit.cover,
    ),
  );
}
