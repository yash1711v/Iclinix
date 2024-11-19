import 'package:flutter/material.dart';
import 'package:iclinix/utils/dimensions.dart';
import 'package:iclinix/utils/sizeboxes.dart';
import 'package:iclinix/utils/styles.dart';
import 'package:get/get.dart';
class HealthGoalDetailDialog extends StatelessWidget {
  final String title;
  final String description;
  const HealthGoalDetailDialog({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSize10),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSize10),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: Get.size.width,
                  decoration: BoxDecoration(color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(Dimensions.radius5)
                  ),
                  padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Text(
                    title,
                    style: openSansMedium.copyWith(
                        fontSize: Dimensions.fontSizeDefault,
                        color: Theme.of(context).cardColor),
                  ),
                ),
                sizedBox20(),
                Text("Description",style: openSansSemiBold.copyWith(fontSize: Dimensions.paddingSizeDefault),),
                sizedBox10(),
                Text(description,style: openSansRegular.copyWith(fontSize: Dimensions.paddingSizeDefault,
                color: Theme.of(context).disabledColor.withOpacity(0.70)),),
                sizedBox20(),

              ],
            ),
          ),
        )
    );
  }
}
