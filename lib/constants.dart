import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Color kPrimaryColor = Color(0xFFD67D00);
Color kPrimaryColorLight = const Color(0xFFD67D00).withOpacity(0.25);
Color kPrimaryColorLighter = const Color(0xFFD67D00).withOpacity(0.05);

const kWhiteColor = Colors.white;
const kTextColorBlack = Colors.black;

const kSuccessGreen = Color(0xFF4CAF50);
const kLogoutRed = Color(0xFFFF7171);
const kPendingOrange = Color(0xFFFF9800);

Future checkContainsKey(key, Function keyFunction) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey(key)) {
    keyFunction();
  }
}

Future<String> getStringPref(key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key) ?? "";
}

Future<int> getintPref(key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt(key) ?? 0;
}

Future<bool> getBoolPref(key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool(key) ?? false;
}

Future<double> getDoublePref(key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getDouble(key) ?? 0.0;
}

Future<void> setStringPref(key, String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

Future<void> setIntPref(key, int value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt(key, value);
}

Future<void> setBoolPref(key, bool value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(key, value);
}

Future<void> setDoublePref(key, double value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setDouble(key, value);
}

Future<void> clearAllPrefs(key, double value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
}

Future<void> clearSpecificPref(key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove(key);
}

DefaultSnackBar(context, message, isSuccess, int duration, isLow) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, textAlign: TextAlign.center),
        duration: Duration(seconds: duration),
        behavior: SnackBarBehavior.floating,
        backgroundColor: isSuccess ? kSuccessGreen : kLogoutRed,
        margin: EdgeInsets.only(
          bottom: isLow ? 20 : kBottomNavigationBarHeight + 25,
          left: 20,
          right: 20,
        ),
      ),
    );

defaultElevatedButton(
        bool bordered, Function() onPressed, Widget childWidget) =>
    ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        enableFeedback: true,
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(width: bordered ? 1.2 : 0.0, color: kPrimaryColor),
          ),
        ),
        alignment: Alignment.center,
        elevation: MaterialStateProperty.all(3.0),
        padding: MaterialStateProperty.all(const EdgeInsets.all(10.0)),
        backgroundColor:
            MaterialStateProperty.all(bordered ? kPrimaryColor : kWhiteColor),
        textStyle: MaterialStateProperty.all(
          const TextStyle(fontSize: 15),
        ),
      ),
      child: childWidget,
    );
