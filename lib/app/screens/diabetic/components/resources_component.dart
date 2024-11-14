import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iclinix/app/widget/custom_button_widget.dart';
import 'package:iclinix/app/widget/custom_containers.dart';
import 'package:iclinix/app/widget/custom_image_widget.dart';
import 'package:iclinix/controller/diabetic_controller.dart';
import 'package:iclinix/helper/route_helper.dart';
import 'package:iclinix/utils/app_constants.dart';
import 'package:iclinix/utils/dimensions.dart';
import 'package:iclinix/utils/sizeboxes.dart';
import 'package:iclinix/utils/styles.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import '../../../../data/models/response/diabetic_dashboard_detail_model.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../../../../helper/local_notification.dart';
import '../../../widget/custom_snackbar.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';


class ResourcesComponent extends StatelessWidget {
  const ResourcesComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DiabeticController>(builder: (controller) {
      final data = controller.videoResources;
      final isListEmpty = data.isEmpty;
      final isSugarLoading = controller.isDailySugarCheckupLoading;
      final dataReading = controller.textResources;
      final isReadingListEmpty = dataReading.isEmpty;
      final dataImage = controller.imageResources;
      final isImageListEmpty = dataImage.isEmpty;
      final dataPdf = controller.pdfResources;
      final isPdfListEmpty = dataPdf.isEmpty;
      final dataDietPlan = controller.dietPlan;
      final isDataDietPlanListEmpty = data.isEmpty;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Resources',
            style: openSansSemiBold,
          ),
          sizedBoxDefault(),
          if (isSugarLoading)
            const Center(child: CircularProgressIndicator())
          else if (isListEmpty && isReadingListEmpty && isImageListEmpty && isPdfListEmpty)
            const Center(child: Text('No resources available.')) // Show no resources text
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isDataDietPlanListEmpty) _buildDietPlanContent(context, controller, dataDietPlan),
                if (!isListEmpty) _buildVideoContent(context, controller, data),
                sizedBoxDefault(),
                if (!isReadingListEmpty) _buildReadingContent(context, controller, dataReading),
                sizedBoxDefault(),
                if (!isImageListEmpty) _buildImageContent(context, controller, dataImage),
                sizedBoxDefault(),
                if (!isPdfListEmpty) _buildPdfContent(context, controller, dataPdf),
                sizedBox100(),
              ],
            ),
        ],
      );
    });
  }

  Widget _buildVideoContent(BuildContext context, DiabeticController controller, List<dynamic> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Video Content',
          style: openSansRegular.copyWith(
            fontSize: Dimensions.fontSize14,
            color: Theme.of(context).disabledColor.withOpacity(0.60),
          ),
        ),
        sizedBox10(),
        SizedBox(
          height: 200,
          child: ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: data.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, i) {
              final videoId = controller.extractVideoId(data[i].ytUrl!);
              final thumbnailUrl = 'https://img.youtube.com/vi/$videoId/0.jpg';
              return Container(
                height: 200,
                width: 250,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            print('ytUrl');
                            _launchURL(data[i].ytUrl.toString());
                          },
                          child: CustomNetworkImageWidget(
                            height: 150,
                            image: thumbnailUrl,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Icon(
                            Icons.play_circle_fill_outlined,
                            size: 60,
                            color: Colors.redAccent.withOpacity(0.80),
                          ),
                        ),
                      ],
                    ),
                    sizedBox4(),
                    Text(
                      data[i].name.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: openSansMedium.copyWith(
                        fontSize: Dimensions.fontSize13,
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) => sizedBoxW10(),
          ),
        ),
      ],
    );
  }

  Widget _buildReadingContent(BuildContext context, DiabeticController controller, List<dynamic> dataReading) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Articles',
          style: openSansRegular.copyWith(
            fontSize: Dimensions.fontSize14,
            color: Theme.of(context).disabledColor.withOpacity(0.60),
          ),
        ),
        sizedBox10(),
        SizedBox(
          height: 250,
          child: ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: dataReading.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, i) {
              return GestureDetector(
                onTap: () {
                  Get.toNamed(RouteHelper.getResourcesDetailsRoute(dataReading[i].id.toString(), dataReading[i].name.toString()));
                },
                child: Container(
                  height: 200,
                  width: 250,
                  padding: const EdgeInsets.all(Dimensions.paddingSize8),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    border: Border.all(
                      width: 0.5,
                      color: Theme.of(context).disabledColor,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        dataReading[i].name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: openSansMedium.copyWith(
                          fontSize: Dimensions.fontSize13,
                        ),
                      ),

                      Text(
                        dataReading[i].sortDescription,
                        maxLines: 7,
                        overflow: TextOverflow.ellipsis,
                        style: openSansMedium.copyWith(
                          fontSize: Dimensions.fontSize13,
                          color: Theme.of(context).disabledColor.withOpacity(0.40),
                        ),
                      ),
                      const Spacer(),
                      CustomButtonWidget(buttonText: 'Read',
                      height: 38,fontSize: Dimensions.fontSize14,
                      onPressed: () {
                        Get.toNamed(RouteHelper.getResourcesDetailsRoute(dataReading[i].id.toString(), dataReading[i].name.toString()));

                      },isBold: false,
                      transparent: true,),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) => sizedBoxW10(),
          ),
        ),
      ],
    );
  }

  Widget _buildImageContent(BuildContext context, DiabeticController controller, List<dynamic> dataImage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gallery',
          style: openSansRegular.copyWith(
            fontSize: Dimensions.fontSize14,
            color: Theme.of(context).disabledColor.withOpacity(0.60),
          ),
        ),
        sizedBox10(),
        SizedBox(
          height: 180,
          child: ListView.separated(
            itemCount: dataImage.length,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, i) {
              print('${AppConstants.resourcesImageUrl}${dataImage[i].file}');
              return GestureDetector(
                onTap: () {
                  showImageViewer(
                    context, Image.network('${AppConstants.resourcesImageUrl}${dataImage[i].file}').image,
                    swipeDismissible: true,
                    doubleTapZoomable: true,
                  );
                },
                child: Container(
                  height: 200,
                  width: 250,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomNetworkImageWidget(
                        height: 150,
                        image: '${AppConstants.resourcesImageUrl}${dataImage[i].file}',
                      ),
                      sizedBox10(),
                      Text(
                        dataImage[i].name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: openSansMedium.copyWith(
                          fontSize: Dimensions.fontSize13,
                        ),
                      ),
                      // TextButton(
                      //   onPressed: () => controller.downloadImage(dataImage[i].fileUrl, dataImage[i].name),
                      //   child: Text(
                      //     'Download',
                      //     maxLines: 1,
                      //     overflow: TextOverflow.ellipsis,
                      //     style: openSansBold.copyWith(
                      //       fontSize: Dimensions.fontSize14,
                      //       decoration: TextDecoration.underline,
                      //       color: Colors.redAccent,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) => sizedBoxW10(),
          ),
        ),
      ],
    );
  }

  Widget _buildPdfContent(BuildContext context, DiabeticController controller, List<dynamic> dataPdf) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PDF Content',
          style: openSansRegular.copyWith(
            fontSize: Dimensions.fontSize14,
            color: Theme.of(context).disabledColor.withOpacity(0.60),
          ),
        ),
        sizedBox10(),
        SizedBox(
          height: 250,
          child: ListView.separated(
            itemCount: dataPdf.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            itemBuilder: (_, i) {
              return GestureDetector(
                onTap: () {
                  // controller.openPDF(dataPdf[i].fileUrl);
                },
                child: Container(
                  height: 200,
                  width: 250,
                  padding: const EdgeInsets.all(Dimensions.paddingSize8),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    border: Border.all(
                      width: 0.5,
                      color: Theme.of(context).disabledColor,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          dataPdf[i].name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: openSansMedium.copyWith(
                            fontSize: Dimensions.fontSize13,
                          ),
                        ),
                      ),
                      Text(
                        dataPdf[i].sortDescription,
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        style: openSansMedium.copyWith(
                          fontSize: Dimensions.fontSize13,
                          color: Theme.of(context).disabledColor.withOpacity(0.40),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          print('check');
                          final url = '${AppConstants.resourcesImageUrl}${dataPdf[i].file}';
                          downloadFile(url);

                        },
                        child: Text(
                          'Download',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: openSansBold.copyWith(
                            fontSize: Dimensions.fontSize14,
                            decoration: TextDecoration.underline,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) => sizedBoxW10(),
          ),
        ),
      ],
    );
  }


  Widget _buildDietPlanContent(BuildContext context, DiabeticController controller, DietPlanModel? dietPlan) {
    if (dietPlan == null) {
      return const SizedBox(); // Or any placeholder if no diet plan is available
    }

    return CustomDecoratedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  'Diet Plan',
                  style: openSansBold.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Download',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: openSansBold.copyWith(
                    fontSize: Dimensions.fontSize14,
                    color: Colors.redAccent,
                  ),
                ),
              ),
            ],
          ),
          const Divider(),
          CustomNetworkImageWidget(image: dietPlan.excerciseChart),
          CustomNetworkImageWidget(image: dietPlan.dietchart),
        ],
      ),
    );
  }



  void _launchURL(String url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }

  Future<void> downloadFile(String fileUrl) async {
    // Ask for permission
    await Permission.manageExternalStorage.request();
    var status = await Permission.manageExternalStorage.status;
    if (status.isDenied) {
      // Permission denied
      return;
    }

    if (await Permission.storage.isRestricted) {
      // Storage is restricted
      return;
    }

    if (status.isGranted) {
      var storageStatus = await Permission.storage.status;
      if (!storageStatus.isGranted) {
        await Permission.storage.request();
      }

      final response = await http.get(Uri.parse(fileUrl));
      final bytes = response.bodyBytes;
      final fileName = fileUrl.split('/').last;

      try {
        final directory = Directory('/storage/emulated/0/Download'); // Android default download folder
        final filePath = '${directory.path}/$fileName';
        File file = File(filePath);
        await file.writeAsBytes(bytes);
        showCustomSnackBar("File Saved to download folder", isError: false);
        print('File downloaded to: $filePath');
        _showNotification(fileName, filePath);
      } catch (e) {
        print('Error downloading file: $e');
      }
    }
  }

  Future<void> _showNotification(String fileName, String filePath) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
        'your channel id', 'your channel name',
        importance: Importance.max, priority: Priority.high, ticker: 'ticker');

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
        0,
        'Download Complete',
        'File downloaded to: $filePath',
        platformChannelSpecifics,
        payload: filePath);
  }
}
