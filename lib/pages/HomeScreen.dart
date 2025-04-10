import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kertasinapp/utilities/colors.dart';
import 'package:kertasinapp/utilities/typhography.dart';

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
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).viewPadding.top + 12,
              left: 16,
              right: 16,
              bottom: 12,
            ),
            decoration: BoxDecoration(
              color: kColorFirst,
            ),
            child: Row(
              children: [
                IconButton(
                  color: Colors.white,
                  onPressed: () {},
                  icon: Icon(Icons.arrow_back),
                ),
                Expanded(
                    child: Text(
                  "Kertas-in",
                  style: TStyle.judul,
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
