import 'dart:io';
import 'package:flutter/material.dart';
import 'package:medic_petcare/Provider/UserProvider.dart';
import 'package:medic_petcare/Routes/Routes.dart';
import 'package:medic_petcare/Utils/Snackbar.dart';
import 'package:medic_petcare/Utils/Themes.dart';
import 'package:medic_petcare/Widgets/ButtonWidget.dart';
import 'package:medic_petcare/Widgets/HeaderWidget.dart';
import 'package:medic_petcare/Widgets/ImageWidget.dart';
import 'package:medic_petcare/Widgets/InputWidget.dart';
import 'package:medic_petcare/Widgets/ModalOptionWidget.dart';
import 'package:medic_petcare/Widgets/TextWidget.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String errName = "", errEmail = "", errPassword = "";
  bool isLoading = false;
  handleSubmit() async {
    FocusManager.instance.primaryFocus?.unfocus();
    bool valid = true;
    setState(() {
      errName = "";
      errEmail = "";
      errPassword = "";
      isLoading = true;
    });
    if (nameController.text.isEmpty) {
      errName = "Nama wajib diisi";
      valid = false;
    }
    if (emailController.text.isEmpty) {
      errEmail = "Email wajib diisi";
      valid = false;
    }
    if (passwordController.text.isEmpty) {
      errPassword = "Password wajib diisi";
      valid = false;
    }
    if (valid) {
      await Provider.of<UserProvider>(
        context,
        listen: false,
      ).register(
        body: {
          "name": nameController.text,
          "email": emailController.text,
          "password": passwordController.text,
        },
      ).then((value) {
        if (value['meta']['code'] == 200) {
          showSnackBar(
            context,
            "Daftar Akun Berhasil",
            type: 'success',
            position: 'TOP',
            duration: 1,
          );
          Navigator.pushReplacementNamed(
            context,
            Routes.loginScreen,
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

  onChangeName(String newText) {
    if (nameController.text.isNotEmpty && newText.isNotEmpty) {
      setState(() {
        errName = "";
      });
    } else {
      setState(() {
        errName = "Email wajib diisi";
      });
    }
  }

  onChangeEmail(String newText) {
    if (emailController.text.isNotEmpty && newText.isNotEmpty) {
      setState(() {
        errEmail = "";
      });
    } else {
      setState(() {
        errEmail = "Email wajib diisi";
      });
    }
  }

  onChangePassword(String newText) {
    if (passwordController.text.isNotEmpty && newText.isNotEmpty) {
      setState(() {
        errPassword = "";
      });
    } else {
      setState(() {
        errPassword = "Passowrd wajib diisi";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderWidget(
        title: "Daftar Akun",
      ),
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: 24,
          horizontal: defaultMargin,
        ),
        child: SafeArea(
          child: Column(
            children: [
              InputWidget(
                title: "Nama",
                hintText: "Masukkan Nama Lengkap",
                controller: nameController,
                errText: errName,
                onChanged: onChangeName,
              ),
              InputWidget(
                title: "Email",
                hintText: "Masukkan Alamat Email",
                controller: emailController,
                errText: errEmail,
                type: TextInputType.emailAddress,
                onChanged: onChangeEmail,
              ),
              InputWidget(
                title: "Password",
                hintText: "Masukkan Password",
                obscure: true,
                controller: passwordController,
                errText: errPassword,
                onChanged: onChangePassword,
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 24,
                ),
                width: double.infinity,
                child: ButtonWidget(
                  title: "Daftar",
                  isLoading: isLoading,
                  theme: isLoading ? 'disable' : 'primary',
                  onPressed: () async {
                    handleSubmit();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
