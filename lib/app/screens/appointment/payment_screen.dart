import 'dart:math';

import 'package:flutter/material.dart';
import 'package:iclinix/app/screens/appointment/components/booking_summary_widget.dart';
import 'package:iclinix/app/widget/common_widgets.dart';
import 'package:iclinix/app/widget/custom_app_bar.dart';
import 'package:iclinix/app/widget/custom_button_widget.dart';
import 'package:iclinix/app/widget/custom_textfield.dart';
import 'package:iclinix/controller/appointment_controller.dart';
import 'package:iclinix/controller/auth_controller.dart';
import 'package:iclinix/data/models/body/appointment_model.dart';
import 'package:iclinix/helper/route_helper.dart';
import 'package:iclinix/utils/dimensions.dart';
import 'package:iclinix/utils/sizeboxes.dart';
import 'package:iclinix/utils/styles.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../widget/custom_snackbar.dart';
import '../../widget/group_radio_button.dart';

class PaymentScreen extends StatelessWidget {
  final AppointmentModel appointmentModel;


  PaymentScreen({super.key, required this.appointmentModel,});

  final _referralController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppointmentController>(builder: (appointmentControl) {
      return Scaffold(
        appBar:  const CustomAppBar(
            isBackButtonExist: true,
            title: 'Payment Method',
            menuWidget: Row(
              children: [
                NotificationButton(),
              ],
            )),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                BookingSummaryWidget(
                  patientName:
                      '${appointmentModel.firstName}${appointmentModel.lastName}',
                  appointmentDate: '${appointmentModel.appointmentDate}',
                  appointmentTime: '${appointmentModel.appointmentTime}',
                  bookingFee: '500',
                ),
                sizedBoxDefault(),
                Obx(() {
                  return CustomRadioButton(
                    items: appointmentControl.paymentMethods,
                    selectedValue: appointmentControl.selectedPaymentMethod.value,
                    onChanged: (value) {
                      debugPrint('Selected Payment Method: $value');
                      if (value == 'Pay via debit/credit card/upi/NetBanking') {
                        appointmentControl.selectPaymentMethod(value!);
                      } else {
                        // Update selected payment method
                        appointmentControl.selectPaymentMethod(value!);
                      }

                    },
                  );
                }),
                sizedBoxDefault(),
                Text(
                  'Referral Code (Optional)',
                  style: openSansRegular.copyWith(
                      color: Theme.of(context).hintColor,
                      fontSize: Dimensions.fontSize14),
                ),
                sizedBox5(),
                CustomTextField(
                  controller: _referralController,
                  hintText: 'Apply Referral Code',
                ),
                // sizedBoxDefault(),
                // Text('PAY NOW',style: openSansRegular.copyWith(color: Theme.of(context).hintColor,
                //     fontSize: Dimensions.fontSize14),),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: SingleChildScrollView(
            child: CustomButtonWidget(
              buttonText: 'Confirm Booking',
              onPressed: () {
                     if(appointmentControl.selectedPaymentMethod.value == 'Pay via debit/credit card/upi/NetBanking'){
                       razorpayImplement(appointmentModel);
                       // appointmentControl.bookAppointmentApi(appointmentModel);
                     }else{
                       appointmentControl.bookAppointmentApi(appointmentModel);
                     }

              },
              fontSize: Dimensions.fontSize14,
              isBold: false,
            ),
          ),
        ),
      );
    });
  }
}

Razorpay _razorpay = Razorpay();
void razorpayImplement(AppointmentModel appointment) async {
  debugPrint('Razorpay Payment ${appointment.mobileNo}');
  try {
    _razorpay.open({
      'key': 'rzp_test_ttuVlnJolWhSyR',
      'amount': 100, //in the smallest currency sub-unit.
      'name': appointment.firstName, // Generate order_id using Orders API
      "order": {
        "id": "order_${Random().nextInt(100)}",
        "entity": 100,
        "amount_paid": 0,
        "amount_due": 0,
        "currency": "INR",
        "receipt": "Receipt #20",
        "status": "created",
        "attempts": 0,
      },
      'description': 'Demo',
      'timeout': 300, // in seconds
      'prefill': {
        'contact': appointment.mobileNo,
        'email': "yv48183@gmail.com"
      }
    });
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
            (PaymentSuccessResponse response) async {

        });
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
            (PaymentSuccessResponse response) async {

            });
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
            (PaymentSuccessResponse response) async {

            });
  } catch (e) {
    _razorpay.clear();
  }
}


