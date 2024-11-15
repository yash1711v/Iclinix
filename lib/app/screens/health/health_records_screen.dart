import 'package:flutter/material.dart';
import 'package:flutter_slide_drawer/flutter_slide_widget.dart';
import 'package:iclinix/app/widget/custom_drawer_widget.dart';

import 'package:iclinix/app/widget/loading_widget.dart';
import 'package:iclinix/controller/appointment_controller.dart';
import 'package:get/get.dart';

import '../../../helper/date_converter.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/images.dart';
import '../../../utils/sizeboxes.dart';
import '../../../utils/styles.dart';
import '../../widget/common_widgets.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_button_widget.dart';
import '../../widget/custom_containers.dart';
import '../../widget/custom_image_widget.dart';
import '../../widget/empty_data_widget.dart';
import '../appointment/appointment_details_screen.dart';

class HealthRecordsScreen extends StatefulWidget {
  HealthRecordsScreen({super.key});

  @override
  State<HealthRecordsScreen> createState() => _HealthRecordsScreenState();
}

class _HealthRecordsScreenState extends State<HealthRecordsScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<SliderDrawerWidgetState> drawerKey =
      GlobalKey<SliderDrawerWidgetState>();
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<AppointmentController>().getAppointmentHistory();
    });
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppointmentController>(builder: (appointmentControl) {
      final appointmentHistoryList = appointmentControl.appointmentHistoryList;
      final isListEmpty =
          appointmentHistoryList == null || appointmentHistoryList.isEmpty;
      final isLoading = appointmentControl.isAppointmentHistoryLoading;
      // if (isLoading) {
      //   LoadingDialog.showLoading(message: "Please wait...");
      // } else {
      //   // Dismiss loading dialog when loading is complete
      //   LoadingDialog.hideLoading();
      // }
      return SliderDrawerWidget(
        key: drawerKey,
        option: SliderDrawerOption(
          backgroundColor: Theme.of(context).primaryColor,
          sliderEffectType: SliderEffectType.Rounded,
          upDownScaleAmount: 30,
          radiusAmount: 30,
          direction: SliderDrawerDirection.LTR,
        ),
        drawer: const CustomDrawer(),
        body: Scaffold(
            appBar: CustomAppBar(
                title: 'Recent Appointments',
                drawerButton: CustomMenuButton(tap: () {
                  drawerKey.currentState!.toggleDrawer();
                }),
                menuWidget: Row(
                  children: [
                    NotificationButton(),
                  ],
                )),
            body: isListEmpty
                ? Padding(
                    padding:
                        const EdgeInsets.only(top: Dimensions.paddingSize100),
                    child: Center(
                      child: EmptyDataWidget(
                        text: 'Nothing Available', // Change this text if needed
                        image: Images.icEmptyDataHolder,
                        fontColor: Theme.of(context).disabledColor,
                      ),
                    ),
                  )
                : Column(
                    children: [
                      TabBar(
                        controller: _tabController,
                        indicatorColor: Theme.of(context).primaryColor,
                        labelColor: Theme.of(context).primaryColor,
                        dividerColor: Colors.grey,
                        unselectedLabelColor: Colors.grey,
                        tabs: [
                          Tab(
                            text: 'Appointments',
                          ),
                          Tab(
                            text: 'Prescriptions',
                          ),
                          Tab(
                            text: 'Reports',
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.grey, // Color of the divider
                        thickness: 1, // Thickness of the divider
                        height: 1, // Space taken by the divider
                      ),
                      sizedBox10(),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ListView.builder(
                                padding: EdgeInsets.zero,
                                // separatorBuilder: (BuildContext context, int index) => sizedBox10(),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: appointmentHistoryList.length,
                                itemBuilder: (_, i) {
                                  final appointment =
                                  appointmentHistoryList[i];
                                  final patientAppointments =
                                      appointment.patientAppointments;
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal:
                                        Dimensions.paddingSizeDefault),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        patientAppointments.isNotEmpty
                                            ? ListView.separated(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          physics:
                                          const NeverScrollableScrollPhysics(),
                                          itemCount: patientAppointments
                                              .length,
                                          itemBuilder: (_, j) {
                                            final patientAppointment =
                                            patientAppointments[j];
                                            return CustomDecoratedContainer(
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(
                                                    '${AppointmentDateTimeConverter.formatDate(patientAppointment.opdDate.toString())} - ${patientAppointment.opdTime.toString()}',
                                                    style: openSansBold
                                                        .copyWith(
                                                      fontSize: Dimensions
                                                          .fontSize13,
                                                      color: Theme.of(
                                                          context)
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                  sizedBox20(),
                                                  Column(
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          CustomNetworkImageWidget(
                                                            height: 80,
                                                            width: 80,
                                                            image: patientAppointment
                                                                .branchImage,
                                                          ),
                                                          sizedBoxW10(),
                                                          Expanded(
                                                            child:
                                                            Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                RichText(
                                                                  maxLines:
                                                                  1,
                                                                  overflow:
                                                                  TextOverflow.ellipsis,
                                                                  text:
                                                                  TextSpan(
                                                                    children: [
                                                                      TextSpan(
                                                                        text: "Branch: ",
                                                                        style: openSansRegular.copyWith(
                                                                          fontSize: Dimensions.fontSize12,
                                                                          color: Theme.of(context).primaryColor,
                                                                        ),
                                                                      ),
                                                                      TextSpan(
                                                                        text: patientAppointment.branchName,
                                                                        style: openSansBold.copyWith(
                                                                          fontSize: Dimensions.fontSize13,
                                                                          color: Theme.of(context).disabledColor.withOpacity(0.70),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                sizedBox10(),
                                                                RichText(
                                                                  maxLines:
                                                                  1,
                                                                  overflow:
                                                                  TextOverflow.ellipsis,
                                                                  text:
                                                                  TextSpan(
                                                                    children: [
                                                                      TextSpan(
                                                                        text: "Patient: ",
                                                                        style: openSansRegular.copyWith(
                                                                          fontSize: Dimensions.fontSize12,
                                                                          color: Theme.of(context).primaryColor,
                                                                        ),
                                                                      ),
                                                                      TextSpan(
                                                                        text: '${appointment.firstName} ${appointment.lastName}',
                                                                        style: openSansBold.copyWith(
                                                                          fontSize: Dimensions.fontSize13,
                                                                          color: Theme.of(context).disabledColor.withOpacity(0.70),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                sizedBox10(),
                                                                RichText(
                                                                  maxLines:
                                                                  1,
                                                                  overflow:
                                                                  TextOverflow.ellipsis,
                                                                  text:
                                                                  TextSpan(
                                                                    children: [
                                                                      TextSpan(
                                                                        text: "Patient Id: ",
                                                                        style: openSansRegular.copyWith(
                                                                          fontSize: Dimensions.fontSize12,
                                                                          color: Theme.of(context).primaryColor,
                                                                        ),
                                                                      ),
                                                                      TextSpan(
                                                                        text: patientAppointment.patientId.toString(),
                                                                        style: openSansBold.copyWith(
                                                                          fontSize: Dimensions.fontSize13,
                                                                          color: Theme.of(context).disabledColor.withOpacity(0.70),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                sizedBox10(),

                                                                // Align(
                                                                //   alignment: Alignment.centerRight,
                                                                //   child: GestureDetector(
                                                                //     onTap: () {
                                                                //       Get.to(AppointmentDetailsScreen(appointmentHistoryModel: appointmentHistoryList[i],));
                                                                //     },
                                                                //     child: Container(
                                                                //       decoration: BoxDecoration(
                                                                //         color: Theme.of(context).primaryColor ,
                                                                //         borderRadius: BorderRadius.circular(Dimensions.radius10),
                                                                //       ),
                                                                //       child: Padding(
                                                                //         padding: const EdgeInsets.all(8.0),
                                                                //         child: Text(
                                                                //           'View Details',
                                                                //           style: openSansSemiBold.copyWith(
                                                                //             fontSize: Dimensions.fontSize14,
                                                                //             color: Theme.of(context).cardColor,
                                                                //           ),
                                                                //         ),
                                                                //       ),
                                                                //     ),
                                                                //   ),
                                                                // )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      sizedBoxDefault(),
                                                      CustomButtonWidget(
                                                        buttonText:
                                                        'View Details',
                                                        onPressed: () {
                                                          Get.to(
                                                              AppointmentDetailsScreen(
                                                                appointmentHistoryModel:
                                                                appointmentHistoryList[
                                                                i],
                                                              ));
                                                        },
                                                        height: 40,
                                                        isBold: false,
                                                        fontSize: Dimensions
                                                            .paddingSizeDefault,
                                                        color: Theme.of(
                                                            context)
                                                            .primaryColor,
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          separatorBuilder:
                                              (BuildContext context,
                                              int index) =>
                                              sizedBox10(),
                                        )
                                            : const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: Dimensions
                                                  .paddingSizeDefault),
                                          child:
                                          Center(child: Text('')),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
      );
    });
  }
}
