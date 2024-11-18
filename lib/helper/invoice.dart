import 'dart:io';

import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:html/dom.dart';
import 'package:htmltopdfwidgets/htmltopdfwidgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

import '../utils/dimensions.dart';
import '../utils/styles.dart';

class Invoice extends StatefulWidget {
  final String htmlContent;
  const Invoice({super.key,required this.htmlContent});

  @override
  State<Invoice> createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  @override
  void initState() {
    super.initState();
    // getPath();
  }

  var targetPath = "";
  var targetFileName = "example_pdf_file";

  // getPath() async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   targetPath = directory.path;
  //
  //   try {
  //     var generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
  //         widget.htmlContent, targetPath, targetFileName);
  //     print("PDF generated at: $generatedPdfFile");
  //   } catch (e) {
  //     print("Error generating PDF: $e");
  //   }
  // }

  createDocument() async {
    const filePath = 'example.pdf';
    final file = File(filePath);
    final newpdf = Document();
    final List<Widget> widgets = await HTMLToPdf().convert(
      htmlText,
    );

    newpdf.addPage(MultiPage(
        maxPages: 200,
        build: (context) {
          return widgets;
        }));
    await file.writeAsBytes(await newpdf.save());
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Invoice: ${widget.htmlContent.length}');

    return Scaffold(
      appBar: AppBar(title: Text('Invoice')),
      body: SingleChildScrollView(
        child: HtmlWidget(
          """${widget.htmlContent}""",
          // textStyle: openSansRegular.copyWith(
          //   fontSize: Dimensions.fontSize12,
          //   fontWeight: FontWeight.w100,
          //   color: Theme.of(context).disabledColor,
          // ),
        ),

      ),
    );
  }
}
