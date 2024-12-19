import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iclinix/utils/sizeboxes.dart';
import 'package:iclinix/utils/styles.dart';

import '../../utils/dimensions.dart';


class EmptyDataWidget extends StatelessWidget {
  final String image;
  final Color? fontColor;
  final String text;
  const EmptyDataWidget({super.key,required this.image, this.fontColor, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image,height: 120,),
        sizedBox10(),
        Text(text,style: openSansRegular.copyWith(fontSize: Dimensions.fontSize14,color:fontColor?? Theme.of(context).cardColor),)
      ],
    );
  }
}
