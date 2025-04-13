import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:collection/collection.dart';
import 'package:kertasinapp/controllers/home/home_controller.dart';
import 'package:kertasinapp/pages/home/bottomBar/item_navbar.dart';
import 'package:kertasinapp/pages/print.dart';
import 'package:kertasinapp/utilities/colors.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);
  final HomeController mainController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorPureWhite,
      body: Column(
        children: [
          Expanded(
            child: AnimatedSwitcher(
              transitionBuilder: (Widget child, Animation<double> animation) =>
                  FadeTransition(
                opacity: animation,
                child: child,
              ),
              duration: const Duration(milliseconds: 300),
              child: Obx(
                () => Container(
                    key: ValueKey<int>(mainController.selectedIndex.value),
                    child: mainController
                        .items[mainController.selectedIndex.value].widget),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: Platform.isIOS ? 20 : 0),
            decoration: const BoxDecoration(
              color: kColorFirst,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24), topRight: Radius.circular(24)),
            ),
            child: Obx(
              () => Row(
                children: mainController.items
                    .mapIndexed(
                      (idx, _) => Expanded(
                          child: ItemNavbar(
                              model: mainController.items[idx],
                              isActive:
                                  mainController.selectedIndex.value == idx,
                              onTap: () {
                                if (idx == mainController.selectedIndex.value) {
                                } else {
                                  mainController.selectedIndex.value = idx;
                                }
                                logPrint("INDEX : $idx");
                              })),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
