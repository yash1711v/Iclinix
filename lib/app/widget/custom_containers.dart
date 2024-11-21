import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iclinix/utils/dimensions.dart';
import 'package:get/get.dart';

class CustomDecoratedContainer extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double ? verticalPadding;
  final double ? horizontalPadding;
  final double ? height;
  const CustomDecoratedContainer({super.key, required this.child, this.color, this.verticalPadding, this.horizontalPadding, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.size.width,
      height: height,
      padding:  EdgeInsets.symmetric(vertical: verticalPadding ?? Dimensions.paddingSizeDefault,
      horizontal:horizontalPadding ?? Dimensions.paddingSizeDefault, ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius10),
          color: color ?? Theme.of(context).primaryColor.withOpacity(0.07)
      ),
      child: child,
    );
  }
}
