// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
//
// import 'package:path_provider/path_provider.dart';
//
//
// class Invoice extends StatefulWidget {
//   final String htmlContent;
//
//   const Invoice({super.key, required this.htmlContent});
//
//   @override
//   State<Invoice> createState() => _InvoiceState();
// }
//
// class _InvoiceState extends State<Invoice> {
//   @override
//   void initState() {
//     super.initState();
//
//     // Uncomment to automatically generate the document on init
//     createDocument();
//   }
//
//   createDocument() async {
//     final directory = await getApplicationDocumentsDirectory();
//     final filePath = '${directory.path}/example.pdf';
//     final file = File(filePath);
//
//     final newpdf = pdfWidgets.Document();
//
//     try {
//       // Convert HTML text to PDF widgets
//       final List<pdfWidgets.Widget> widgets =
//       await pdfWidgets.HTMLToPdf().convert(widget.htmlContent);
//
//       // Add widgets to the PDF
//       newpdf.addPage(pdfWidgets.MultiPage(
//         maxPages: 200,
//         build: (context) => widgets,
//       ));
//
//       // Save the PDF file
//       await file.writeAsBytes(await newpdf.save());
//       debugPrint("PDF created successfully at: $filePath");
//       // shareDocument();
//       // Open the PDF file
//       final result = await OpenFile.open(filePath);
//       debugPrint("File opened with result: ${result.message}");
//     } catch (e) {
//       debugPrint("Error creating or opening PDF: $e");
//     }
//   }
//
//   shareDocument() async {
//     final directory = await getApplicationDocumentsDirectory();
//     final filePath = '${directory.path}/example.pdf';
//     final file = File(filePath);
//
//     if (await file.exists()) {
//       await Share.share(filePath, subject: 'Invoice');
//     } else {
//       debugPrint("File not found at $filePath");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     debugPrint('Invoice: ${widget.htmlContent.length}');
//
//     return Scaffold(
//       appBar: AppBar(title: const Text('Invoice')),
//       body: SingleChildScrollView(
//         child: HtmlWidget(
//           widget.htmlContent,
//         ),
//       ),
//     );
//   }
// }
