import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kertasinapp/controllers/home/home_controller.dart';
import 'package:kertasinapp/controllers/home/productButtonController.dart';
import 'package:kertasinapp/pages/profile/ProfilePage.dart';
import 'package:kertasinapp/utilities/colors.dart';
import 'package:kertasinapp/utilities/typhography.dart';
import 'package:kertasinapp/widgets/ButtonCard.dart';
import 'package:kertasinapp/widgets/ButtonDefault.dart';
import 'package:kertasinapp/widgets/CardNews.dart';
import '../login/LoginPage.dart';

class Homescreen extends StatelessWidget {
  Homescreen({super.key});

  final controller = Get.put(ProductButtonController());

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .snapshots(),
      builder: (context, snapshot) {
        // Menampilkan loading indicator jika data belum tersedia
        if (snapshot.connectionState == ConnectionState.waiting ||
            !snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        // Menampilkan pesan error jika ada error
        if (snapshot.hasError) {
          return const Center(child: Text("Error loading user data"));
        }

        // Menampilkan pesan jika data tidak ditemukan
        if (!snapshot.data!.exists) {
          return const Center(child: Text("User data not found"));
        }

        // Data tersedia, lanjutkan rendering UI
        final userData = snapshot.data!.data() as Map<String, dynamic>;
        final userName = userData['name'] as String? ?? 'Unknown';

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
                    bottom: Radius.circular(24),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Get.height * 0.06),
                      Text(
                        "Hi $userName, welcome to",
                        style:
                            TStyle.subtitle1.copyWith(color: kColorPureWhite),
                      ),
                      Text(
                        "KERTASIN",
                        style: TStyle.title.copyWith(color: kColorPureWhite),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Buttondefault(
                            text: "Buat Invoice Sekarang",
                            isPrimary: false,
                          ),
                          Spacer(),
                        ],
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
        );
      },
    );
  }
}
