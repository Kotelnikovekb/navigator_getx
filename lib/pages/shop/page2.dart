import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text('Page2'),
          TextButton(
              onPressed: (){
                Get.back(id: 1);
              },
              child: Text('back')
          ),
          TextButton(
              onPressed: (){
                Get.toNamed('/outside');
              },
              child: Text('to outside page')
          )
        ],
      )
    );
  }
}
