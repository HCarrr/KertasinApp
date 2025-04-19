// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kertasinapp/controllers/invoice/history_invoice/history_pembelian_controller.dart';
import 'package:kertasinapp/pages/invoice/widget/filter_item.dart';
import 'package:kertasinapp/utilities/colors.dart';

import '../../utilities/assets_constants.dart';
import '../../utilities/typhography.dart';
import '../../widgets/AppbarDefault.dart';

class HistoryPembelianPage extends StatelessWidget {
  final HistoryPembelianController controller =
      Get.put(HistoryPembelianController());

  HistoryPembelianPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorPureWhite,
      body: Column(
        children: [
          Stack(
            children: [
              Positioned.fill(
                child: Container(
                  color: kColorPureWhite,
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: SvgPicture.asset(AssetsConstant.bgNotif),
              ),
              const AppBarDefault(
                title: "History Data Biaya",
                bgColor: Colors.transparent,
                textColor: kColorPureBlack,
                useShadow: false,
              ),
            ],
          ),
          Container(
            width: Get.width,
            color: kColorPrimary,
            padding: EdgeInsets.symmetric(vertical: 28),
            child: SizedBox(
              height: 48,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.filters.length,
                itemBuilder: (context, index) {
                  return Obx(() {
                    final item = controller.filters[index];
                    final isSelected = controller.selectedIndex.value == index;
                    return FilterItem(
                      text: item.label,
                      isActive: isSelected,
                      isFirstIndex: index == 0,
                      onTap: () => controller.selectFilter(index),
                    );
                  });
                },
              ),
            ),
          ),
          SizedBox(height: 24),
          Obx(() => Text(
                "${controller.filters[controller.selectedIndex.value].label} history",
                style: TStyle.headline3,
              )),
          SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(10, (index) {
                  return Container(
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: kColorLightGrey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tanggal: 10-01-24",
                          style: TStyle.body2.copyWith(color: kColorGrey),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Total item: 10",
                          style: TStyle.body2.copyWith(color: kColorGrey),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Total harga: Rp. 150.000",
                          style: TStyle.body2.copyWith(color: kColorGrey),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
