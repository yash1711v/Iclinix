import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iclinix/controller/appointment_controller.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../controller/chat_controller.dart';
import '../../../controller/subshistory_controller.dart';
import '../../widget/loading_widget.dart';
import '../appointment/booking_successful_screen.dart';

class SubsHistory extends StatefulWidget {
  const SubsHistory({super.key});

  @override
  State<SubsHistory> createState() => _SubsHistoryState();
}

class _SubsHistoryState extends State<SubsHistory> {
  dynamic filePaths = "";
  double progress = 0.0; // Track download progress
  bool isDownloading = false;

  Future<void> downloadFile(String url, String fileName) async {
    if (await Permission.storage.isDenied) {
      await Permission.manageExternalStorage.request();
      await Permission.storage.request();
    }

    setState(() {
      progress = 0.0;
      isDownloading = true;
    });

    setState(() {
      progress = 0.0;
      isDownloading = true;
    });
    LoadingDialog.showLoading(message: "Completed: $progress");

    Directory? downloadsDir;
    if (Platform.isAndroid) {
      downloadsDir =
          Directory('/storage/emulated/0/Download'); // Android Downloads folder
    } else if (Platform.isIOS) {
      downloadsDir =
          await getApplicationDocumentsDirectory(); // iOS app-specific folder
    }

    final filePath = "${downloadsDir?.path}/${fileName}";

    Dio dio = Dio();

    try {
      await dio.download(
        url,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            setState(() {
              progress = received / total;
            });
          }
        },
      );

      setState(() {
        isDownloading = false;
      });

      filePaths = filePath;
      // Open the downloaded file
      // OpenFile.open(filePath);

      LoadingDialog.hideLoading();
      showNotification(fileName, filePath);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Download Complete"),
            content: Text("The file has been downloaded successfully."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Close"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  OpenFile.open(filePath);
                },
                child: Text("Open File"),
              ),
            ],
          );
        },
      );
    } catch (e) {
      setState(() {
        isDownloading = false;
      });
      print("Download failed: $e");
    }
  }

  static String calculateTimeLeft(String expirationDate) {
    try {
      final DateTime expiry = DateTime.parse(expirationDate);
      final DateTime now = DateTime.now();

      if (expiry.isBefore(now)) {
        return "Expired";
      }

      final Duration difference = expiry.difference(now);
      final int daysLeft = difference.inDays;

      if (daysLeft > 365) {
        int years = daysLeft ~/ 365;
        return "$years year${years > 1 ? 's' : ''}";
      } else if (daysLeft > 30) {
        int months = daysLeft ~/ 30;
        return "$months month${months > 1 ? 's' : ''}";
      } else {
        return "$daysLeft day${daysLeft > 1 ? 's' : ''}";
      }
    } catch (e) {
      return "Invalid date";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Code here runs after the first frame is rendered

      Get.find<SubsHistoryController>().getallSubsHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubsHistoryController>(
      builder: (subsControl) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Subscription History'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                itemCount: Get.find<SubsHistoryController>()
                    .allSubsHistory
                    .subscriptionHistory
                    .length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                        elevation: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Plan Name: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      "${subsControl.allSubsHistory.subscriptionHistory[index].planName}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                                Text(
                                    "Plan Duration: ${calculateTimeLeft(subsControl.allSubsHistory.subscriptionHistory[index].expiredAt)}\n"
                                    "Plan Price: ${subsControl.allSubsHistory.subscriptionHistory[index].planPrice.toString()}"),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                          onPressed: () {
                                            Get.find<AppointmentController>()
                                                .getInvoiceSubs(subsControl
                                                    .allSubsHistory
                                                    .subscriptionHistory[index]
                                                    .subsHistoryId
                                                    .toString())
                                                .then((value) {
                                              if (Get.find<AppointmentController>()
                                                          .invoiceId !=
                                                      null &&
                                                  Get.find<AppointmentController>()
                                                          .invoiceId !=
                                                      "") {
                                                downloadFile(
                                                    Get.find<
                                                            AppointmentController>()
                                                        .invoiceId,
                                                    'invoice.pdf');
                                              }
                                            });
                                          },
                                          child: Text("Download Invoice")),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        )),
                  );
                }),
          ),
        );
      },
    );
  }
}
