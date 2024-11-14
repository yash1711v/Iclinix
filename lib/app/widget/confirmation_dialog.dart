
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iclinix/utils/styles.dart';




import '../../utils/dimensions.dart';
import 'custom_button_widget.dart';


class ConfirmationDialog extends StatelessWidget {
  final String icon;
  final String? title;
  final String description;
  final String? adminText;
  final Function onYesPressed;
  final Function? onNoPressed;
  final Color? iconColor;
  final bool isLogOut;
  const ConfirmationDialog({Key? key,
    required this.icon, this.title, required this.description, this.adminText, required this.onYesPressed,
    this.onNoPressed, this.isLogOut = false,  this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radius10)),
      insetPadding: const EdgeInsets.all(30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: SizedBox(width: 500, child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSize20),
        child: Column(mainAxisSize: MainAxisSize.min, children: [

          Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSize20),
            child: Image.asset(icon, width: 50, height: 50,
              color: iconColor,),
          ),

          title != null ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSize20),
            child: Text(
              title!, textAlign: TextAlign.center,
              style: openSansMedium.copyWith(fontSize: Dimensions.fontSize20, color: Colors.red),
            ),
          ) : const SizedBox(),

          Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSize20),
            child: Text(description, style: openSansMedium.copyWith(fontSize: Dimensions.fontSize15), textAlign: TextAlign.center),
          ),

          adminText != null && adminText!.isNotEmpty ? Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSize20),
            child: Text('[$adminText]', style: openSansMedium.copyWith(fontSize: Dimensions.fontSize15), textAlign: TextAlign.center),
          ) : const SizedBox(),
          const SizedBox(height: Dimensions.paddingSize20),

          /* GetBuilder<DeliveryManController>(builder: (dmController) {
            return GetBuilder<RestaurantController>(builder: (restController) {
              return GetBuilder<CampaignController>(builder: (campaignController) {
                return GetBuilder<AuthController>(builder: (authController) {
                  return GetBuilder<CouponController>(builder: (couponController) {
                    return GetBuilder<OrderController>(builder: (orderController) {
                      return (couponController.isLoading || authController.isLoading || orderController.isLoading || campaignController.isLoading || restController.isLoading
                          || dmController.isLoading) ? const Center(child: CircularProgressIndicator()) :*/ Row(children: [

            Expanded(child: TextButton(
              onPressed: () => isLogOut ? onYesPressed() : onNoPressed != null ? onNoPressed!() : Get.back(),
              style: TextButton.styleFrom(
                backgroundColor: Colors.redAccent, minimumSize: const Size(1170, 40), padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radius10)),
              ),
              child: Text(
                isLogOut ? 'Yes' : 'No', textAlign: TextAlign.center,
                style: openSansBold.copyWith(color: Theme.of(context).cardColor),
              ),
            )),
            const SizedBox(width: Dimensions.paddingSize20),

            Expanded(child: CustomButtonWidget(
              buttonText: isLogOut ? 'No' : 'Yes',
              onPressed: () => isLogOut ? Get.back() : onYesPressed(),
              height: 40,
            )),

          ]),
          /* });
                  }
                  );
                }
                );
              });
            });
          }),*/

        ]),
      )),
    );
  }
}