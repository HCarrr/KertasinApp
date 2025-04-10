import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kertasinapp/utilities/colors.dart';
import 'package:kertasinapp/utilities/typhography.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kColorPureWhite,
        body: Column(
          children: [
            Container(
              height: Get.height * 0.08,
              decoration: BoxDecoration(
                color: kColorFirst,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(150),
                ),
              ),
            ),
            Spacer(),
            Text(
              "Login",
              style: TStyle.subtitle1,
            ),
          ],
        ));
  }
}
