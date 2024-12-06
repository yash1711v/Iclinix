import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:iclinix/app/widget/common_widgets.dart';
import 'package:iclinix/app/widget/custom_app_bar.dart';
import 'package:get/get.dart';
import 'package:iclinix/controller/chat_controller.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/sizeboxes.dart';
import '../../widget/custom_button_widget.dart';
import '../../widget/custom_dropdown_field.dart';
import '../../widget/custom_snackbar.dart';
import '../../widget/custom_textfield.dart';

class ChatScreen extends StatelessWidget {
   ChatScreen({super.key});
  final subjectController =  TextEditingController();
  final description =  TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  GetBuilder<ChatController>(builder: (chatControl) {
      return Scaffold(
        body: Column(
          children: [
            CustomAppBar(
              title: 'Send Message ',
              isBackButtonExist: true,
              menuWidget: const Row(
                children: [
                  NotificationButton(),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: CustomDropdownField(
                      selectedValue: chatControl.type == 1 ? "Question" : "Problem",
                      hintText: 'Select Type',
                      options: ["Question", "Problem"],
                      onChanged: (String? newValue) {
                        chatControl.setType(newValue == "Question" ? 1 : 2);
                      },
                      showTitle: true, // Set to true to show title
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: subjectController,
                      showTitle: true,
                      hintText: 'Subject',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      maxLines: 3,
                      controller: description,
                      showTitle: true,
                      hintText: 'Description',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Row(
              children: [
                Expanded(
                  child: CustomButtonWidget(buttonText: "Send", onPressed: () {
                    if (subjectController.text.isEmpty) {
                      showCustomSnackBar('Please enter subject');
                    } else if (description.text.isEmpty) {
                      showCustomSnackBar('Please enter subject');
                    } else {
                      chatControl.sendMessage(chatControl.type, subjectController.text, description.text);
                    }
                  }),
                ),
              ],
            ),
          ),
        ),
      );
    });


  }
}
