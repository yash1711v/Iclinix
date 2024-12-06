
import 'package:iclinix/app/widget/loading_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get.dart';

import '../data/api/api_client.dart';
import '../data/repo/clinic_repo.dart';


class ChatController extends GetxController implements GetxService {
  final ClinicRepo clinicRepo;
  final ApiClient apiClient;
  ChatController({required this.clinicRepo, required this.apiClient});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int _type = 0;
  int get type => _type;

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

    clinicRepo.sendMessageRepo(subject, description,type.toString()).then((value) {
      print(value.bodyString);
    });
   }


}