import 'package:get/get.dart';
import 'package:kertasinapp/pages/invoice/InvoicePembelianPage.dart';
import 'package:kertasinapp/pages/login/LoginPage.dart';
import 'package:kertasinapp/routes/route_name.dart';
import 'package:kertasinapp/pages/home/HomeScreen.dart';

class PagesRoute {
  static final pages = [
    GetPage(name: RouteName.homeScreen, page: () => Homescreen()),
    GetPage(name: RouteName.loginPage, page: () => LoginPage()),
    GetPage(
        name: RouteName.invoicePembelianPage,
        page: () => InvoicePembelianPage()),
  ];
}
