import 'package:Fluido/Screens/Home/home_body.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColorLighter,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Text(
              'Home',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kTextColorBlack),
            ),
          ],
        ),
        iconTheme: const IconThemeData(color: kTextColorBlack),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: const HomeBody(),
    );
  }
}
