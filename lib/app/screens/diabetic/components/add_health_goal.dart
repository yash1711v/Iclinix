import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iclinix/app/widget/custom_button_widget.dart';
import 'package:iclinix/app/widget/custom_card_container.dart';
import 'package:iclinix/app/widget/custom_containers.dart';
import 'package:iclinix/app/widget/custom_textfield.dart';
import 'package:iclinix/app/widget/decorated_add_button.dart';
import 'package:iclinix/controller/diabetic_controller.dart';
import 'package:iclinix/utils/dimensions.dart';
import 'package:iclinix/utils/sizeboxes.dart';
import 'package:iclinix/utils/styles.dart';
import 'package:get/get.dart';

import '../../../../data/models/response/health_goal_model.dart';
import '../../../widget/custom_dropdown_field.dart';
import 'health_goal_detail_dialog.dart';

class AddHealthGoal extends StatelessWidget {
  const AddHealthGoal({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<DiabeticController>().getHealthGoalApi();
    });
    return GetBuilder<DiabeticController>(builder: (controller) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Add Health Goal',
                style: openSansMedium.copyWith(
                    fontSize: Dimensions.fontSizeDefault),
              ),
              DecoratedAddButton(
                tap: () {
                  Get.dialog(AddHealthGoalDialog());
                },
              ),
            ],
          ),
          sizedBox20(),
          CustomDecoratedContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Goal',
                  style: openSansRegular.copyWith(
                      color: Theme.of(context).primaryColor),
                ),
                sizedBoxDefault(),
                CustomDropdownField(
                  hintText: 'Goal',
                  selectedValue: controller.healthGoal?.isEmpty ?? true
                      ? null
                      : controller.healthGoal,
                  options: controller.healthGoalData
                      ?.map((goal) => goal.title)
                      .toSet() // Remove duplicates by converting to a Set
                      .toList() ??
                      [],
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      // Update the health goal
                      controller.updateHealthGoal(newValue);
                      print(controller.healthGoal);

                      // Find the selected goal object by matching the title
                      final selectedGoal = controller.healthGoalData?.firstWhere(
                            (goal) => goal.title == newValue,
                        orElse: () => MedicalRecord(title: '', description: '', ), // Return a default MedicalRecord
                      );

                      // Open dialog only if a valid goal is found
                      if (selectedGoal!.title.isNotEmpty && selectedGoal.description.isNotEmpty) {
                        Get.dialog(
                          HealthGoalDetailDialog(
                            title: selectedGoal.title,
                            description: selectedGoal.description,
                          ),
                        );
                      }
                    }
                  },
                  showTitle: false,
                ),


              ],
            ),
          )
        ],
      );
    });
  }
}

class AddHealthGoalDialog extends StatelessWidget {
  AddHealthGoalDialog({super.key});

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSize10),
        child: GetBuilder<DiabeticController>(builder: (controller) {
          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeDefault,
                ),
                child: Column(
                  children: [
                    Container(
                      width: Get.size.width,
                      decoration: BoxDecoration(color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(Dimensions.radius5)
                      ),
                      padding:
                          const EdgeInsets.all(Dimensions.paddingSizeDefault),

                      child: Row(
                        children: [
                          Text(
                            'Health Goal',
                            style: openSansMedium.copyWith(
                                fontSize: Dimensions.fontSizeDefault,
                                color: Theme.of(context).cardColor),
                          ),
                          // DecoratedAddButton(tap: () {  },
                          // color: Theme.of(context).cardColor,)
                        ],
                      ),
                    ),
                    sizedBox20(),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          CustomTextField(
                            hintText: 'Goal Title',
                            controller: titleController,
                            validation: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Goal Title';
                              }
                              return null;
                            },
                          ),
                          sizedBoxDefault(),
                          CustomTextField(
                            maxLines: 4,
                            hintText: 'Goal Description',
                            controller: descriptionController,
                            validation: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Goal Description';
                              }
                              return null;
                            },
                          ),
                          sizedBox20(),
                          Row(
                            children: [
                              Flexible(
                                child: CustomButtonWidget(
                                  buttonText: 'Cancel',
                                  transparent: true,
                                  isBold: false,
                                  fontSize: Dimensions.fontSize14,
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                              ),
                              sizedBoxW10(),
                              Flexible(
                                child: CustomButtonWidget(
                                  buttonText: 'Save',
                                  isBold: false,
                                  fontSize: Dimensions.fontSize14,
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      controller.addHealthGoalApi(
                                          titleController.text,
                                          descriptionController.text);

                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          // CustomButtonWidget(
                          //   buttonText: 'Add',
                          //   onPressed: () {
                          //     if (_formKey.currentState!.validate()) {
                          //       controller.addHealthGoalApi(
                          //           titleController.text,
                          //           descriptionController.text);
                          //     }
                          //   },
                          //   isBold: false,
                          //   fontSize: Dimensions.fontSize14,
                          // )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
