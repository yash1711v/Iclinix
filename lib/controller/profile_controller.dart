import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:iclinix/app/widget/custom_snackbar.dart';
import 'package:iclinix/controller/auth_controller.dart';
import 'package:iclinix/data/models/response/user_data.dart';
import 'package:iclinix/helper/route_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import '../data/repo/profile_repo.dart';
import '../data/api/api_client.dart';
import 'package:http_parser/http_parser.dart';
import '../helper/date_converter.dart';

class ProfileController extends GetxController implements GetxService {
  final ProfileRepo profileRepo;
  final ApiClient apiClient;

  ProfileController({required this.profileRepo, required this.apiClient});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  XFile? _pickedImage;
  XFile? get pickedImage => _pickedImage;

  void pickImage({required bool isRemove}) async {
    if (isRemove) {
      _pickedImage = null;
    } else {
      _pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    }
    update();
  }


  DateTime? selectedDate;
  String? formattedDate;

  void updateDate(DateTime newDate) {
    selectedDate = newDate;
    formattedDate = SimpleDateConverter.formatDateToCustomFormat(selectedDate!);
    update();
  }

  DateTime? selectedDobDate;
  String? formattedDobDate;

  void updateDobDate(DateTime newDate) {
    selectedDobDate = newDate;
    formattedDobDate = SimpleDateConverter.formatDateToCustomFormat(selectedDobDate!);
    update();
  }

  var selectedGender = 'Male';
  final List<String> genderOptions = ['Male', 'Female',];

  void updateGender(String gender) {
    selectedGender = gender;
    update();
  }
  String getGenderStatus() {
    return 'gender name == ${selectedGender == 'Male' ? 'M' : 'F'}';
  }

  var selectedDiabetes = 'No';
  final List<String> diabetesOptions = ['No','Yes'];

  void updateDiabetes(String val) {
    selectedDiabetes = val;
    update();
  }
  String getDiabetesStatus() {
    return 'diabetes name == ${selectedDiabetes == 'No' ? '0' : '1'}';
  }
  void initializeDiabetes() {
    if (Get.find<AuthController>().patientData != null) {
      selectedDiabetes = Get.find<AuthController>().patientData!.diabetesProblem == 1 ? 'Yes' : 'No';
    } else {
      selectedDiabetes = 'No'; // Fallback
    }
    update();
  }


  var selectedGlasses = 'No';
  final List<String> glassesOptions = ['No','Yes'];

  void updateGlasses(String val) {
    selectedGlasses = val;
    update();
  }

  String getGlassesStatus() {
    return 'diabetes name == ${selectedGlasses == 'No' ? '0' : '1'}';
  }

  void initializeGlasses() {
    if (Get.find<AuthController>().patientData != null) {
      selectedGlasses = Get.find<AuthController>().patientData!.eyeProblem == 1 ? 'Yes' : 'No';
    } else {
      selectedGlasses = 'No'; // Fallback
    }
    update();
  }


  var selectedBp= 'No';
  final List<String> bpOptions = ['No','Yes'];

  void updateBp(String val) {
    selectedBp = val;
    update();
  }

  String getBpStatus() {
    return 'diabetes name == ${selectedBp == 'No' ? '0' : '1'}';
  }

  void initializeBp() {
    if (Get.find<AuthController>().patientData != null) {
      selectedBp = Get.find<AuthController>().patientData!.bpProblem == 1 ? 'Yes' : 'No';
    } else {
      selectedBp = 'No'; // Fallback
    }
    update();
  }



  bool _isProfileLoading = false;
  bool get isProfileLoading => _isProfileLoading;
  Future<void> updateProfileApi(
      String? firstname,
      String? lastname,
      String? dob,
      String? diabetesProblem,
      String? bpProblem,
      String? eyeProblem,
      String? gender,
      ) async {
    try {
      _isProfileLoading = true;
      update();

      Response response = await profileRepo.updateProfileRepo(
        firstname,
        lastname,
        dob,
        diabetesProblem,
        bpProblem,
        eyeProblem,
        gender,
      );

      if (response.statusCode == 200) {
        var responseData = response.body;
        if (responseData["Msg"] == "Data Updated Successfully") {
          Get.toNamed(RouteHelper.getDashboardRoute());
          showCustomSnackBar('Saved Successfully', isError: false);
        } else {
          showCustomSnackBar('Update profile failed', isError: true);
          print('Update profile failed');
        }
      } else {
        showCustomSnackBar('Server error: ${response.statusCode}', isError: true);
      }
    } catch (e) {
      showCustomSnackBar('An error occurred: $e', isError: true);
      print('Exception: $e');
    } finally {
      Get.find<AuthController>().userDataApi();
      _isProfileLoading = false;
      update();
    }
  }


  // bool _userDataLoading = false;
  // bool get userDataLoading => _userDataLoading;
  //
  //
  // UserData? _userData;
  // PatientData? _patientData;
  //
  // UserData? get userData => _userData;
  // PatientData? get patientData => _patientData;
  //
  // Future<ApiResponse?> userDataApi() async {
  //   _userDataLoading = true;
  //   _userData = null;
  //   _patientData = null;
  //   update();
  //
  //   Response response = await profileRepo.getUserData();
  //   if (response.statusCode == 200) {
  //     Map<String, dynamic> responseData = response.body;
  //     ApiResponse apiResponse = ApiResponse.fromJson(responseData);
  //
  //     _userData = apiResponse.userData;
  //     _patientData = apiResponse.patientData;
  //     bool isSubscriptionActive = responseData['subscriptionArray']['status'] == 'active';
  //     await Get.find<AuthController>().saveSubscriptionStatus(isSubscriptionActive);
  //
  //   } else {
  //     // Handle the error response if needed
  //   }
  //
  //   _userDataLoading = false;
  //   update();
  //   return ApiResponse(userData: _userData, patientData: _patientData); // Return the combined response
  // }








}
