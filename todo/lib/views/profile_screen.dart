import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  Box accountBox = Hive.box('accounts');
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ValueListenableBuilder(
            valueListenable: accountBox.listenable(),
            builder: (context, Box<dynamic> box, child) {
              return Column(
                children: [
                  Text(box.get("email")),
                  Text(box.get("username")),
                  Text(box.get("token")),
                ],
              );
            }));
  }
}
