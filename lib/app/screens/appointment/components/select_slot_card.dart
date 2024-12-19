import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iclinix/app/widget/custom_image_widget.dart';
import 'package:iclinix/utils/dimensions.dart';
import 'package:iclinix/utils/sizeboxes.dart';
import 'package:iclinix/utils/styles.dart';
import 'package:iclinix/utils/themes/light_theme.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../data/models/response/clinic_model.dart';
class SelectSlotCard extends StatelessWidget {
  final String img;
  final String branchName;
  final String branchContactNo;
  const SelectSlotCard({super.key, required this.img, required this.branchName, required this.branchContactNo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomNetworkImageWidget(
            height: 80,width: 80,
            image: img,),
          // Image.asset('assets/images/img_select_slot_demo.png',height: 80,width: 80,),
          sizedBoxW10(),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(branchName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: openSansBold.copyWith(fontSize: Dimensions.fontSize14),),
              sizedBox5(),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Branch Contact: ",
                      style: openSansRegular.copyWith(
                          fontSize: Dimensions.fontSize12,
                          color: Theme.of(context).primaryColor), // Different color for "resend"
                    ),
                    TextSpan(
                      text: branchContactNo,
                      style: openSansRegular.copyWith(
                          fontSize: Dimensions.fontSize13,
                          color: Theme.of(context)
                              .hintColor), // Different color for "resend"
                    ),
                  ],
                ),
              ),
              // RichText(
              //   text: TextSpan(
              //     children: [
              //       TextSpan(
              //         text: "Open: ",
              //         style: openSansRegular.copyWith(
              //             fontSize: Dimensions.fontSize12,
              //             color: greenColor), // Different color for "resend"
              //       ),
              //       TextSpan(
              //         text: "10AM-7PM",
              //         style: openSansRegular.copyWith(
              //             fontSize: Dimensions.fontSize13,
              //             color: Theme.of(context)
              //                 .hintColor), // Different color for "resend"
              //       ),
              //     ],
              //   ),
              // ),
              Row(
                children: [
                  RatingBar.builder(
                    itemSize:  Dimensions.fontSize14,
                    initialRating: 4,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: Dimensions.fontSize14,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  Text(
                    ' 4.8',
                    style: openSansRegular.copyWith(
                        fontSize: Dimensions.fontSize14,
                        color: Theme.of(context).hintColor),
                  ),
                ],
              ),
            ],
          ))
        ],
      ),
    );
  }
}
