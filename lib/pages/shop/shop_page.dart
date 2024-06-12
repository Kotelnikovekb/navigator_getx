import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:navigator_getx/pages/shop/page1.dart';
import 'package:navigator_getx/pages/shop/page2.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

    return Navigator(
      key: Get.nestedKey('1')!.navigatorKey,
      initialRoute: '/page1',
      onGenerateRoute: (settings) {
        if (settings.name == '/page1') {
          return GetPageRoute(
            settings: settings,
            page: () => Page1(),
          );
        } else if (settings.name == '/page2') {
          return GetPageRoute(
            settings: settings,
            page: () => Page2(),
          );
        }
        return null;
      },
    );
  }
}
