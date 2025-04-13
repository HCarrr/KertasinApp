import 'package:get/get.dart';
import 'package:kertasinapp/pages/invoice/InvoicePembelianPage.dart';
import 'package:kertasinapp/pages/login/LoginPage.dart';
import 'package:kertasinapp/pages/main/main_page.dart';
import 'package:kertasinapp/routes/route_name.dart';
import 'package:kertasinapp/pages/home/HomeScreen.dart';

class PagesRoute {
  static final pages = [
    GetPage(name: RoutesName.homeScreen, page: () => Homescreen()),
    GetPage(name: RoutesName.loginPage, page: () => LoginPage()),
    GetPage(
        name: RoutesName.invoicePembelianPage,
        page: () => InvoicePembelianPage()),
    GetPage(name: RoutesName.mainPage, page: () => MainPage()),
  ];
}
