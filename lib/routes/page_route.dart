import 'package:get/get.dart';
import 'package:kertasinapp/pages/invoice/InvoicePembelianPage.dart';
import 'package:kertasinapp/pages/invoice/InvoicePenjualanPage.dart';
import 'package:kertasinapp/pages/invoice/TambahInvoicePembelianPage.dart';
import 'package:kertasinapp/pages/invoice/TambahInvoicePenjualanPage.dart';
import 'package:kertasinapp/pages/login/LoginPage.dart';
import 'package:kertasinapp/routes/route_name.dart';
import 'package:kertasinapp/pages/home/HomeScreen.dart';

class PagesRoute {
  static final pages = [
    GetPage(name: RouteName.homeScreen, page: () => Homescreen()),
    GetPage(name: RouteName.loginPage, page: () => LoginPage()),
    GetPage(
        name: RouteName.invoicePenjualanPage,
        page: () => InvoicePenjualanPage()),
    GetPage(
        name: RouteName.invoicePembelianPage,
        page: () => InvoicePembelianPage()),
    GetPage(
        name: RouteName.tambahInvoicePembelianPage,
        page: () => TambahInvoicePembelianPage()),
    GetPage(
        name: RouteName.tambahInvoicePenjualanPage,
        page: () => TambahInvoicePenjualanPage()),
  ];
}
