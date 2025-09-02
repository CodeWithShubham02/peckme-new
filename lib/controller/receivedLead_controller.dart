import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

import '../handler/EncryptionHandler.dart';
import '../model/new_lead_model.dart';



class ReceivedLeadController{

  Future<List<Lead>> fetchLeads({
    required String uid,
    required int start,
    required int end,
    required String branchId,
    required String app_version,
    required String appType,
  }) async {
    final String apiUrl =
        'https://fms.bizipac.com/apinew/ws_new/new_lead.php?uid=$uid&start=$start&end=$end&branch_id=$branchId&app_version=$app_version&app_type=$appType';

    const String HASH_KEY = "----------------";

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      print("---------------Encrypt data--------------");
      print(response.body);
      final decoded = jsonDecode(response.body);
      if (decoded['success'] == 1) {
        List<dynamic> leads = decoded['data'];
        for (var lead in leads) {
          lead['customer_name'] = decryptFMS(lead['customer_name'], HASH_KEY);
          lead['mobile'] = decryptFMS(lead['mobile'], HASH_KEY);
          if (lead['res_address'] != '') {
            lead['res_address'] = decryptFMS(lead['res_address'], HASH_KEY);
          }

        }
        //this is store data in th firebase firestore
        //CollectionReference receivedLeadsCollection = FirebaseFirestore.instance.collection('ReceivedLead');
        // for (var lead in leads) {
        //   String leadId = lead['lead_id'].toString();
        //   DocumentReference leadDocRef = receivedLeadsCollection.doc(leadId);
        //   final DocumentSnapshot doc = await leadDocRef.get();
        //   if (doc.exists) {
        //     // Document exists, so we'll skip adding this lead
        //   } else {
        //     // Document does not exist, so we can safely add this new lead
        //     try {
        //       await leadDocRef.set({
        //         'uid':uid,
        //         'customer_name': lead['customer_name'],
        //         'mobile': lead['mobile'],
        //         'lead_id': lead['lead_id'],
        //         'AMZAppId': lead['AMZAppId'],
        //         'clientname': lead['clientname'],
        //         'createdAt': DateTime.now(),
        //       });
        //       print('New lead added successfully with ID: "$leadId"');
        //     } catch (e) {
        //       print('Error adding new lead with ID "$leadId": $e');
        //     }
        //   }
        // }
        print("---------------decrypt data--------------");
        print(decoded['clientname']);
        print(leads.toString());
        return leads.map((lead) => Lead.fromJson(lead)).toList();
      } else {
        throw Exception("No data found.");
      }
    } else {
      throw Exception("Failed to load leads");
    }
  }

}
