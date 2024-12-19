import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iclinix/helper/route_helper.dart';
import 'package:iclinix/utils/dimensions.dart';
import 'package:iclinix/utils/images.dart';
import 'package:get/get.dart';
class NotificationButton extends StatelessWidget {
  const NotificationButton({super.key,});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: () {
        Get.toNamed(RouteHelper.getNotificationRoute());
      },
      child: Container(
          padding: const EdgeInsets.all(Dimensions.paddingSize4),
          child: Image.asset(Images.icNotification,height: Dimensions.fontSize24,)),
    );
  }
}
