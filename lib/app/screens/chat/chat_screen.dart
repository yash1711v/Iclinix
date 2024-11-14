import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iclinix/app/widget/common_widgets.dart';
import 'package:iclinix/app/widget/custom_app_bar.dart';
import 'package:get/get.dart';
import 'package:iclinix/controller/chat_controller.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/sizeboxes.dart';
import '../../widget/custom_button_widget.dart';
import '../../widget/custom_snackbar.dart';
import '../../widget/custom_textfield.dart';

class ChatScreen extends StatelessWidget {
   ChatScreen({super.key});
  final _replyController =  TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  GetBuilder<ChatController>(builder: (chatControl) {
      return Scaffold(
          appBar: const CustomAppBar(title: 'Chats',isBackButtonExist: true,
            menuWidget: Row(
              children: [
                NotificationButton()
              ],
            ),
          ),
          bottomNavigationBar: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      hintText: 'Enter Reply',
                      controller: _replyController,
                      inputType: TextInputType.name,
                      capitalization: TextCapitalization.words,
                    ),
                  ),
                  sizedBoxW10(),
                  GestureDetector(
                    onTap: () => chatControl.pickImage(false),
                    child:
                    Container(
                        height: 50, width: 50, clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.5, color: Theme.of(context).primaryColor.withOpacity(0.40),),
                          color: Theme.of(context).primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(Dimensions.radius15),
                        ), alignment: Alignment.center,
                        child: chatControl.pickedLogo != null ? Image.file(
                          File(chatControl.pickedLogo!.path), width: Get.size.width, height: 160, fit: BoxFit.cover,
                        ): Icon(Icons.add, size: 50, color: Theme.of(context).primaryColor)
                    ),),
                  sizedBoxW10(),
                  Container(
                      height: 50, width: 50, clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.5, color: Theme.of(context).primaryColor.withOpacity(0.40),),
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(Dimensions.radius15),
                      ),
                    child:  Icon(Icons.send,color: Theme.of(context).primaryColor,)
                  )
                  

                ],
              ),
            ),

          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Text('No Chats Yet'))
              ],
            ),
          ),
        );
    });


  }
}
