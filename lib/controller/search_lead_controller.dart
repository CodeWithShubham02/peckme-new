import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:peckme/model/new_lead_model.dart';

import '../model/search_lead_model.dart';


class LeadService {
  static const String baseUrl = "https://fms.bizipac.com/apinew/ws_new/search_lead.php";

  static Future<SearchLead?> searchLeadById(String leadId) async {
    final response = await http.get(Uri.parse("$baseUrl?lead_id=$leadId"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data["success"] == 1 && data["data"].isNotEmpty) {
        return SearchLead.fromJson(data["data"][0]);
      }
    }
    return null;
  }
}
