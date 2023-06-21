import 'package:flutter/material.dart';
import 'package:medic_petcare/Provider/ProductProvider.dart';
import 'package:medic_petcare/Provider/UserProvider.dart';
import 'package:medic_petcare/Routes/Routes.dart';
import 'package:medic_petcare/Screen/Product/DetailProductScreen.dart';
import 'package:medic_petcare/Utils/Images.dart';
import 'package:medic_petcare/Utils/Utils.dart';
import 'package:medic_petcare/Widgets/ProductCardWidget.dart';
import 'package:medic_petcare/Widgets/BadgeWidget.dart';
import 'package:medic_petcare/Widgets/ImageWidget.dart';
import 'package:medic_petcare/Utils/Themes.dart';
import 'package:medic_petcare/Widgets/LoadingWidget.dart';
import 'package:medic_petcare/Widgets/TextWidget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    var user = Provider.of<UserProvider>(
      context,
      listen: false,
    ).getUserData;
    Provider.of<ProductProvider>(
      context,
      listen: false,
    ).orders(user['role'] == 'Admin' ? '' : user['id'].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProfileSection(),
                Consumer<ProductProvider>(
                  builder: (context, value, child) {
                    return value.isLoading
                        ? const CircleLoadingWidget()
                        : value.getOrders.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 24,
                                      left: defaultMargin,
                                      right: defaultMargin,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextWidget(
                                          label: "Daftar Transaksi",
                                          type: 's3',
                                          weight: 'bold',
                                          color: fontPrimaryColor,
                                        ),
                                        // GestureDetector(
                                        //   onTap: () {
                                        //     Navigator.pushNamed(
                                        //       context,
                                        //       Routes.homeScreen,
                                        //       arguments: 1,
                                        //     );
                                        //   },
                                        //   child: TextWidget(
                                        //     label: "Lihat Semua",
                                        //     weight: 'bold',
                                        //     type: 'b2',
                                        //     color: secondaryColor,
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      bottom: 24,
                                    ),
                                    child: ListView.builder(
                                      itemCount: value.getOrders.length,
                                      shrinkWrap: true,
                                      padding: EdgeInsets.only(
                                        top: 8,
                                        left: defaultMargin,
                                        right: defaultMargin,
                                        bottom: 24,
                                      ),
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailProductScreen(
                                                  data: value.getOrders[index],
                                                ),
                                              ),
                                            );
                                          },
                                          child: ProductCardWidget(
                                            data: value.getOrders[index],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : Container();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileSection extends StatelessWidget {
  const ProfileSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, value, child) {
        var user = value.getUserData;
        return Container(
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(
                30,
              ),
              bottomRight: Radius.circular(
                30,
              ),
            ),
          ),
          height: 150,
          padding: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          label: "Selamat Datang,",
                          type: 'b2',
                          color: whiteColor,
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        TextWidget(
                          label: capitalizeFirstLetter(
                            user['name'],
                          ),
                          type: 's2',
                          weight: 'bold',
                          color: whiteColor,
                        ),
                      ],
                    ),
                    Container(
                      clipBehavior: Clip.hardEdge,
                      width: 50,
                      height: 50,
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
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
