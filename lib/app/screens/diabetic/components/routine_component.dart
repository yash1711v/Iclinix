import 'package:flutter/material.dart';
import 'package:iclinix/app/widget/custom_app_bar.dart';
import 'package:iclinix/app/widget/custom_containers.dart';
import 'package:iclinix/controller/diabetic_controller.dart';
import 'package:iclinix/utils/dimensions.dart';
import 'package:iclinix/utils/images.dart';
import 'package:iclinix/utils/sizeboxes.dart';
import 'package:iclinix/utils/styles.dart';
import 'package:iclinix/utils/themes/light_theme.dart';
import 'package:get/get.dart';
class RoutineComponent extends StatelessWidget {
  const RoutineComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DiabeticController>(builder: (controller) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Text('Today’s Blood Sugar Parameters',
            //   style: openSansSemiBold,),
            sizedBoxDefault(),
            CustomDecoratedContainer(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text('Diet Plan',style: openSansBold.copyWith(
                              color: Theme.of(context).primaryColor
                          ),),
                        ),
                        TextButton(
                          onPressed: () {  },
                          child: Text('Download',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: openSansBold.copyWith(fontSize: Dimensions.fontSize14,
                                color: Colors.redAccent),),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        Image.asset(Images.icPdfLogo,height: Dimensions.paddingSize40,
                          width: Dimensions.paddingSize40,),
                        Text('Lorem ipsum dolor sit amet, consec',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: openSansRegular.copyWith(fontSize: Dimensions.fontSize14,
                              color: Theme.of(context).disabledColor),)
                      ],
                    )

                  ],
                )),


          ],
        );
    });



  }
}
