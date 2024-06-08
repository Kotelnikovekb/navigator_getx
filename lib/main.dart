import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:navigator_getx/pages/basket/basket_page.dart';
import 'package:navigator_getx/pages/basket/checkout_page.dart';
import 'package:navigator_getx/pages/main_page.dart';
import 'package:navigator_getx/pages/outside_page.dart';

import 'app_x_service.dart';
import 'pages/shop/page1.dart';
import 'pages/shop/page2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      getPages: [
        GetPage(name: '/', page: () => const MainPage()),
        //GetPage(name: '/page1', page: () => const Page1()),
        //GetPage(name: '/page2', page: () => Page2()),
        GetPage(name: '/outside', page: () => OutsidePage()),
        //GetPage(name: '/basket', page: () => BasketPage()),
       // GetPage(name: '/checkout', page: () => CheckoutPage()),
      ],
      initialRoute: '/',
      initialBinding: BindingsBuilder(() {
        Get.lazyPut<AppXService>(() => AppXService());
      }),
    );
  }
}
