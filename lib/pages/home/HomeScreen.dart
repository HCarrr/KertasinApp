import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kertasinapp/utilities/colors.dart';
import 'package:kertasinapp/utilities/typhography.dart';
import 'package:kertasinapp/widgets/ButtonDefault.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kColorPureWhite,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Get.width,
              decoration: BoxDecoration(
                color: kColorFirst,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.height * 0.06,
                    ),
                    Text(
                      "Hi huda, welcome to",
                      style: TStyle.subtitle1.copyWith(color: kColorPureWhite),
                    ),
                    Text(
                      "KERTASIN",
                      style: TStyle.title.copyWith(color: kColorPureWhite),
                    ),
                    SizedBox(height: 16),
                    Buttondefault(
                      text: "Buat Invoive Sekarang",
                      isPrimary: false,
                    ),
                    SizedBox(height: Get.height * 0.04),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Text(
                    "Produk   >>",
                    style: TStyle.body1,
                  )
                ],
              ),
            )
          ],
        ));
  }
}
