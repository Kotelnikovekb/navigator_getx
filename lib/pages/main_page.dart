import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:navigator_getx/pages/shop/page1.dart';
import 'package:navigator_getx/pages/shop/page2.dart';
import 'package:navigator_getx/pages/shop/shop_page.dart';

import '../app_x_service.dart';
import 'basket/basket_page.dart';
import 'basket/cart_navigator.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final appXService = Get.find<AppXService>();
  List<Widget> _pages = [
    ShopPage(),
    CartNavigator(),
  ];
  int selectPage=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
          (){
            return Stack(
              children: _pages.asMap().map((i, page) {
                return MapEntry(
                  i,
                  Offstage(
                    offstage: appXService.mainPage() != i,
                    child: page,
                  ),
                );
              }).values.toList(),
            );
          }
      ),
      /*
      Stack(
        children: _pages.asMap().map((i, page) {
          return MapEntry(
            i,
            Offstage(
              offstage: selectPage != i,
              child: page,
            ),
          );
        }).values.toList(),
      )
       */
      bottomNavigationBar: Obx(
          ()=>BottomNavigationBar(
            onTap: (index) {
              appXService.mainPage(index);
            },
            currentIndex: appXService.mainPage(),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Page1',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Page2',
              ),
            ],
          )
      ),
    );
  }
}
