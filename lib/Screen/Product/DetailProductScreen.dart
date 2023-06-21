import 'package:flutter/material.dart';
import 'package:medic_petcare/Utils/Images.dart';
import 'package:medic_petcare/Utils/Themes.dart';
import 'package:medic_petcare/Utils/Utils.dart';
import 'package:medic_petcare/Widgets/HeaderWidget.dart';
import 'package:medic_petcare/Widgets/ImageWidget.dart';
import 'package:medic_petcare/Widgets/TextWidget.dart';

class DetailProductScreen extends StatefulWidget {
  final Map data;
  const DetailProductScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  @override
  Widget build(BuildContext context) {
    Widget status(String status) {
      switch (status) {
        case 'Antrian':
          return Container(
            padding: EdgeInsets.symmetric(
              vertical: 4,
              horizontal: defaultMargin,
            ),
            decoration: BoxDecoration(
              color: disableColor,
              borderRadius: BorderRadius.circular(
                12,
              ),
            ),
            child: TextWidget(
              label: status,
              type: 'l1',
            ),
          );
        case 'Di Proses':
          return Container(
            padding: EdgeInsets.symmetric(
              vertical: 4,
              horizontal: defaultMargin,
            ),
            decoration: BoxDecoration(
              color: orangeColor,
              borderRadius: BorderRadius.circular(
                12,
              ),
            ),
            child: TextWidget(
              label: status,
              type: 'l1',
              color: whiteColor,
            ),
          );
        case 'Selesai':
          return Container(
            padding: EdgeInsets.symmetric(
              vertical: 4,
              horizontal: defaultMargin,
            ),
            decoration: BoxDecoration(
              color: Colors.greenAccent.shade700,
              borderRadius: BorderRadius.circular(
                12,
              ),
            ),
            child: TextWidget(
              label: status,
              type: 'l1',
              color: whiteColor,
            ),
          );
        default:
          return Container();
      }
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: const HeaderWidget(
        title: 'Detail Transaksi',
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(
            horizontal: defaultMargin,
            vertical: 24,
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
          padding: EdgeInsets.all(
            defaultMargin,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              ImageWidget(
                image: logoBlack,
                height: 40,
                fit: BoxFit.contain,
              ),
              const SizedBox(
                height: 44,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    label: "#${widget.data['code']}",
                    color: fontPrimaryColor,
                    weight: 'bold',
                  ),
                  status(
                    widget.data['status'],
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 12,
                ),
                height: 1,
                decoration: BoxDecoration(
                  color: borderColor,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    label: "Nama",
                    color: fontSecondaryColor,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  TextWidget(
                    label: capitalizeFirstLetter(
                      widget.data['user']['name'],
                    ),
                    color: fontPrimaryColor,
                    weight: 'medium',
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    label: "Email",
                    color: fontSecondaryColor,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  TextWidget(
                    label: widget.data['user']['email'],
                    color: fontPrimaryColor,
                    weight: 'medium',
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    label: "No Telepon",
                    color: fontSecondaryColor,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  TextWidget(
                    label: widget.data['user']['phone_number'],
                    color: fontPrimaryColor,
                    weight: 'medium',
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    label: "Tanggal Laundry",
                    color: fontSecondaryColor,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  TextWidget(
                    label: formatDateTimeInput(
                      widget.data['created_at'],
                    ),
                    color: fontPrimaryColor,
                    weight: 'medium',
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 12,
                ),
                height: 1,
                decoration: BoxDecoration(
                  color: borderColor,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    label: "Kategori",
                    color: fontSecondaryColor,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  TextWidget(
                    label: capitalizeFirstLetter(
                      widget.data['category']['name'],
                    ),
                    color: fontPrimaryColor,
                    weight: 'medium',
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    label: "Harga (kg)",
                    color: fontSecondaryColor,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  TextWidget(
                    label: formatPrice(
                      amount: widget.data['category']['price'],
                    ),
                    color: fontPrimaryColor,
                    weight: 'medium',
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    label: "Berat (kg)",
                    color: fontSecondaryColor,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  TextWidget(
                    label: "${widget.data['weight']} Kilogram",
                    color: fontPrimaryColor,
                    weight: 'medium',
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                  top: defaultMargin + 8,
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
                padding: EdgeInsets.all(
                  defaultMargin,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      label: "Total",
                      color: fontPrimaryColor,
                      weight: 'bold',
                      type: 's3',
                    ),
                    TextWidget(
                      label: formatPrice(
                        amount: widget.data['category']['price'],
                      ),
                      color: fontPrimaryColor,
                      weight: 'bold',
                      type: 's3',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
