import 'package:flutter/material.dart';
import 'package:iclinix/app/widget/custom_button_widget.dart';
import 'package:iclinix/app/widget/custom_containers.dart';
import 'package:iclinix/app/widget/empty_data_widget.dart';
import 'package:iclinix/controller/appointment_controller.dart';
import 'package:iclinix/data/models/response/diabetic_dashboard_detail_model.dart';
import 'package:iclinix/utils/dimensions.dart';
import 'package:iclinix/utils/images.dart';
import 'package:iclinix/utils/sizeboxes.dart';
import 'package:iclinix/utils/styles.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../../../data/models/response/plans_model.dart';
import '../plans_details_screen.dart';

class DiabeticEyeCarePlansComponent extends StatefulWidget {
  final bool? isPlanRenewing;
  final Function(PlanModel)? onPlanSelected;

  const DiabeticEyeCarePlansComponent(
      {super.key, this.isPlanRenewing = false, this.onPlanSelected});

  @override
  State<DiabeticEyeCarePlansComponent> createState() =>
      _DiabeticEyeCarePlansComponentState();
}

class _DiabeticEyeCarePlansComponentState
    extends State<DiabeticEyeCarePlansComponent> {
  List<int> selectedList = [];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppointmentController>(builder: (appointmentControl) {
      final dataList = appointmentControl.planList;
      final isListEmpty = dataList == null || dataList.isEmpty;
      final isLoading = appointmentControl.isPlansLoading;
      return isListEmpty && !isLoading
          ? Padding(
              padding: const EdgeInsets.only(top: Dimensions.paddingSize100),
              child: Center(
                  child: EmptyDataWidget(
                text: 'No Plans Available',
                image: Images.icEmptyDataHolder,
                fontColor: Theme.of(context).disabledColor,
              )),
            )
          : isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (widget.isPlanRenewing ?? false)
                          ? "Select Plans"
                          : 'Diabetic Eye Care Plans',
                      style: openSansBold.copyWith(
                        fontSize: Dimensions.fontSizeDefault,
                      ),
                    ),
                    sizedBox10(),
                    (widget.isPlanRenewing ?? false)
                        ? ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: dataList!.length,
                            shrinkWrap: true,
                            itemBuilder: (_, j) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedList.clear();
                                    if (selectedList.contains(j)) {
                                      selectedList.remove(j);
                                      widget.onPlanSelected!(PlanModel(
                                          planId: 0,
                                          planName: "",
                                          price: 0,
                                          discount: 0,
                                          sellingPrice: 0,
                                          discountType: 0,
                                          duration: 0,
                                          sortDesc: "",
                                          description: "",
                                          status: 0,
                                          features: [],));
                                    } else {
                                      selectedList.add(j);
                                      widget.onPlanSelected!(dataList[j]);
                                    }
                                  });
                                },
                                child: Container(
                                    padding: const EdgeInsets.all(
                                        Dimensions.paddingSizeDefault),
                                    decoration: BoxDecoration(
                                      color: selectedList.contains(j)
                                          ? Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.15)
                                          : Colors.grey.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: selectedList.contains(j)
                                              ? Theme.of(context).primaryColor
                                              : Theme.of(context).cardColor),
                                      // boxShadow: selectedList.contains(j)?[]:[
                                      //   BoxShadow(
                                      //     color: Colors.black.withOpacity(0.1),
                                      //     spreadRadius: 1,
                                      //     blurRadius: 5,
                                      //     offset: const Offset(0, 3), // changes position of shadow
                                      //   ),
                                      // ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          dataList[j].planName,
                                          style: openSansRegular.copyWith(
                                              fontSize: Dimensions.fontSize20,
                                              color: selectedList.contains(j)
                                                  ? Theme.of(context)
                                                      .primaryColor
                                                  : Theme.of(context)
                                                      .hintColor),
                                        ),
                                        sizedBox10(),
                                        HtmlWidget(
                                          dataList[j].sortDesc,
                                          textStyle: openSansRegular.copyWith(
                                            fontSize: Dimensions.fontSize12,
                                            fontWeight: FontWeight.w100,
                                            color: selectedList.contains(j)
                                                ? Theme.of(context).primaryColor
                                                : Theme.of(context).hintColor,
                                          ),
                                        ),
                                        sizedBox10(),
                                        Text(
                                          '₹ ${dataList[j].sellingPrice.toInt()}',
                                          style: openSansSemiBold.copyWith(
                                              fontSize: Dimensions.fontSize20,
                                              color: selectedList.contains(j)
                                                  ? Theme.of(context)
                                                      .primaryColor
                                                  : Theme.of(context)
                                                      .hintColor),
                                        ),
                                        // Text(
                                        //   dataList[j].description,
                                        //   maxLines: 4,
                                        //   style: openSansRegular.copyWith(
                                        //       fontSize: Dimensions.fontSize20,
                                        //       color: Theme.of(context).primaryColor),
                                        // ),
                                        // Text(
                                        //   "Whats's Included In Your Plan",
                                        //   style: openSansSemiBold.copyWith(
                                        //       fontSize: Dimensions.fontSize13,
                                        //       color: Theme.of(context).disabledColor),
                                        // ),
                                        // ListView.builder(
                                        //   itemCount: dataList[j].features.length,
                                        //   physics: const NeverScrollableScrollPhysics(),
                                        //   padding: EdgeInsets.zero,
                                        //   shrinkWrap: true,
                                        //   itemBuilder: (_, i) {
                                        //     print('print sort descrption ${dataList[i].sortDesc}');
                                        //     return Column(
                                        //       children: [
                                        //         Row(
                                        //           crossAxisAlignment: CrossAxisAlignment.start, // Align bullet and text
                                        //           children: [
                                        //             Text(
                                        //               '• ', // Bullet point as a text character
                                        //               style: openSansRegular.copyWith(
                                        //                 fontSize: Dimensions.fontSize12,
                                        //                 color: Theme.of(context).primaryColor,
                                        //               ),
                                        //             ),
                                        //             Expanded(
                                        //               child: Text(
                                        //                 dataList[j].features[i].featureName,
                                        //                 style: openSansRegular.copyWith(
                                        //                   fontSize: Dimensions.fontSize12,
                                        //                   color: Theme.of(context).primaryColor,
                                        //                 ),
                                        //               ),
                                        //             ),
                                        //           ],
                                        //         ),
                                        //         HtmlWidget(dataList[j].sortDesc,textStyle: openSansRegular.copyWith(
                                        //           fontSize: Dimensions.fontSize12,
                                        //           fontWeight: FontWeight.w100,
                                        //           color: Theme.of(context).disabledColor,
                                        //         ),),
                                        //       ],
                                        //     );
                                        //   },
                                        // ),

                                        // sizedBoxDefault(),
                                        // CustomButtonWidget(
                                        //   color: selectedList.contains(j)
                                        //       ? Colors.grey
                                        //       : Theme.of(context).cardColor,
                                        //   height: Dimensions.fontSize40,
                                        //   buttonText: selectedList.contains(j)
                                        //       ? "Selected"
                                        //       : 'Select',
                                        //   isBold: false,
                                        //   transparent: true,
                                        //   onPressed: () {
                                        //     setState(() {
                                        //       if (selectedList.contains(j)) {
                                        //         selectedList.remove(j);
                                        //       } else {
                                        //         selectedList.add(j);
                                        //       }
                                        //       widget.onPlanSelected!(dataList[j]);
                                        //     });
                                        //     // Get.to(
                                        //     //     PlansDetailsScreen(planModel: dataList[j]));
                                        //   },
                                        // ),
                                      ],
                                    )),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    sizedBoxDefault(),
                          )
                        : ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: dataList!.length,
                            shrinkWrap: true,
                            itemBuilder: (_, j) {
                              return CustomDecoratedContainer(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    dataList[j].planName,
                                    style: openSansRegular.copyWith(
                                        fontSize: Dimensions.fontSize20,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  sizedBox10(),
                                  HtmlWidget(
                                    dataList[j].sortDesc,
                                    textStyle: openSansRegular.copyWith(
                                      fontSize: Dimensions.fontSize12,
                                      fontWeight: FontWeight.w100,
                                      color: Theme.of(context).disabledColor,
                                    ),
                                  ),
                                  sizedBox10(),
                                  Text(
                                    '₹ ${dataList[j].sellingPrice.toInt()}',
                                    style: openSansSemiBold.copyWith(
                                        fontSize: Dimensions.fontSize20,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  // Text(
                                  //   dataList[j].description,
                                  //   maxLines: 4,
                                  //   style: openSansRegular.copyWith(
                                  //       fontSize: Dimensions.fontSize20,
                                  //       color: Theme.of(context).primaryColor),
                                  // ),
                                  // Text(
                                  //   "Whats's Included In Your Plan",
                                  //   style: openSansSemiBold.copyWith(
                                  //       fontSize: Dimensions.fontSize13,
                                  //       color: Theme.of(context).disabledColor),
                                  // ),
                                  // ListView.builder(
                                  //   itemCount: dataList[j].features.length,
                                  //   physics: const NeverScrollableScrollPhysics(),
                                  //   padding: EdgeInsets.zero,
                                  //   shrinkWrap: true,
                                  //   itemBuilder: (_, i) {
                                  //     print('print sort descrption ${dataList[i].sortDesc}');
                                  //     return Column(
                                  //       children: [
                                  //         Row(
                                  //           crossAxisAlignment: CrossAxisAlignment.start, // Align bullet and text
                                  //           children: [
                                  //             Text(
                                  //               '• ', // Bullet point as a text character
                                  //               style: openSansRegular.copyWith(
                                  //                 fontSize: Dimensions.fontSize12,
                                  //                 color: Theme.of(context).primaryColor,
                                  //               ),
                                  //             ),
                                  //             Expanded(
                                  //               child: Text(
                                  //                 dataList[j].features[i].featureName,
                                  //                 style: openSansRegular.copyWith(
                                  //                   fontSize: Dimensions.fontSize12,
                                  //                   color: Theme.of(context).primaryColor,
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //         HtmlWidget(dataList[j].sortDesc,textStyle: openSansRegular.copyWith(
                                  //           fontSize: Dimensions.fontSize12,
                                  //           fontWeight: FontWeight.w100,
                                  //           color: Theme.of(context).disabledColor,
                                  //         ),),
                                  //       ],
                                  //     );
                                  //   },
                                  // ),

                                  sizedBoxDefault(),
                                  CustomButtonWidget(
                                    height: Dimensions.fontSize40,
                                    buttonText: 'Know More',
                                    isBold: false,
                                    transparent: true,
                                    onPressed: () {
                                      Get.to(PlansDetailsScreen(
                                          planModel: dataList[j]));
                                    },
                                  ),
                                ],
                              ));
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    sizedBoxDefault(),
                          )
                  ],
                );
    });
  }
}
