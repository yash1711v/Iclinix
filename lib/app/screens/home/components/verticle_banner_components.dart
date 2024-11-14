import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iclinix/app/widget/custom_button_widget.dart';
import 'package:iclinix/controller/appointment_controller.dart';
import 'package:iclinix/helper/route_helper.dart';
import 'package:iclinix/utils/dimensions.dart';
import 'package:iclinix/utils/images.dart';
import 'package:iclinix/utils/sizeboxes.dart';
import 'package:iclinix/utils/styles.dart';
import 'package:get/get.dart';
class VerticalBannerComponents extends StatelessWidget {
  const VerticalBannerComponents({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppointmentController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Refer System Currently Unavailable.'),
                ),
              );
            },
                child: Image.asset(Images.imgReferHomeBanner)),
            sizedBoxDefault(),
            GestureDetector(onTap: () {
              controller.selectBookingType(false);
              Get.toNamed(RouteHelper.getAllClinicRoute(isBackButton: true));
            },
                child: Image.asset(Images.imgBookAppointmentHomeBanner)),
            sizedBoxDefault(),
            InkWell(onTap: () {
              controller.selectBookingType(false);
              Get.toNamed(RouteHelper.getAllClinicRoute(isBackButton: true));
            },
                child: Image.asset(Images.imgDiabetesHomeBanner)),


          ],
        ),
      );
    });



  }
}
