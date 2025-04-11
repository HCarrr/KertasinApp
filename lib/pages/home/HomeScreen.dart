import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kertasinapp/controllers/home/productButtonController.dart';
import 'package:kertasinapp/utilities/colors.dart';
import 'package:kertasinapp/utilities/typhography.dart';
import 'package:kertasinapp/widgets/ButtonCard.dart';
import 'package:kertasinapp/widgets/ButtonDefault.dart';
import 'package:kertasinapp/widgets/CardNews.dart';

class Homescreen extends StatelessWidget {
  Homescreen({super.key});

  final controller = Get.put(ProductButtonController());

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
                bottom: Radius.circular(35),
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
                  SizedBox(height: Get.height * 0.03),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Produk   >>", style: TStyle.body1),
                  const SizedBox(height: 16),
                  Obx(() => SizedBox(
                        height: Get.height * 0.04,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.productButtons.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: 8.0),
                          itemBuilder: (context, index) {
                            final item = controller.productButtons[index];
                            return ButtonCard(
                              text: item['text'],
                              onTap: item['onTap'],
                            );
                          },
                        ),
                      )),
                  const SizedBox(height: 18),
                  Image.asset(
                    "assets/img/iklan.png",
                    width: Get.width,
                    height: Get.height * 0.2,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(height: 18),
                  Text("Berita Kertasin.id   >>", style: TStyle.body1),
                  CardNews(),
                  CardNews(),
                  CardNews(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: kColorFirst,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, -1),
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.home, color: kColorPureWhite, size: 28),
                const SizedBox(height: 4),
                Text("Home", style: TStyle.captionWhite),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.receipt_long, color: kColorPureWhite, size: 28),
                const SizedBox(height: 4),
                Text("Pencatatan", style: TStyle.captionWhite),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.person, color: kColorPureWhite, size: 28),
                const SizedBox(height: 4),
                Text("Profil", style: TStyle.captionWhite),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
