import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class attenance extends StatelessWidget {
  const attenance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Click Me Page"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Home!'),
        ),
      ),
    );
  }
}