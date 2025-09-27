// services/dashboard_service.dart
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/dashboard_response_model.dart';

class DashboardService {
  static const String _baseUrl =
      'https://fms.bizipac.com/apinew/ws_new/dashboard_counts.php';

  Future<DashboardResponse> fetchDashboardCounts({required String uid}) async {
    try {
      final response = await http.post(Uri.parse('$_baseUrl?uid=$uid'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print("=====================");
        print(jsonData);
        print("=====================");
        return DashboardResponse.fromJson(jsonData);
      } else {
        return DashboardResponse(
          success: 0,
          message: 'Server error',
          data: null,
        );
      }
    } catch (e) {
      return DashboardResponse(success: 0, message: e.toString(), data: null);
    }
  }
}
