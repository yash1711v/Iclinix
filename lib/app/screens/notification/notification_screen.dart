import 'package:flutter/material.dart';
import 'package:iclinix/app/widget/custom_app_bar.dart';
import 'package:iclinix/app/widget/empty_data_widget.dart';
import 'package:iclinix/utils/images.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Notifications',isBackButtonExist: true,),
      body: Center(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: EmptyDataWidget(image: Images.icEmptyDataHolder, text: 'No Notifications Yet',
            fontColor: Theme.of(context).disabledColor,))
          ],
        ),
      ),
    );
  }
}
