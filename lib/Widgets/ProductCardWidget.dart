import 'package:flutter/material.dart';
import 'package:medic_petcare/Utils/Themes.dart';
import 'package:medic_petcare/Utils/Utils.dart';
import 'package:medic_petcare/Widgets/TextWidget.dart';

class ProductCardWidget extends StatelessWidget {
  final Map<String, dynamic> data;
  const ProductCardWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

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

    return Container(
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
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    label: "#${data['code']}",
                    color: fontPrimaryColor,
                    weight: 'bold',
                  ),
                  status(
                    data['status'],
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        label: "Nama",
                        color: fontSecondaryColor,
                        type: 'l1',
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      TextWidget(
                        label: capitalizeFirstLetter(
                          data['user']['name'],
                        ),
                        color: fontPrimaryColor,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextWidget(
                        label: "No Telepon",
                        color: fontSecondaryColor,
                        type: 'l1',
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      TextWidget(
                        label: data['user']['phone_number'],
                        color: fontPrimaryColor,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        label: "Tanggal Laundry",
                        color: fontSecondaryColor,
                        type: 'l1',
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      TextWidget(
                        label: formatDateInput(
                          data['created_at'],
                        ),
                        color: fontPrimaryColor,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextWidget(
                        label: "Total Harga",
                        color: fontSecondaryColor,
                        type: 'l1',
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      TextWidget(
                        label: formatPrice(
                          amount: data['price'],
                        ),
                        weight: 'bold',
                        color: secondaryColor,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
