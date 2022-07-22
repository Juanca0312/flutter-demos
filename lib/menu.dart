import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demos'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  onTap: () {},
                  title: const Text('Sqlite'),
                  tileColor: Colors.amber,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
