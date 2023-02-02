// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:Fluido/Constant_components/default_bottom_sheet_style.dart';
import 'package:Fluido/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../PlatformRepository/platform_repository.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final _repository = PlatformRepository();

  String? phonenumber, tillnumber, businessnumber, account, amount;

  callHover(String action) async {
    return await _repository.startHover(
      action,
      phonenumber,
      tillnumber,
      businessnumber,
      account,
      amount,
    );
  }

  TextEditingController phone_controller = TextEditingController();
  TextEditingController till_controller = TextEditingController();
  TextEditingController paybill_controller = TextEditingController();
  TextEditingController account_controller = TextEditingController();
  TextEditingController amount_controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    _askPermissions();
  }

  @override
  void dispose() {
    super.dispose();

    phone_controller.dispose();
    till_controller.dispose();
    paybill_controller.dispose();
    account_controller.dispose();
    amount_controller.dispose();
  }

  Future<void> _askPermissions() async {
    PermissionStatus permissionStatus = await _getPhoneStatePermission();

    if (permissionStatus == PermissionStatus.granted) {
      return;
    } else {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  Future<PermissionStatus> _getPhoneStatePermission() async {
    PermissionStatus permission = await Permission.phone.status;

    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.phone.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      return DefaultSnackBar(context, "Permissions denied", false, 3, false);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      return DefaultSnackBar(context,
          "Enable permissions through device settings", false, 5, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          defaultElevatedButton(
            false,
            () => callHover("CheckBalance"),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Check balance',
                textAlign: TextAlign.center,
                style: TextStyle(color: kPrimaryColor),
              ),
            ),
          ),
          const SizedBox(height: 15.0),
          defaultElevatedButton(
            false,
            () => buildSendMoney(false, false),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Send money',
                textAlign: TextAlign.center,
                style: TextStyle(color: kPrimaryColor),
              ),
            ),
          ),
          const SizedBox(height: 15.0),
          defaultElevatedButton(
            false,
            () => buildSendMoney(true, false),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Buy goods & services',
                textAlign: TextAlign.center,
                style: TextStyle(color: kPrimaryColor),
              ),
            ),
          ),
          const SizedBox(height: 15.0),
          defaultElevatedButton(
            false,
            () => buildPayBill(),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Pay a bill',
                textAlign: TextAlign.center,
                style: TextStyle(color: kPrimaryColor),
              ),
            ),
          ),
          const SizedBox(height: 15.0),
          defaultElevatedButton(
            false,
            () => buildSendMoney(false, true),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Buy airtime',
                textAlign: TextAlign.center,
                style: TextStyle(color: kPrimaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> buildSendMoney(bool isTill, bool isAirtime) {
    setState(() {
      phone_controller.clear();
      till_controller.clear();
      amount_controller.clear();
    });

    return defaultIconBottomSheet(
      context,
      isTill
          ? 'Buy Goods & Services'
          : isAirtime
              ? 'Buy Airtime'
              : 'Send Money',
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20.0),
          isTill ? tillnumberTextInput() : phonenumberTextInput(),
          const SizedBox(height: 10.0),
          amountTextInput(),
          const SizedBox(height: 20.0),
          defaultElevatedButton(
            false,
            () {
              if (isTill
                  ? (till_controller.text.isEmpty ||
                      amount_controller.text.isEmpty)
                  : (phone_controller.text.isEmpty ||
                      amount_controller.text.isEmpty)) {
                Fluttertoast.showToast(
                  msg: 'Please fill all fields',
                  toastLength: Toast.LENGTH_LONG,
                );
              } else {
                callHover(isTill
                    ? "BuyGoods"
                    : isAirtime
                        ? "BuyAirtime"
                        : "SendMoney");
                Navigator.pop(context);
              }
            },
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                isTill
                    ? 'Buy Goods & Services'
                    : isAirtime
                        ? 'Buy Airtime'
                        : 'Send Money',
                textAlign: TextAlign.center,
                style: TextStyle(color: kPrimaryColor),
              ),
            ),
          ),
        ],
      ),
      isTill
          ? Icons.store
          : isAirtime
              ? Icons.phone_callback
              : Icons.send,
      const EdgeInsets.all(15.0),
    );
  }

  Future<dynamic> buildPayBill() {
    setState(() {
      paybill_controller.clear();
      account_controller.clear();
      amount_controller.clear();
    });

    return defaultIconBottomSheet(
      context,
      'Pay Bill',
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20.0),
          paybillnumberTextInput(),
          const SizedBox(height: 10.0),
          accountTextInput(),
          const SizedBox(height: 10.0),
          amountTextInput(),
          const SizedBox(height: 20.0),
          defaultElevatedButton(
            false,
            () {
              if (paybill_controller.text.isEmpty ||
                  account_controller.text.isEmpty ||
                  amount_controller.text.isEmpty) {
                Fluttertoast.showToast(
                  msg: 'Please fill all fields',
                  toastLength: Toast.LENGTH_LONG,
                );
              } else {
                callHover("PayBill");
                Navigator.pop(context);
              }
            },
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Pay Bill',
                textAlign: TextAlign.center,
                style: TextStyle(color: kPrimaryColor),
              ),
            ),
          ),
        ],
      ),
      Icons.payment,
      const EdgeInsets.all(15.0),
    );
  }

  TextFormField phonenumberTextInput() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      controller: phone_controller,
      autofocus: false,
      onChanged: (query) => phonenumber = query,
      decoration: getDecoration('Enter phone number', Icons.phone),
    );
  }

  TextFormField tillnumberTextInput() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: till_controller,
      autofocus: false,
      onChanged: (query) => tillnumber = query,
      decoration: getDecoration('Enter till number', Icons.store),
    );
  }

  TextFormField paybillnumberTextInput() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: paybill_controller,
      autofocus: false,
      onChanged: (query) => businessnumber = query,
      decoration: getDecoration('Enter business number', Icons.business_center),
    );
  }

  TextFormField accountTextInput() {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: account_controller,
      autofocus: false,
      onChanged: (query) => account = query,
      decoration: getDecoration('Enter account', Icons.account_balance),
    );
  }

  TextFormField amountTextInput() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: amount_controller,
      autofocus: false,
      onChanged: (query) => amount = query,
      decoration: getDecoration('Enter amount', Icons.attach_money),
    );
  }

  InputDecoration getDecoration(String hint, IconData icon) {
    return InputDecoration(
      constraints: BoxConstraints(
          maxHeight: 40, maxWidth: MediaQuery.of(context).size.width - 40),
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 12),
      fillColor: Colors.grey.shade200,
      filled: true,
      prefixIcon: Icon(icon, size: 18),
      prefixIconConstraints: const BoxConstraints(minWidth: 35),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.grey.shade300, width: 0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: kPrimaryColorLight, width: 0),
      ),
      contentPadding: const EdgeInsets.only(left: 10),
      floatingLabelBehavior: FloatingLabelBehavior.always,
    );
  }
}
