import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iclinix/app/widget/custom_containers.dart';
import 'package:iclinix/utils/dimensions.dart';
import 'package:iclinix/utils/sizeboxes.dart';
import 'package:iclinix/utils/styles.dart';
import 'package:iclinix/utils/themes/light_theme.dart';

class BookingSummaryWidget extends StatelessWidget {
  final String patientName;
  final String appointmentDate;
  final String appointmentTime;
  final String bookingFee;
  const BookingSummaryWidget({super.key, required this.patientName, required this.appointmentDate, required this.appointmentTime, required this.bookingFee});

  @override
  Widget build(BuildContext context) {
    return CustomDecoratedContainer(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Booking Summary',style: openSansMedium.copyWith(fontSize: Dimensions.fontSizeDefault,
          color: Theme.of(context).primaryColor),),
          // sizedBox10(),
          // buildRow(context,'Patient Name:',patientName),
          sizedBox10(),
          buildRow(context,'Appointment Date:',appointmentDate),
          sizedBox10(),
          buildRow(context,'Appointment Time:',appointmentTime),
          sizedBox10(),
          buildRow(context,'Booking Fee:','₹ $bookingFee',color:Theme.of(context).primaryColor),
          
        ],
      ),
    );
  }

  Row buildRow(BuildContext context, String title, String data, {Color? color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: openSansRegular.copyWith(
            fontSize: Dimensions.fontSize14,
            color: Theme.of(context).disabledColor.withOpacity(0.70),
          ),
        ),
        sizedBoxW10(),
        Flexible(
          child: Text(
            data,
            style: openSansMedium.copyWith(
              fontSize: Dimensions.fontSize15,
              color: color ?? Theme.of(context).disabledColor
            ),
          ),
        ),
      ],
    );
  }

}
