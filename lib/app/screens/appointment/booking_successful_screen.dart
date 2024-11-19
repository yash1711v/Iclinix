
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:iclinix/app/widget/custom_button_widget.dart';
import 'package:iclinix/app/widget/custom_containers.dart';
import 'package:iclinix/helper/date_converter.dart';
import 'package:iclinix/helper/invoice.dart';
import 'package:iclinix/helper/route_helper.dart';
import 'package:iclinix/utils/dimensions.dart';
import 'package:iclinix/utils/images.dart';
import 'package:iclinix/utils/sizeboxes.dart';
import 'package:iclinix/utils/styles.dart';
import 'package:iclinix/utils/themes/light_theme.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'dart:typed_data' as typedData;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';


class BookingSuccessfulScreen extends StatefulWidget {
  final String? date;
  final String? time;
  final String? apptId;
  const BookingSuccessfulScreen({super.key, this.date, this.time, this.apptId});

  @override
  State<BookingSuccessfulScreen> createState() => _BookingSuccessfulScreenState();
}

class _BookingSuccessfulScreenState extends State<BookingSuccessfulScreen> {


  // Function to generate invoice
  Future<typedData.Uint8List> generateInvoice() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Invoice', style: pw.TextStyle(fontSize: 32, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Text('Invoice #: 12345'),
              pw.Text('Date: ${DateTime.now().toString().substring(0, 10)}'),
              pw.SizedBox(height: 20),
              pw.Text('Billing To:'),
              pw.Text('John Doe'),
              pw.Text('123 Main Street'),
              pw.Text('City, Country'),
              pw.SizedBox(height: 20),
              pw.Table.fromTextArray(
                headers: ['Item', 'Qty', 'Price', 'Total'],
                data: [
                  ['Widget A', '2', '\$50', '\$100'],
                  ['Widget B', '1', '\$75', '\$75'],
                  ['Widget C', '3', '\$20', '\$60'],
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Text('Grand Total: \$235', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
                ],
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  // Function to save and download invoice
  Future<void> saveAndDownloadInvoice(typedData.Uint8List pdfData) async {
    try {
      // Get directory for saving the file
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/invoice.pdf');

      // Write the PDF data to the file
      await file.writeAsBytes(pdfData);

      // Share or download the PDF using the printing package
      await Printing.sharePdf(bytes: pdfData, filename: 'invoice.pdf');

      // Optionally, show a success message
      print('Invoice saved to ${file.path}');
    } catch (e) {
      print('Error saving invoice: $e');
    }
  }

  double progress = 0.0; // Track download progress
  bool isDownloading = false;

  Future<void> downloadFile(String url, String fileName) async {
    setState(() {
      progress = 0.0;
      isDownloading = true;
    });

    Directory? downloadsDir;
    if (Platform.isAndroid) {
      downloadsDir = Directory('/storage/emulated/0/Download'); // Android Downloads folder
    } else if (Platform.isIOS) {
      downloadsDir = await getApplicationDocumentsDirectory(); // iOS app-specific folder
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

      // Open the downloaded file
      OpenFile.open(filePath);
    } catch (e) {
      setState(() {
        isDownloading = false;
      });
      print("Download failed: $e");
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: isDownloading?0.1:1,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 25,),
                    Image.asset(Images.icBookingSuccessful,height: 160,),
                    sizedBox10(),
                    Text('Booking Successful!',style: openSansBold.copyWith(color: blueColor,
                    fontSize: Dimensions.fontSize20),),
                    sizedBox5(),
                    Text('You have successfully booked your appointment at',
                      textAlign: TextAlign.center,
                      style: openSansRegular.copyWith(
                        fontSize: Dimensions.fontSize12,
                    color: Theme.of(context).disabledColor.withOpacity(0.70)),),
                    sizedBoxDefault(),
                    Text('IClinix Advanced Eye And Retina Centre Lajpat Nagar',
                      textAlign: TextAlign.center,
                      style: openSansRegular.copyWith(
                        fontSize: Dimensions.fontSizeDefault,
                        color: Theme.of(context).disabledColor),),
                    sizedBoxDefault(),
                    Row(
                      children: [
                        Expanded(
                          child: CustomDecoratedContainer(
                              child: Column(children: [
                                Text('On',style: openSansRegular.copyWith(
                                  fontSize: Dimensions.fontSize14,
                                  color: Theme.of(context).disabledColor.withOpacity(0.70)),),
                                Text(AppointmentDateTimeConverter.formatDate(widget.date!),
                                  textAlign: TextAlign.center,
                                  style: openSansSemiBold.copyWith(
                                      fontSize: Dimensions.fontSize14,
                                      color: Theme.of(context).primaryColor),),



                          ],)),
                        ),
                        sizedBoxW10(),
                        Expanded(
                          child: CustomDecoratedContainer(
                              child: Column(children: [
                                Text('At',style: openSansRegular.copyWith(
                                    fontSize: Dimensions.fontSize14,
                                    color: Theme.of(context).disabledColor.withOpacity(0.70)),),
                                Text('${widget.time}',
                                  textAlign: TextAlign.center,
                                  style: openSansSemiBold.copyWith(
                                      fontSize: Dimensions.fontSize14,
                                      color: Theme.of(context).primaryColor),),



                              ],)),
                        ),
                      ],
                    ),
                    sizedBox40(),

                   const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomButtonWidget(buttonText: 'Download Invoice',
                              transparent: true,
                              isBold: false,
                              fontSize: Dimensions.fontSize14,
                              onPressed: () {
                                downloadFile(widget.apptId!, 'invoice.pdf');
                              },),

                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: CustomButtonWidget(buttonText: 'Go Home',
                              transparent: true,
                              isBold: false,
                              fontSize: Dimensions.fontSize14,
                              onPressed: () {
                                Get.toNamed(RouteHelper.getDashboardRoute());
                              },),
                          ),
                        ],
                      ),
                    ),
                    sizedBox40(),

                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: isDownloading,
            child: Positioned(
                top: 400,
                left: 200,
                child: CircularProgressIndicator(value: progress)),
          )
        ],
      ),
    );
  }
}
