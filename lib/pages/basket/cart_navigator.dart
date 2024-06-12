import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'basket_page.dart';
import 'checkout_page.dart';

class CartNavigator extends StatelessWidget {
  const CartNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      reportsRouteUpdateToEngine: true,
      initialRoute: '/basket',
      onGenerateRoute: (settings) {
        if (settings.name == '/basket') {
          return GetPageRoute(
            settings: settings,
            page: () => BasketPage(),
          );
        } else if (settings.name == '/checkout') {
          return GetPageRoute(
            settings: settings,
            page: () => CheckoutPage(),
          );
        }
        return null;
      },
    );
  }
}
