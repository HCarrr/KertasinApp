import 'package:get/get.dart';
import 'package:kertasinapp/pages/login/LoginPage.dart';
import 'package:kertasinapp/routes/route_name.dart';
import 'package:kertasinapp/pages/HomeScreen.dart';

class PagesRoute {
  static final pages = [
    GetPage(name: RouteName.homeScreen, page: () => Homescreen()),
    GetPage(name: RouteName.loginPage, page: () => LoginPage()),
  ];
}
