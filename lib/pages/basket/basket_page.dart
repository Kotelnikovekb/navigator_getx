import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BasketPage extends StatelessWidget {
  const BasketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Column(
        children: [
          Center(
            child: Text('Basket Page'),
          ),
          TextButton(
              onPressed: (){
                Get.toNamed('/page1', id: 1);
              },
              child: Text('Go to Page1')
          )
        ],
      ),
    );
  }
}
