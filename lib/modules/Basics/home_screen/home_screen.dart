import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        leading: const Icon(
          Icons.menu,
        ),
        title: const Text('hello my friend'),
        actions: [
          const Icon(
            Icons.menu,
          ),
          const Icon(
            Icons.add_a_photo,
          ),
          IconButton(
            icon: const Icon(
              Icons.wifi_outlined,
            ),
            onPressed: () {
              print('hi');
            },
          )
        ],
      ),
      body: const Text(''),
    );
  }
}
