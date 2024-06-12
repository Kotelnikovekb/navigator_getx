/*
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
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'navbar_router/navbar_router_app.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      //initialRoute: '/',
      home: HomePage(),
      getPages: [
        GetPage(
          name: '/home',
          page: () => HomePage(),
          children: [
/*
            GetPage(
                name: '/dashboard',
                page: () => DashboardPage(),
                children: [
                  GetPage(
                    name: '/dashboard/profile',
                    page: () => ProfilePage(),
                  ),
                  GetPage(
                    name: '/dashboard/settings',
                    page: () => SettingsPage(),
                  ),
                  ]
            )
*/
          ]

        ),
      ],
      /*title: 'Ultimate Todo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: NavbarRouterApp(),*/
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: GetNavigator(
        key: Get.nestedKey('99')!.navigatorKey,
        initialRoute: '/',
        pages: [
          GetPage(
            name: '/',
            page: () => DashboardPage(),
          ),
          GetPage(
            name: '/dashboard/profile',
            page: () => ProfilePage(),

          ),
          GetPage(
            name: '/dashboard/settings',
            page: () => SettingsPage(),
          ),

        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {

        },
        currentIndex: 1,
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
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => Get.toNamed('/dashboard/profile',),
              child: Text('Go to Profile'),
            ),
            ElevatedButton(
              onPressed: () => Get.toNamed('/dashboard/settings',),
              child: Text('Go to Settings'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Center(child: Text('Profile Page')),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Center(child: Text('Settings Page')),
    );
  }
}
