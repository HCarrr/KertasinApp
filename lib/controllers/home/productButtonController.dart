import 'package:get/get.dart';
import 'package:kertasinapp/pages/invoice/InvoicePembelianPage.dart';
import 'package:kertasinapp/pages/login/LoginPage.dart';

class ProductButtonController extends GetxController {
  final productButtons = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    productButtons.assignAll([
      {
        'text': 'Invoice Pembelian',
        'onTap': () => Get.to(() => const LoginPage()),
      },
      {
        'text': 'Invoice Penjualan',
        'onTap': () => Get.to(() => const InvoicePembelianPage()),
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
