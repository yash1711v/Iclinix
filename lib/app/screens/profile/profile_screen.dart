import 'dart:io';
import 'package:iclinix/app/widget/custom_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:iclinix/app/widget/common_widgets.dart';
import 'package:iclinix/app/widget/custom_app_bar.dart';
import 'package:flutter_slide_drawer/flutter_slide_widget.dart';
import 'package:iclinix/app/widget/custom_dropdown_field.dart';
import 'package:iclinix/app/widget/custom_image_widget.dart';
import 'package:iclinix/app/widget/custom_textfield.dart';
import 'package:iclinix/controller/auth_controller.dart';
import 'package:iclinix/controller/profile_controller.dart';
import 'package:iclinix/utils/dimensions.dart';
import 'package:iclinix/utils/images.dart';
import 'package:get/get.dart';
import 'package:iclinix/utils/sizeboxes.dart';
import 'package:iclinix/utils/styles.dart';

import '../../widget/custom_button_widget.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final _firstnameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _dateController = TextEditingController();
  final _addressController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<SliderDrawerWidgetState> drawerKey = GlobalKey<SliderDrawerWidgetState>();
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<AuthController>().userDataApi();
      Get.find<ProfileController>().initializeBp();
      Get.find<ProfileController>().initializeGlasses();
      Get.find<ProfileController>().initializeDiabetes();

    });
    return SliderDrawerWidget(
      key: drawerKey,
      option: SliderDrawerOption(
        backgroundColor: Theme.of(context).primaryColor,
        sliderEffectType: SliderEffectType.Rounded,
        upDownScaleAmount: 30,
        radiusAmount: 30,
        direction: SliderDrawerDirection.LTR,
      ),
      drawer:   const CustomDrawer(),
      body: Scaffold(
          key: _scaffoldKey,
          appBar:  CustomAppBar(
            drawerButton : CustomMenuButton(tap: () {
              drawerKey.currentState!.toggleDrawer();

            }),
            title: 'My Profile',
            menuWidget: const Row(
              children: [
                NotificationButton(),
              ],
            ),
          ),
          body: GetBuilder<AuthController>(builder: (authControl) {
            return   GetBuilder<ProfileController>(builder: (profileControl) {
              if (authControl.userData != null) {
                print(Get.find<AuthController>().patientData!.bpProblem);
                _firstnameController.text =
                    authControl.userData!.firstName.toString();
                _lastNameController.text =
                    authControl.userData!.lastName.toString();
                _dateController.text = authControl.patientData!.dob.toString();
              }
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeDefault),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Stack(
                            children: [
                              Container(
                                height: 150,
                                width: 150,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 0.5,
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.40),
                                  ),
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.1),
                                ),
                                // alignment: Alignment.center,
                                child: profileControl.pickedImage != null
                                    ? Image.file(
                                  File(
                                    profileControl.pickedImage!.path,
                                  ),
                                  height: 90,
                                  width: 90,
                                  fit: BoxFit.cover,
                                )
                                    : Stack(
                                  children: [
                                    Container(
                                        height: 150,
                                        width: 150,
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.1),
                                        ),
                                        child:
                                        const CustomNetworkImageWidget(
                                          imagePadding:
                                          Dimensions.paddingSize40,
                                          height: 150,
                                          width: 150,
                                          image: '',
                                          placeholder: Images
                                              .icProfilePlaceholder,
                                          fit: BoxFit.cover,
                                        )),
                                    // Image.asset(Images.profilePlaceholder,)
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                top: 0,
                                left: 0,
                                child: InkWell(
                                  onTap: () => profileControl.pickImage(
                                      isRemove: false),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.3),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 1,
                                          color:
                                          Theme.of(context).primaryColor),
                                    ),
                                    child: Container(
                                      margin: const EdgeInsets.all(25),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2, color: Colors.white),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(Icons.camera_alt,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        sizedBox20(),
                        Text(
                          'ACCOUNT DETAILS',
                          style: openSansSemiBold.copyWith(
                              fontSize: Dimensions.fontSize14,
                              color: Theme.of(context).hintColor),
                        ),
                        sizedBox10(),
                        CustomTextField(
                          showTitle: true,
                          capitalization: TextCapitalization.words,
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your First name';
                            } else if (RegExp(r'[^\p{L}\s]', unicode: true)
                                .hasMatch(value)) {
                              return 'Full name must not contain special characters';
                            }
                            return null;
                          },
                          controller: _firstnameController,
                          hintText: 'First Name',
                        ),
                        sizedBox10(),
                        CustomTextField(
                          showTitle: true,
                          capitalization: TextCapitalization.words,
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Last name';
                            } else if (RegExp(r'[^\p{L}\s]', unicode: true)
                                .hasMatch(value)) {
                              return 'Full name must not contain special characters';
                            }
                            return null;
                          },
                          controller: _lastNameController,
                          hintText: 'Last Name',
                        ),
                        sizedBox10(),
                        CustomTextField(
                          showTitle: true,
                          controller: _dateController,
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: profileControl.selectedDate ??
                                  DateTime.now(),
                              firstDate: DateTime(1940),
                              lastDate: DateTime(2018),
                            );
                            if (pickedDate != null) {
                              profileControl.updateDate(pickedDate);
                              profileControl.formattedDate.toString();
                              print(profileControl.formattedDate.toString());
                              _dateController.text = profileControl.formattedDate.toString();
                            }
                          },
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Date of Birth is required.';
                            } else {
                              DateTime selectedDate =
                                  profileControl.selectedDate ??
                                      DateTime.now();
                              DateTime today = DateTime.now();
                              if (selectedDate.isAfter(today)) {
                                return 'Date of Birth cannot be in the future.';
                              }
                              return null;
                            }
                          },
                          hintText: 'Date of Birth',
                          isCalenderIcon: true,
                        ),
                        sizedBox10(),
                        // CustomTextField(
                        //   showTitle: true,
                        //   maxLines: 3,
                        //   validation: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'Please enter your Address';
                        //     }
                        //     return null;
                        //   },
                        //   controller: _addressController,
                        //   hintText: 'Address',
                        // ),
                        // sizedBox20(),
                        // Text(
                        //   'ACCOUNT DETAILS',
                        //   style: openSansSemiBold.copyWith(
                        //       fontSize: Dimensions.fontSize14,
                        //       color: Theme.of(context).hintColor),
                        // ),
                        // sizedBox10(),
                        //
                        // CustomDropdownField(
                        //   hintText: 'Gender',
                        //   selectedValue: profileControl.selectedGender.isEmpty
                        //       ? null
                        //       : profileControl.selectedGender,
                        //   options: profileControl.genderOptions,
                        //   onChanged: (String? newValue) {
                        //     if (newValue != null) {
                        //       profileControl.updateGender(
                        //           newValue); // Update controller
                        //     }
                        //   },
                        //   showTitle: true, // Set to true to show title
                        // ),
                        // sizedBox10(),
                        // CustomDropdownField(
                        //   hintText: 'Do you have diabetes?',
                        //   selectedValue:
                        //   profileControl.selectedDiabetes.isEmpty
                        //       ? null
                        //       : profileControl.selectedDiabetes,
                        //   options: profileControl.diabetesOptions,
                        //   onChanged: (String? newValue) {
                        //     if (newValue != null) {
                        //       profileControl.updateDiabetes(newValue);
                        //       print(profileControl.selectedDiabetes);
                        //     }
                        //   },
                        //   showTitle: true, // Set to true to show title
                        // ),
                        // sizedBox10(),
                        // CustomDropdownField(
                        //   hintText: 'Do you wear glasses?',
                        //   selectedValue:
                        //   profileControl.selectedGlasses.isEmpty
                        //       ? null
                        //       : profileControl.selectedGlasses,
                        //   options: profileControl.glassesOptions,
                        //   onChanged: (String? newValue) {
                        //     if (newValue != null) {
                        //       profileControl.updateGlasses(newValue);
                        //     }
                        //   },
                        //   showTitle: true,
                        // ),
                        // sizedBox10(),
                        // CustomDropdownField(
                        //   hintText: 'Any Previous Health Issue',
                        //   selectedValue: profileControl.selectedBp,
                        //   // Use selectedBp directly
                        //   options: profileControl.bpOptions,
                        //   onChanged: (String? newValue) {
                        //     if (newValue != null) {
                        //       profileControl.updateBp(newValue);
                        //       print(profileControl.selectedBp);
                        //     }
                        //   },
                        //   showTitle: true,
                        // ),
                        // CustomDropdownField(
                        //   hintText: 'Any Previous Health Issue',
                        //   selectedValue: profileControl.selectedBp.isEmpty
                        //       ? null
                        //       : profileControl.selectedBp,
                        //   options: profileControl.bpOptions,
                        //   onChanged: (String? newValue) {
                        //     if (newValue != null) {
                        //       profileControl.updateBp(newValue);
                        //       print(profileControl.selectedBp);
                        //     }
                        //   },
                        //   showTitle: true,
                        // ),
                        sizedBox30(),
                        profileControl.isProfileLoading ?
                            const Center(child: CircularProgressIndicator()) :
                        CustomButtonWidget(
                          buttonText: "Update",
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              print(
                                  'first name == ${_firstnameController.text}');
                              print(
                                  'lastNameController name == ${_lastNameController.text}');
                              print(
                                  'dateController name == ${_dateController.text}');
                              print(
                                  'diabaties name == ${profileControl.getDiabetesStatus()}');
                              print(
                                  'selectedGlasses name == ${profileControl.getGlassesStatus()}');
                              print(
                                  'selectedHealth name == ${profileControl.getBpStatus()}');
                              print(
                                  'selectedGender name == ${profileControl.getGenderStatus()}');
                              profileControl.updateProfileApi(
                                  _firstnameController.text,
                                  _lastNameController.text,
                                  _dateController.text,
                                  authControl.selectedDiabetes == 'No' ? '0' : '1',
                                  authControl.selectedBp == 'No' ? '0' : '1',
                                  authControl.selectedGlasses == 'No' ? '0' : '1',
                                  authControl.selectedGender == 'Male' ? 'M' : 'F'
                              );
                            }
                          },
                        ),
                        sizedBox100(),
                        sizedBox100(),
                      ],
                    ),
                  ),
                ),
              );
            });
          })
          ));
  }
}
