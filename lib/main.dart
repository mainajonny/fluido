import 'package:Fluido/Screens/Home/home_screen.dart';
import 'package:Fluido/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: kWhiteColor,
        scaffoldBackgroundColor: kWhiteColor,
        primaryColor: kPrimaryColor,
        //fontFamily: "Poppins",
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: kPrimaryColor),
      ),
      initialRoute: HomeScreen.routeName,
      routes: routes,
    );
  }
}
