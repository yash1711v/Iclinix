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
class BookAppointmentComponent extends StatelessWidget {
  const BookAppointmentComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppointmentController>(builder: (control) {
      return  Padding(
        padding: const EdgeInsets.symmetric(horizontal :Dimensions.paddingSizeDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius15)
                ),
                child: Image.asset(Images.imgHomeAppointmentCard)),
            sizedBoxDefault(),
            CustomButtonWidget(
              useGradient: true,
              gradient: const LinearGradient(
                colors: [Color(0xffd78f67), Color(0xffbb4a19)],
                stops: [0, 1],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              buttonText: 'Book Appointment',
              onPressed: () {
                control.selectBookingType(false);
                Get.toNamed(RouteHelper.getAllClinicRoute(isBackButton: true));
              },)
          ],
        ),
      );
    });




  }
}
