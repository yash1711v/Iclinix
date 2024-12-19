import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iclinix/app/widget/custom_containers.dart';
import 'package:iclinix/utils/dimensions.dart';
import 'package:iclinix/utils/sizeboxes.dart';
import 'package:iclinix/utils/styles.dart';

class CurrentMedicationComponent extends StatelessWidget {
  const CurrentMedicationComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomDecoratedContainer(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Diet Plan',style: openSansBold.copyWith(
            color: Theme.of(context).primaryColor
        ),),
        const Divider(),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Medicine',style: openSansSemiBold.copyWith(
              fontSize: Dimensions.fontSize14,color: Theme.of(context).disabledColor
            ),),
            Text('Time',style: openSansSemiBold.copyWith(
                fontSize: Dimensions.fontSize14,color: Theme.of(context).disabledColor
            ),)
          ],
        ),
        ListView.separated(
          itemCount: 3,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (_,i) {
          return  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Lorem ipsum dolor',style: openSansRegular.copyWith(
                  fontSize: Dimensions.fontSize14,color: Theme.of(context).disabledColor.withOpacity(0.70)
              ),),
              Text('Morning',style: openSansRegular.copyWith(
                  fontSize: Dimensions.fontSize14, color: Theme.of(context).disabledColor.withOpacity(0.70)
              ),)
            ],
          );
        }, separatorBuilder: (BuildContext context, int index) => sizedBox10(),)


      ],
    ));
  }
}
