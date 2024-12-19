import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iclinix/utils/dimensions.dart';

class DecoratedAddButton extends StatelessWidget {
  final Function() tap;
  final Color? color;
  const DecoratedAddButton({super.key, required this.tap, this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Container(
        padding: const EdgeInsets.all(Dimensions.paddingSize8),
        decoration: BoxDecoration(
          color :Theme.of(context).primaryColor.withOpacity(0.10),
          borderRadius: BorderRadius.circular(Dimensions.paddingSize4,
          )
        ),
        child: Icon(Icons.add,color: color ?? Theme.of(context).primaryColor,),
      ),
    );
  }
}
