import 'package:flutter/material.dart';
import 'package:iclinix/app/widget/custom_button_widget.dart';
import 'package:iclinix/app/widget/custom_containers.dart';
import 'package:iclinix/helper/date_converter.dart';
import 'package:iclinix/helper/route_helper.dart';
import 'package:iclinix/utils/dimensions.dart';
import 'package:iclinix/utils/images.dart';
import 'package:iclinix/utils/sizeboxes.dart';
import 'package:iclinix/utils/styles.dart';
import 'package:iclinix/utils/themes/light_theme.dart';
import 'package:get/get.dart';
class BookingSuccessfulScreen extends StatelessWidget {
  final String? date;
  final String? time;
  const BookingSuccessfulScreen({super.key, this.date, this.time});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Images.icBookingSuccessful,height: 160,),
              sizedBox10(),
              Text('Booking Successful!',style: openSansBold.copyWith(color: blueColor,
              fontSize: Dimensions.fontSize20),),
              sizedBox5(),
              Text('You have successfully booked your appointment at',
                textAlign: TextAlign.center,
                style: openSansRegular.copyWith(
                  fontSize: Dimensions.fontSize12,
              color: Theme.of(context).disabledColor.withOpacity(0.70)),),
              sizedBoxDefault(),
              Text('IClinix Advanced Eye And Retina Centre Lajpat Nagar',
                textAlign: TextAlign.center,
                style: openSansRegular.copyWith(
                  fontSize: Dimensions.fontSizeDefault,
                  color: Theme.of(context).disabledColor),),
              sizedBoxDefault(),
              Row(
                children: [
                  Expanded(
                    child: CustomDecoratedContainer(
                        child: Column(children: [
                          Text('On',style: openSansRegular.copyWith(
                            fontSize: Dimensions.fontSize14,
                            color: Theme.of(context).disabledColor.withOpacity(0.70)),),
                          Text(AppointmentDateTimeConverter.formatDate(date!),
                            textAlign: TextAlign.center,
                            style: openSansSemiBold.copyWith(
                                fontSize: Dimensions.fontSize14,
                                color: Theme.of(context).primaryColor),),



                    ],)),
                  ),
                  sizedBoxW10(),
                  Expanded(
                    child: CustomDecoratedContainer(
                        child: Column(children: [
                          Text('At',style: openSansRegular.copyWith(
                              fontSize: Dimensions.fontSize14,
                              color: Theme.of(context).disabledColor.withOpacity(0.70)),),
                          Text('$time',
                            textAlign: TextAlign.center,
                            style: openSansSemiBold.copyWith(
                                fontSize: Dimensions.fontSize14,
                                color: Theme.of(context).primaryColor),),



                        ],)),
                  ),
                ],
              ),
              sizedBox40(),
              CustomButtonWidget(buttonText: 'Go Home',
              transparent: true,
              isBold: false,
              fontSize: Dimensions.fontSize14,
              onPressed: () {
                Get.toNamed(RouteHelper.getDashboardRoute());
              },),



            ],
          ),
        ),
      ),
    );
  }
}
