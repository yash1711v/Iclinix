
import 'package:flutter/material.dart';
import 'package:iclinix/app/widget/custom_app_bar.dart';
import 'package:get/get.dart';
import 'package:iclinix/app/widget/custom_image_widget.dart';
import 'package:iclinix/app/widget/empty_data_widget.dart';
import 'package:iclinix/controller/clinic_controller.dart';
import 'package:iclinix/utils/app_constants.dart';
import 'package:iclinix/utils/images.dart';
import 'package:iclinix/utils/styles.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:html/parser.dart' as htmlParser;
import '../../../../utils/dimensions.dart';
import '../../../helper/route_helper.dart';
import '../dashboard/dashboard_screen.dart';
class ServiceDetailsScreen extends StatelessWidget {
  final String? id;
  final String? title;
  const ServiceDetailsScreen({super.key, this.id, this.title});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ClinicController>().getServiceDetailsApi(id);
    });
    return Scaffold(
        appBar: CustomAppBar(title: title,isBackButtonExist: true,
        menuWidget:  Row(
          children: [
           ElevatedButton(onPressed: (){
             Get.to(const DashboardScreen(pageIndex: 2));
           }, child: Text("Book Now",)),
          ],
        ),
        ),
        body: GetBuilder<ClinicController>(builder: (clinicControl) {
          final dataList = clinicControl.serviceDetails;
          final isListEmpty = dataList == null ;
          final isLoading = clinicControl.isServiceDetailsLoading;
          return  isLoading
              ? const Center(child: CircularProgressIndicator())
              : isListEmpty
              ? Center(
            child: EmptyDataWidget(
              text: 'Nothing Available',
              image: Images.icEmptyDataHolder,
              fontColor: Theme.of(context).disabledColor,
            ),
          )
              :  SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 300,
                  clipBehavior: Clip.hardEdge,
                  width: Get.size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    color: Theme.of(context).disabledColor,
                  ),
                  child: CustomNetworkImageWidget(
                    radius: 0,
                    image: '${dataList.bannerUrl}',
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$title: ",
                        style: openSansBold.copyWith(
                          fontSize: Dimensions.fontSize20,
                          color: Theme.of(context).disabledColor,
                        ),
                      ),
                      HtmlWidget(
                        dataList.description.toString(),
                        textStyle: openSansRegular.copyWith(
                          fontSize: Dimensions.fontSize14,
                          fontWeight: FontWeight.w100,
                          color: Theme.of(context).disabledColor,
                        ),
                      ),
                    ],
                  ),
                ),




              ],
            ),
          );
        })

    );
  }
}