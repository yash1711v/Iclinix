import 'package:flutter/material.dart';
import 'package:iclinix/app/screens/dashboard/dashboard_screen.dart';
import 'package:iclinix/app/widget/custom_button_widget.dart';
import 'package:iclinix/app/widget/custom_containers.dart';
import 'package:iclinix/controller/auth_controller.dart';
import 'package:iclinix/controller/profile_controller.dart';
import 'package:iclinix/helper/date_converter.dart';
import 'package:iclinix/helper/route_helper.dart';
import 'package:iclinix/utils/dimensions.dart';
import 'package:iclinix/utils/images.dart';
import 'package:iclinix/utils/sizeboxes.dart';
import 'package:iclinix/utils/styles.dart';
import 'package:iclinix/utils/themes/light_theme.dart';
import 'package:get/get.dart';

class PlanBookingSuccessfulScreen extends StatelessWidget {
  const PlanBookingSuccessfulScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Returning false will disable the back gesture
        return false;
      },
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Column(crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(Images.icBookingSuccessful,height: 160,),
                sizedBox10(),
                Text('Payment Successful!',style: openSansBold.copyWith(color: blueColor,
                    fontSize: Dimensions.fontSize20),),
                sizedBox5(),
                Text('You have successfully purchased your plan',
                  textAlign: TextAlign.center,
                  style: openSansRegular.copyWith(
                      fontSize: Dimensions.fontSize12,
                      color: Theme.of(context).disabledColor.withOpacity(0.70)),),
                sizedBox40(),
                CustomButtonWidget(buttonText: 'Go To Diabetic Dashboard',
                  transparent: true,
                  isBold: false,
                  fontSize: Dimensions.fontSize14,
                  onPressed: () {
                    Get.find<AuthController>().userDataApi();
                    Get.to(const DashboardScreen(pageIndex: 1));
                  },),



              ],
            ),
          ),
        ),
      ),
    );
  }
}
