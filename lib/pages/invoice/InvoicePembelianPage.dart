import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kertasinapp/controllers/invoicePembelianController.dart';
import 'package:kertasinapp/pages/invoice/TambahInvoicePembelianPage.dart';
import 'package:kertasinapp/utilities/assets_constants.dart';
import 'package:kertasinapp/utilities/colors.dart';
import 'package:kertasinapp/utilities/typhography.dart';

class InvoicePembelianPage extends StatelessWidget {
  const InvoicePembelianPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InvoicePembelianController());

    return Scaffold(
      backgroundColor: kColorPureWhite,
      body: Column(
        children: [
          Container(
            width: Get.width,
            decoration: BoxDecoration(
              color: kColorFirst,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
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
                      style: TStyle.headline4,
                    ),
                    Spacer(),
                    const Icon(
                      Icons.info_outline_rounded,
                      size: 30.0,
                      color: kColorPureWhite,
                    ),
                    SizedBox(width: 18),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18, right: 18),
                  child: Row(
                    children: [
                      Image.asset(
                        AssetsConstant.ilInvoice,
                        height: 140,
                        width: 140,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          "buat invoice pembelian disini untuk mencatat pembelian barang",
                          style: TStyle.captionWhite,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 0),
                Padding(
                  padding: const EdgeInsets.only(right: 18, bottom: 20),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () async {
                        final result = await Get.to(() => TambahInvoicePembelianPage());
                        if (result == true) {
                          print('Returned from TambahInvoicePembelianPage, restarting stream');
                          controller.refreshData();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kColorThird,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                      child: Text(
                        "Tambah",
                        style: TStyle.captionWhite,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "History",
                  style: TStyle.headline3,
                ),
                Icon(Icons.chevron_right_rounded, size: 28),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (controller.invoices.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text(
                      "Belum ada riwayat invoice pembelian",
                      style: TStyle.body2.copyWith(color: kColorGrey),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              } else {
                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  itemCount: controller.invoices.length,
                  itemBuilder: (context, index) {
                    final invoice = controller.invoices[index];
                    print('Rendering invoice: ${invoice['id']}');
                    return _buildHistoryItem(
                      invoice['nomorInvoice'] ?? 'INV-Unknown',
                      controller.formatDate(invoice['tanggal']),
                      invoice['totalItem']?.toString() ?? '0',
                      controller.formatHarga(invoice['totalHarga']),
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(String nomorInvoice, String tanggal, String totalItem, String totalHarga) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: kColorLightGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "No. Invoice: $nomorInvoice",
            style: TStyle.body2.copyWith(color: kColorGrey),
          ),
          SizedBox(height: 4),
          Text(
            "Tanggal: $tanggal",
            style: TStyle.body2.copyWith(color: kColorGrey),
          ),
          SizedBox(height: 4),
          Text(
            "Total item: $totalItem",
            style: TStyle.body2.copyWith(color: kColorGrey),
          ),
          SizedBox(height: 4),
          Text(
            "Total harga: Rp. $totalHarga",
            style: TStyle.body2.copyWith(color: kColorGrey),
          ),
        ],
      ),
    );
  }
}
