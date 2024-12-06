import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_client.dart';

class SendMessageRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  SendMessageRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> sendMessageRepo(
      String? subject,
      String? description,
      String? type,
      ) async {
    return await apiClient.postData('add-ticket', {
      "subject" :subject,
      "description" :description,
      "type": type,
    });
  }
}