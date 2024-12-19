import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iclinix/controller/profile_controller.dart';
import '../../../controller/auth_controller.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/images.dart';
import '../../../utils/sizeboxes.dart';
import '../../../utils/styles.dart';
import '../../widget/custom_button_widget.dart';
import '../../widget/custom_dropdown_field.dart';
import '../../widget/custom_textfield.dart';

class LetsBeginScreen extends StatelessWidget {
   LetsBeginScreen({super.key});
   final _firstnameController = TextEditingController();
   final _lastNameController = TextEditingController();
   final _dateController = TextEditingController();
   final _addressController = TextEditingController();
   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColor,
      body: GetBuilder<AuthController>(builder: (authControl) {
        return  GetBuilder<ProfileController>(builder: (profileControl) {
          return  Form(
            key: _formKey,
            child:
            Stack(
              children: [
                // Background Image
                Positioned.fill(
                  child: Image.asset(
                    Images.loginScreenBG,
                    fit: BoxFit.cover,
                  ),
                ),
                // Bottom content
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min, // Ensures content is compact
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Let’s Begin',
                              style: openSansExtraBold.copyWith(
                                fontSize: Dimensions.fontSize32,
                                color: Theme.of(context).cardColor,
                              ),
                            ),
                            Text(
                              'It will take only a min.',
                              style: openSansRegular.copyWith(
                                fontSize: Dimensions.fontSize13,
                                color: Theme.of(context).cardColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      sizedBox20(),
                      Container(
                        height: Get.size.height * 0.80,
                        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                        width: Get.size.width,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(Dimensions.radius20),
                            topRight: Radius.circular(Dimensions.radius20),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Enter your Details',style: openSansBold.copyWith(
                                  fontSize: Dimensions.fontSizeDefault,
                                  color: Theme.of(context).disabledColor.withOpacity(0.50) ),),
                              Text("You'll get a verification code from us.",style: openSansRegular.copyWith(
                                  fontSize: Dimensions.fontSize13,
                                  color: Theme.of(context).disabledColor.withOpacity(0.40) ),),
                              sizedBox12(),
                              CustomTextField(
                                showTitle: true,
                                capitalization: TextCapitalization.words,
                                validation: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your First name';
                                  } else if (RegExp(r'[^\p{L}\s]', unicode: true).hasMatch(value)) {
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
                                  } else if (RegExp(r'[^\p{L}\s]', unicode: true).hasMatch(value)) {
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
                                  DateTime initialDate = authControl.selectedDate ?? DateTime(2018); // Default to 2018 if null
                                  if (initialDate.isAfter(DateTime(2018))) {
                                    initialDate = DateTime(2018); // Ensure initial date is not after 2018
                                  }

                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: initialDate,
                                    firstDate: DateTime(1940),
                                    lastDate: DateTime(2018),
                                  );

                                  if (pickedDate != null) {
                                    authControl.updateDate(pickedDate);
                                    _dateController.text = authControl.formattedDate.toString();
                                  }
                                },
                                validation: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Date of Birth is required.';
                                  } else {
                                    DateTime selectedDate = authControl.selectedDate ?? DateTime.now();
                                    DateTime today = DateTime.now();
                                    if (selectedDate.isAfter(today)) {
                                      return 'Date of Birth cannot be in the future.';
                                    }
                                    if (selectedDate.isAfter(DateTime(2018))) {
                                      return 'Date of Birth cannot be after 2018.';
                                    }
                                    return null;
                                  }
                                },
                                hintText: 'Date of Birth',
                                isCalenderIcon: true,
                              ),



                              sizedBox10(),
                              CustomDropdownField(
                                hintText: 'Gender',
                                selectedValue: authControl.selectedGender.isEmpty
                                    ? null
                                    : authControl.selectedGender,
                                options: authControl.genderOptions,
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    authControl.updateGender(newValue); // Update controller
                                  }
                                },
                                showTitle: true, // Set to true to show title
                              ),
                              // sizedBox10(),
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
                              sizedBox10(),
                              CustomDropdownField(
                                hintText: 'Do you have diabetes?',
                                selectedValue: authControl.selectedDiabetes.isEmpty
                                    ? null
                                    : authControl.selectedDiabetes,
                                options: authControl.diabetesOptions,
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    authControl.updateDiabetes(newValue);
                                    print(authControl.selectedDiabetes);
                                  }
                                },
                                showTitle: true, // Set to true to show title
                              ),
                              sizedBox10(),
                              CustomDropdownField(
                                hintText: 'Do you wear glasses?',
                                selectedValue: authControl.selectedGlasses.isEmpty
                                    ? null
                                    : authControl.selectedGlasses,
                                options: authControl.glassesOptions,
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    authControl.updateGlasses(newValue);
                                    print(authControl.selectedGlasses);
                                  }
                                },
                                showTitle: true,
                              ),
                              sizedBox10(),
                              CustomDropdownField(
                                hintText: 'Any Previous Health Issue',
                                selectedValue: authControl.selectedBp.isEmpty
                                    ? null
                                    : authControl.selectedBp,
                                options: authControl.bpOptions,
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    authControl.updateHealth(newValue);
                                    print(authControl.selectedBp);
                                  }
                                },
                                showTitle: true,
                              ),

                              sizedBox30(),
                               profileControl.isLoading ?
                                const Center(child: CircularProgressIndicator()) :
                                CustomButtonWidget(
                                  buttonText: "Continue",
                                  onPressed: () {
                                    if(_formKey.currentState!.validate()) {
                                      print('first name == ${_firstnameController.text}');
                                      print('lastNameController name == ${_lastNameController.text}');
                                      print('dateController name == ${_dateController.text}');
                                      print('diabaties name == ${authControl.selectedDiabetes == 'No' ? '0' : '1'}');
                                      print('selectedGlasses name == ${authControl.selectedGlasses == 'No' ? '0' : '1'}');
                                      print('selectedHealth name == ${authControl.selectedBp == 'No' ? '0' : '1'}');
                                      print('selectedGender name == ${authControl.selectedGender == 'Male' ? 'M' : 'F'}');
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
                          

                          
                          
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );

        });


      })




    );
  }
}
