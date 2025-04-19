import 'package:get/get.dart';
import 'package:kertasinapp/pages/barang/BarangPage.dart';
import 'package:kertasinapp/pages/invoice/InvoicePembelianPage.dart';
import 'package:kertasinapp/pages/invoice/InvoicePenjualanPage.dart';
import 'package:kertasinapp/pages/login/LoginPage.dart';
import 'package:kertasinapp/routes/route_name.dart';

class ProductButtonController extends GetxController {
  final productButtons = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    productButtons.assignAll([
      {
        'text': 'Invoice Pembelian',
        'onTap': () {
          Get.toNamed(RoutesName.invoicePembelianPage);
        },
      },
      {
        'text': 'Invoice Penjualan',
        'onTap': () {
          Get.toNamed(RoutesName.invoicePembelianPage);
        },
      },
      {
        'text': 'Data Barang',
        'onTap': () {
          Get.toNamed(RoutesName.barangPage);
        },
      },
      {
        'text': 'Pencatatan Biaya',
        'onTap': () {
          // action
        },
      },
    ]);
    super.onInit();
  }
}
