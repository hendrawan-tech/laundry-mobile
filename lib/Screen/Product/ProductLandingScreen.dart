import 'package:flutter/material.dart';
import 'package:medic_petcare/Provider/ProductProvider.dart';
import 'package:medic_petcare/Provider/UserProvider.dart';
import 'package:medic_petcare/Routes/Routes.dart';
import 'package:medic_petcare/Utils/Snackbar.dart';
import 'package:medic_petcare/Utils/Themes.dart';
import 'package:medic_petcare/Utils/Utils.dart';
import 'package:medic_petcare/Widgets/ButtonWidget.dart';
import 'package:medic_petcare/Widgets/InputWidget.dart';
import 'package:medic_petcare/Widgets/TextWidget.dart';
import 'package:provider/provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:medic_petcare/Widgets/ImageWidget.dart';

import '../../Utils/Images.dart';

class ProductLandingScreen extends StatefulWidget {
  const ProductLandingScreen({Key? key}) : super(key: key);

  @override
  State<ProductLandingScreen> createState() => _ProductLandingScreenState();
}

class _ProductLandingScreenState extends State<ProductLandingScreen> {
  final databaseRef = FirebaseDatabase.instance.reference();
  TextEditingController priceController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController returnController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  String fixPrice = "",
      fixWeight = "",
      errPrice = "",
      errWeight = "",
      errCategory = "",
      errUser = "",
      errTotal = "";
  Map selectedCategory = {}, selectedUser = {};

  bool isLoading = false;
  var fireData;

  @override
  void initState() {
    getData();
    getDataFromDatabase();
    super.initState();
  }

  void getDataFromDatabase() {
    databaseRef.child('test').onValue.listen((event) {
      if (event.snapshot.exists) {
        var data = event.snapshot.value;
        if (mounted) {
          setState(() {
            fireData = data;
            priceController.text = formatPrice(
              amount: fireData['int'].toString(),
            );
            weightController.text = '${fireData['float']} Kilogram';
          });
        }
      }
    });
  }

  getData() async {
    Provider.of<ProductProvider>(
      context,
      listen: false,
    ).categories();
    Provider.of<UserProvider>(
      context,
      listen: false,
    ).users();
  }

  onSubmit() async {
    FocusManager.instance.primaryFocus?.unfocus();
    bool valid = true;
    setState(() {
      errPrice = "";
      errWeight = "";
      errCategory = "";
      errUser = "";
      errTotal = "";
      isLoading = true;
    });

    if (priceController.text.isEmpty) {
      errPrice = "Harga Barang wajib diisi";
      valid = false;
    }
    if (weightController.text.isEmpty) {
      errWeight = "Berat wajib diisi";
      valid = false;
    }
    if (categoryController.text.isEmpty) {
      errCategory = "Kategori wajib diisi";
      valid = false;
    }
    if (userController.text.isEmpty) {
      errUser = "User wajib diisi";
      valid = false;
    }
    if (totalController.text.isEmpty) {
      errTotal = "Jumlah wajib diisi";
      valid = false;
    }
    if (valid) {
      var body = {
        "price": fixPrice,
        "weight": fixWeight,
        "category_id": selectedCategory['id'],
        "user_id": selectedUser['id'],
      };
      await Provider.of<ProductProvider>(
        context,
        listen: false,
      )
          .addOrder(
        body: body,
      )
          .then((value) {
        if (value['meta']['code'] == 200) {
          setState(() {
            showSnackBar(
              context,
              value["meta"]['message'],
              type: 'success',
              position: 'TOP',
              duration: 1,
            );
          });
          Navigator.pushNamed(
            context,
            Routes.homeScreen,
            arguments: '0',
          );
        } else {
          setState(() {
            showSnackBar(
              context,
              value["meta"]['message'],
              type: 'error',
              position: 'TOP',
              duration: 1,
            );
          });
        }
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  onChangeTotal(String newText) {
    setState(() {
      returnController.text = formatPrice(
          amount: "${int.parse(totalController.text) - int.parse(fixPrice)}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Consumer<ProductProvider>(
        builder: (context, value, child) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
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
                    child: Center(
                      child: TextWidget(
                        label: "Kasir",
                        type: 's1',
                        weight: 'bold',
                        color: whiteColor,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 24,
                    horizontal: defaultMargin,
                  ),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    border: Border.all(
                      color: borderColor,
                    ),
                    borderRadius: BorderRadius.circular(
                      12,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 24,
                    horizontal: defaultMargin,
                  ),
                  child: Column(
                    children: [
                      ImageWidget(
                        image: logoBlack,
                        height: 30,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      InputWidget(
                        title: "Harga Barang",
                        hintText: "",
                        readonly: true,
                        controller: priceController,
                        errText: errPrice,
                      ),
                      InputWidget(
                        title: "Berat Barang",
                        hintText: "",
                        errText: errWeight,
                        readonly: true,
                        controller: weightController,
                      ),
                      InputWidget(
                        title: "Pilih Kategori",
                        hintText: "",
                        controller: categoryController,
                        readonly: true,
                        readOnlyColorCustom: whiteColor,
                        iconRight: Icons.keyboard_arrow_down_rounded,
                        errText: errCategory,
                        onPress: () {
                          _showModalSelect();
                        },
                      ),
                      InputWidget(
                        title: "Pilih User",
                        hintText: "",
                        controller: userController,
                        readonly: true,
                        readOnlyColorCustom: whiteColor,
                        iconRight: Icons.keyboard_arrow_down_rounded,
                        errText: errUser,
                        onPress: () {
                          _showModalSelectUser();
                        },
                      ),
                      InputWidget(
                        title: "Jumlah Uang",
                        hintText: "",
                        specialRules: 'onlyNumber',
                        type: TextInputType.number,
                        controller: totalController,
                        onChanged: onChangeTotal,
                        errText: errTotal,
                      ),
                      InputWidget(
                        title: "Kembalian",
                        hintText: "",
                        readonly: true,
                        controller: returnController,
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(
                          top: defaultMargin + 8,
                        ),
                        child: ButtonWidget(
                          isLoading: isLoading,
                          title: "Tambah Laundry",
                          onPressed: () {
                            onSubmit();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  _showModalSelect() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      backgroundColor: Colors.transparent,
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return BottomSheet(
          onClosing: () {},
          enableDrag: false,
          backgroundColor: Colors.transparent,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (BuildContext context, setState) =>
                  DraggableScrollableSheet(
                initialChildSize: .9,
                builder: (_, controller) => Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 14,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(25),
                    ),
                    color: whiteColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Container(
                          width: 54,
                          height: 5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              100,
                            ),
                            color: borderColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                        child: TextWidget(
                          label: "Pilih Kategori",
                          type: 'b1',
                          weight: 'bold',
                          color: fontPrimaryColor,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Consumer<ProductProvider>(
                        builder: (context, value, child) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: value.getCategories.length,
                            itemBuilder: (context, index) {
                              var data = value.getCategories[index];
                              return GestureDetector(
                                onTap: () {
                                  selectedCategory = data;
                                  categoryController.text = data['name'];
                                  if (data['name'] == 'Kaos') {
                                    priceController.text = formatPrice(
                                      amount: "${fireData['int']}",
                                    );
                                    fixPrice = "${fireData['int']}";
                                    fixWeight = '${fireData['float']}';
                                  } else {
                                    priceController.text = formatPrice(
                                        amount:
                                            "${fireData['float'] * int.parse(data['price'])}");
                                    fixPrice =
                                        "${fireData['float'] * int.parse(data['price'])}";
                                    fixWeight = '${fireData['float']}';
                                  }
                                  setState(() {});
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(
                                    bottom: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color:
                                          selectedCategory.runtimeType == Null
                                              ? borderColor
                                              : selectedCategory == data
                                                  ? primaryColor
                                                  : borderColor,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      12,
                                    ),
                                  ),
                                  padding: EdgeInsets.all(
                                    defaultMargin,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextWidget(
                                            label: data['name'],
                                            color: fontPrimaryColor,
                                            weight: 'bold',
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          TextWidget(
                                            label: formatPrice(
                                              amount: data['price'],
                                            ),
                                            color: fontSecondaryColor,
                                            type: 'l1',
                                            weight: 'medium',
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: 16,
                                        height: 16,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: primaryColor,
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                        padding: const EdgeInsets.all(
                                          2,
                                        ),
                                        child: Container(
                                          width: 15,
                                          height: 15,
                                          decoration: BoxDecoration(
                                            color:
                                                selectedCategory.runtimeType ==
                                                        Null
                                                    ? whiteColor
                                                    : selectedCategory == data
                                                        ? primaryColor
                                                        : whiteColor,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  _showModalSelectUser() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      backgroundColor: Colors.transparent,
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return BottomSheet(
          onClosing: () {},
          enableDrag: false,
          backgroundColor: Colors.transparent,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (BuildContext context, setState) =>
                  DraggableScrollableSheet(
                initialChildSize: .9,
                builder: (_, controller) => Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 14,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(25),
                    ),
                    color: whiteColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Container(
                          width: 54,
                          height: 5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              100,
                            ),
                            color: borderColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                        child: TextWidget(
                          label: "Pilih User",
                          type: 'b1',
                          weight: 'bold',
                          color: fontPrimaryColor,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Consumer<UserProvider>(
                        builder: (context, value, child) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: value.getListUser.length,
                            itemBuilder: (context, index) {
                              var data = value.getListUser[index];
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedUser = data;
                                    userController.text = data['name'];
                                  });
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(
                                    bottom: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: selectedUser.runtimeType == Null
                                          ? borderColor
                                          : selectedUser == data
                                              ? primaryColor
                                              : borderColor,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      12,
                                    ),
                                  ),
                                  padding: EdgeInsets.all(
                                    defaultMargin,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextWidget(
                                        label: data['name'],
                                        color: fontPrimaryColor,
                                        weight: 'bold',
                                      ),
                                      Container(
                                        width: 16,
                                        height: 16,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: primaryColor,
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                        padding: const EdgeInsets.all(
                                          2,
                                        ),
                                        child: Container(
                                          width: 15,
                                          height: 15,
                                          decoration: BoxDecoration(
                                            color:
                                                selectedUser.runtimeType == Null
                                                    ? whiteColor
                                                    : selectedUser == data
                                                        ? primaryColor
                                                        : whiteColor,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
