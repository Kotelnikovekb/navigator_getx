import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:navigator_getx/app_x_service.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page1'),
      ),
      body: Column(
        children: [
          Text('Page1'),
          TextButton(
              onPressed: (){
                Get.toNamed('/page2',id: 1);
              },
              child: Text('to page2')
          ),
          TextButton(
              onPressed: (){
                Get.toNamed('/outside');
              },
              child: Text('to outside page')
          ),
          TextButton(
              onPressed: (){
                Get.find<AppXService>().mainPage(1);

                Get.toNamed('/checkout', id: 2);
              },
              child: Text('checkout')
          )
        ],
      ),
    );
  }
}
