import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medic_petcare/Provider/UserProvider.dart';
import 'package:medic_petcare/Routes/Routes.dart';
import 'package:medic_petcare/Utils/Snackbar.dart';
import 'package:medic_petcare/Utils/Themes.dart';
import 'package:medic_petcare/Widgets/ButtonWidget.dart';
import 'package:medic_petcare/Widgets/HeaderWidget.dart';
import 'package:medic_petcare/Widgets/InputWidget.dart';
import 'package:provider/provider.dart';

class SettingsAccountScreen extends StatefulWidget {
  const SettingsAccountScreen({super.key});

  @override
  State<SettingsAccountScreen> createState() => _SettingsAccountState();
}

class _SettingsAccountState extends State<SettingsAccountScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController photoController = TextEditingController();
  String errName = "";
  bool isLoading = false;
  File? image;
  onChangeName(String newText) {
    if (nameController.text.isNotEmpty && newText.isNotEmpty) {
      setState(() {
        errName = "";
      });
    } else {
      setState(() {
        errName = "Nama wajib diisi";
      });
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    var user = Provider.of<UserProvider>(context, listen: false).getUserData;
    setState(() {
      nameController.text = user['name'];
    });
  }

  Future getImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? imagePicked = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
      );
      setState(() {
        image = File(imagePicked!.path);
        photoController.text = image!.path.toString();
      });
    } catch (e) {}
  }

  handleSubmit() async {
    bool valid = true;
    setState(() {
      isLoading = true;
      errName = "";
    });
    if (nameController.text.isEmpty) {
      errName = "Nama harus diisi";
      valid = false;
    }

    if (valid) {
      setState(() {
        isLoading = false;
      });

      Map<String, dynamic> body = {};

      if (photoController.text.isNotEmpty) {
        body = {
          'name': nameController.text,
          'avatar': image!.path,
        };
      } else {
        body = {
          'name': nameController.text,
        };
      }

      print(body);

      Provider.of<UserProvider>(
        context,
        listen: false,
      )
          .updateuser(
        body: body,
        isImage: photoController.text.isNotEmpty ? true : false,
      )
          .then((value) {
        setState(() {
          isLoading = false;
        });
        if (value['meta']['code'] == 200) {
          showSnackBar(
            context,
            "Berhasil",
            subtitle: value['meta']['message'],
            position: 'TOP',
            type: 'success',
            duration: 2,
          );
          Provider.of<UserProvider>(
            context,
            listen: false,
          ).getUser().then(
                (value) => Navigator.pop(context),
              );
        } else {
          showSnackBar(
            context,
            "Error",
            subtitle: "gaga;",
            position: 'TOP',
            type: 'error',
            duration: 2,
          );
        }
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: const HeaderWidget(
        title: "Pengaturan Akun",
      ),
      resizeToAvoidBottomInset: false,
      body: Consumer<UserProvider>(
        builder: (context, value, child) {
          var user = value.getUserData;
          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: 24,
              horizontal: defaultMargin,
            ),
            child: Column(
              children: [
                InputWidget(
                  title: "Nama",
                  hintText: user['name'],
                  controller: nameController,
                  errText: errName,
                  onChanged: onChangeName,
                ),
                InputWidget(
                  title: "Email",
                  readonly: true,
                  hintText: user['email'],
                ),
                InputWidget(
                  title: "Avatar",
                  hintText: "",
                  maxLines: 3,
                  inputHeight: 150,
                  controller: photoController,
                  readonly: true,
                  readOnlyColorCustom: whiteColor,
                  iconRight: Icons.camera_alt_outlined,
                  onPress: () {
                    getImage();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: SizedBox(
                    height: 150,
                    width: 150,
                    child: image.runtimeType != Null
                        ? Container(
                            width: 150,
                            height: 150,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                12,
                              ),
                            ),
                            child: Image.file(
                              image!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(),
                  ),
                ),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 32,
                  ),
                  width: double.infinity,
                  child: ButtonWidget(
                    title: "Simpan",
                    isLoading: isLoading,
                    onPressed: () {
                      handleSubmit();
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
