import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:peckme/model/self_lead_model.dart';

class SelfLeadAlloterService {
  final String baseUrl = "https://fms.bizipac.com/apinew/ws_new/";

  /// Step 1: Check lead status
  Future<SelfLeadAlloterModel?> checkLead(
    String mobile,
    String branchId,
  ) async {
    final response = await http.get(
      Uri.parse(
        '$baseUrl/check_lead_status.php?mobile=$mobile&branch_id=$branchId',
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == 1 && data['data'] != null) {
        return SelfLeadAlloterModel.fromJson(data['data']);
      }
    }
    return null;
  }

  /// Step 2: Assign lead (accept button)
  Future<bool> assignLead(String mobile, String uid, String branchId) async {
    final response = await http.get(
      Uri.parse(
        '$baseUrl/self_lead_asign.php?mobile=$mobile&uid=$uid&branch_id=$branchId',
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['success'] == 1;
    }
    return false;
  }
}
