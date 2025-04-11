import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kertasinapp/utilities/assets_constants.dart';
import 'package:kertasinapp/utilities/colors.dart';
import 'package:kertasinapp/utilities/typhography.dart';

class InvoicePembelianPage extends StatelessWidget {
  const InvoicePembelianPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorPureWhite,
      body: Column(
        children: [
          Container(
            width: Get.width,
            decoration: BoxDecoration(
              color: kColorFirst,
              borderRadius: BorderRadius.all(Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.arrow_back_ios_new_rounded),
                      color: kColorPureWhite,
                    ),
                    Text(
                      "Invoice Pembelian",
                      style: TStyle.headline4.copyWith(color: kColorPureWhite),
                    ),
                    Spacer(),
                    const Icon(
                      Icons.info_outline_rounded,
                      size: 30.0,
                      color: kColorPureWhite,
                    ),
                    SizedBox(
                      width: 18,
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18, right: 18),
                  child: Row(
                    children: [
                      Image.asset(AssetsConstant.ilInvoice),
                      const SizedBox(
                          width: 12), // ← jarak antara image dan text
                      Expanded(
                        child: Text(
                          "buat invoice penjualan disini untuk membantu usaha kamu",
                          style: TStyle.captionWhite,
                          overflow: TextOverflow.ellipsis, // ← cegah overflow
                          maxLines:
                              2, // ← batasi jumlah baris (atau bisa dibiarkan wrap otomatis)
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
