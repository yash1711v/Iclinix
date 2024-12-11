
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:iclinix/app/widget/loading_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get.dart';

import '../data/api/api_client.dart';
import '../data/models/response/ticket_model.dart';
import '../data/repo/clinic_repo.dart';


class ChatController extends GetxController implements GetxService {
  final ClinicRepo clinicRepo;
  final ApiClient apiClient;
  ChatController({required this.clinicRepo, required this.apiClient});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int _type = 0;
  int get type => _type;
  List<Ticket> _allTickets = [];
  List<Ticket> get allTickets => _allTickets;

  void setAllTickets(List<Ticket> value) {
    _allTickets = value;
    update();
  }

  void setType(int value) {
    _type = value;
    update();
  }

  XFile? _pickedLogo;
  XFile? get pickedLogo => _pickedLogo;
  void pickImage(bool isRemove) async {
    if(isRemove) {
      _pickedLogo = null;
    }else {
        _pickedLogo = await ImagePicker().pickImage(source: ImageSource.gallery);

      update();
    }
  }

   void sendMessage(int type,String subject, String description){
     LoadingDialog.showLoading(message: "Sending..");
    clinicRepo.sendMessageRepo(subject, description,type.toString()).then((value) {
      if(value.body["status"]== 200) {
        if(value.body['message'].toString().trim() == "Ticket created successfully"){
          LoadingDialog.hideLoading();
          Get.back();
          Get.snackbar("Success", value.body['message']);
        }

      print(value.bodyString);}
    });
   }

   Future<void> getTickets() async {
     try {
       LoadingDialog.showLoading(message: "Sending..");
       final response = await clinicRepo.getTickets(); // Replace with your API call


       // Use response.body directly if already parsed into a map
       final Map<String, dynamic> parsedResponse = response.body;

       if (parsedResponse['data'] is List) {
         final List<dynamic> data = parsedResponse['data'];
         // Map each item in the data list to a Ticket object
         final List<Ticket> tickets = [];
          data.forEach((item) {
            tickets.add(Ticket.fromJson(item));
          });

         // Pass the tickets to your setter or state
         setAllTickets(tickets);
         // debugPrint("valueee==> ${allTickets}");
         LoadingDialog.hideLoading();
       } else {
         throw Exception("Expected 'data' to be a List, got ${parsedResponse['data'].runtimeType}");
       }
     } catch (e) {
       print("Error parsing tickets: $e");
       LoadingDialog.hideLoading();
     }

   }


   Future<void> getSingleTicketReplies(String id) async {
     try {
       LoadingDialog.showLoading(message: "Sending..");
       final response = await clinicRepo.getSingleTicketReplies(id); // Replace with your API call
       debugPrint("valueee==> ${response.body}");

       // Use response.body directly if already parsed into a map
       final Map<String, dynamic> parsedResponse = response.body;

       if (parsedResponse['data']["ticket"]["ticket_to_replies"] is List) {
         final List<dynamic> data = parsedResponse['data']["ticket"]["ticket_to_replies"];
         // Map each item in the data list to a Ticket object
         final List<TicketReply> tickets = [];
         data.forEach((item) {
           tickets.add(TicketReply.fromJson(item));
         });

         // Pass the tickets to your setter or state
         // setAllTickets(tickets);
         debugPrint("valueee==> ${allTickets}");
         LoadingDialog.hideLoading();
       } else {
         throw Exception("Expected 'data' to be a List, got ${parsedResponse['data'].runtimeType}");
       }
     } catch (e) {
       print("Error parsing tickets: $e");
       LoadingDialog.hideLoading();
     }
}


}