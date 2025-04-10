import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kertasinapp/pages/home/HomeScreen.dart';
import 'package:kertasinapp/utilities/colors.dart';
import 'package:kertasinapp/utilities/typhography.dart';
import 'package:kertasinapp/widgets/ButtonDefault.dart';

import '../../utilities/assets_constants.dart';
import '../../widgets/CustomeTextField.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorPureWhite,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: Container(
              height: Get.height * 0.06,
              width: Get.width,
              decoration: BoxDecoration(
                color: kColorFirst,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(150),
                ),
              ),
            ),
          ),
          Positioned(
            top: Get.height * 0.3,
            left: -50,
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: kColorFirst,
                borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(100),
                ),
              ),
            ),
          ),
          Positioned(
            top: Get.height * 0.5,
            right: -50,
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: kColorFirst,
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(100),
                ),
              ),
            ),
          ),
          Column(
            children: [
              const Spacer(),
              Text(
                "Log In",
                style: TStyle.title,
              ),
              Container(
                margin: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 217, 226, 255)
                      .withOpacity(0.25),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const CustomTextField(hintText: 'Email'),
                      const CustomTextField(
                          hintText: 'Password', isPassword: true),
                      const SizedBox(height: 16),
                      Buttondefault(
                        text: "Login",
                        onTap: () {
                          Get.to(Homescreen());
                        },
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Belum punya akun?",
                            style: TStyle.textChat,
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(() => const Homescreen());
                            },
                            child: Text(
                              " Register",
                              style: TStyle.textChat
                                  .copyWith(color: kColorPrimary),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Text(
                "atau Login dengan",
                style: TStyle.textChat,
              ),
              IconButton(
                onPressed: () {
                  // Aksi saat diklik
                },
                icon: Image.asset(
                  AssetsConstant.icGoogle,
                  width: 46,
                  height: 46,
                ),
              ),
              const SizedBox(height: 26),
              Container(
                height: Get.height * 0.06,
                decoration: BoxDecoration(
                  color: kColorFirst,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(150),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
