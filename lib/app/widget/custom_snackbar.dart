import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showCustomSnackBar(String? message, {bool isError = true}) {
  Fluttertoast.showToast(
    msg: message ?? "",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: isError ? Colors.white : Colors.white,
    // backgroundColor: isError ? Colors.red : Colors.green,
    textColor: Colors.black,
    fontSize: 16.0,
    timeInSecForIosWeb: 3,
  );
}