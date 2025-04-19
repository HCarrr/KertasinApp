import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kertasinapp/controllers/home/user_controller.dart';
import 'package:kertasinapp/routes/page_route.dart';
import 'package:kertasinapp/routes/route_name.dart';
import 'package:kertasinapp/utilities/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Get.put(UserController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Kertasin App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: kColorPureWhite,
      ),
      initialRoute: RoutesName.mainPage,
      getPages: PagesRoute.pages,
    );
  }
}
