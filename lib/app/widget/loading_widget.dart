import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iclinix/utils/dimensions.dart';

class LoadingDialog {
  static void showLoading({String? message}) {
    Get.dialog(
      const Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Center(
          child: _LoadingWidget(),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static void hideLoading() {
    Get.back();
  }
}

class _LoadingWidget extends StatefulWidget {
  const _LoadingWidget();

  @override
  __LoadingWidgetState createState() => __LoadingWidgetState();
}

class __LoadingWidgetState extends State<_LoadingWidget> {
  double _opacity = 1.0;

  @override
  void initState() {
    super.initState();
    _startFadeAnimation();
  }

  void _startFadeAnimation() {
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (mounted) {
        setState(() {
          _opacity = _opacity == 0.0 ? 1.0 : 0.0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.paddingSize20),
      decoration: BoxDecoration(color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.radius10)
       ),
      child: AnimatedOpacity(
        opacity: _opacity,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: Image.asset(
          'assets/icons/ic_logo.png', // Your logo asset
          height: 80,
          width: 80,
        ),
      ),
    );
  }
}
