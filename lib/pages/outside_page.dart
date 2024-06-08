import 'package:flutter/material.dart';

class OutsidePage extends StatelessWidget {
  const OutsidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Outside Page'),
      ),
      body: Column(
        children: [
          Center(
            child: Text('Outside Page'),
          ),

        ],
      ),
    );
  }
}
