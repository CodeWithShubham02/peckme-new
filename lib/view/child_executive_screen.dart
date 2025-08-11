import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:peckme/controller/child_executive_controller.dart' hide sendMultipleLeadTransfer;
import 'package:peckme/model/child_executive_model.dart';
import 'package:peckme/utils/app_constant.dart';
import 'package:peckme/view/dashboard_screen.dart';
import 'package:peckme/view/received_lead_screen.dart';

import '../controller/multiple_lead_transfer_controller.dart';
import '../model/new_lead_model.dart';

class ChildExecutiveScreen extends StatefulWidget {
  final Map<String,dynamic> data;

   ChildExecutiveScreen({super.key, required this.data});

  @override
  State<ChildExecutiveScreen> createState() => _ChildExecutiveScreenState();
}

class _ChildExecutiveScreenState extends State<ChildExecutiveScreen> {
  ChildExecutiveController childExecutiveController = ChildExecutiveController();
  List<ChildExecutiveModel> leadsList = [];
  bool isLoading = true;

  List<ChildExecutiveModel> selectedLeads = [];
  List<int> selectedIndexes = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      List<ChildExecutiveModel> fetchedLeads = await childExecutiveController.fetchChildExecutives(
       "7494"
      );

      setState(() {
        leadsList = fetchedLeads;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching leads: $e');
    }
  }

  void toggleSelection(int index) {
    setState(() {
      final childLead = leadsList[index];

      if (selectedIndexes.contains(index)) {
        selectedIndexes.remove(index);
        selectedLeads.removeWhere((l) => l.cid == childLead.cid);
      } else {
        selectedIndexes.add(index);
        selectedLeads.add(childLead as ChildExecutiveModel);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appInsideColor,
        title: const Text('Child Excutive Lead', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : leadsList.isEmpty
          ? const Center(child: Text('No child found.'))
          : ListView.builder(
        itemCount: leadsList.length,
        itemBuilder: (context, index) {
          final lead = leadsList[index];
          final isSelected = selectedIndexes.contains(index);

          return Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 10.0),
            child: Card(
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 8.0, vertical: 8.0),
                title: Text(
                  lead.cid,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Row(
                    children: [
                      Text("LeadId : ${lead.fname},  ",
                        style: const TextStyle(color: Colors.grey,fontSize: 12),
                      ),
                      Text("${lead.address}",
                        style: const TextStyle(color: Colors.grey,fontSize: 12),
                      ),
                    ],
                  ),
                ),
                trailing: Checkbox(
                  value: isSelected,
                  onChanged: (_) => toggleSelection(index),
                  activeColor: Colors.blueAccent,
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(12),
        child: ElevatedButton(
          onPressed: selectedLeads.isNotEmpty
              ? () async {
            final dynamic rawLeadIds = widget.data['lead_id'];
            List<String> leadIds = [];
            if (rawLeadIds is List) {
              for (var item in rawLeadIds) {
                if (item is Map<String, dynamic> && item.containsKey('leadid')) {
                  leadIds.add(item['leadid'].toString());
                }
              }
            }
            if (leadIds.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No valid lead IDs found.')));
              return;
            }
            // 3. Create the final list of data for the API payload.
            List<Map<String, dynamic>> payloadData = [];
            for (var selectedLead in selectedLeads) {
              for (var leadId in leadIds) {
                payloadData.add({
                  "user_id": "7494",
                  "child_user_id": selectedLead.cid,
                  "lead_id": leadId,
                });
              }
            }

            // 4. Wrap the data in the final payload map.
            Map<String, dynamic> finalPayload = {
              "data": payloadData,
            };

            // Print the final payload to verify the structure.
            print("---------------------------------------\n  \n ----------------");
            print(finalPayload);
            print("---------------------------------------\n  \n ----------------");
            try {
              final response = await sendMultipleLeadTransfer(dataList: payloadData);
              print("---------------------------------------\n $response \n ----------------");
              if (response != null && response['success'] == 1) {
                Get.snackbar("Success", response['message'] ?? "Leads transferred successfully.");
                Get.to(() => const ReceivedLeadScreen());
              } else {
                Get.snackbar("Error", response?['message'] ?? "Failed to transfer leads.");
              }
            } catch (e) {
              Get.snackbar("Error", "An unexpected error occurred: $e");
            }
            //Get.snackbar("Transfer Lead.", "transfer lead successfully..!!");
            //Get.to(()=>ReceivedLeadScreen());

            // You can now proceed with your API call logic here
            // ... (your existing API call logic)

          }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor:AppConstant.appInsideColor,

            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1)),
          ),
          child: Text('CONTINUE (${selectedLeads.length})',style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}