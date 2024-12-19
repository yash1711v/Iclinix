import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/dimensions.dart';
class CustomCardContainer extends StatelessWidget {
  final Widget child;
  final Function()? tap;
  final double? radius;
  const CustomCardContainer({super.key, required this.child, required this.tap, this.radius});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Container(
        width: Get.size.width,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(radius ?? Dimensions.radius15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Shadow color
              spreadRadius: 2, // Spread radius of the shadow
              blurRadius: 5, // Blur radius of the shadow
              offset: const Offset(0, 3), // Offset of the shadow
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
