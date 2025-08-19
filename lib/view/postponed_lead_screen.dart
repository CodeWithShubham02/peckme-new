import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../controller/postponed_lead_controller.dart';
import '../model/reason_item_model.dart';
import '../services/reasom_services.dart';
import '../utils/app_constant.dart';

class PostponeLeadScreen extends StatefulWidget {
  final String leadId;
  final String customer_name;
  final String location;
  PostponeLeadScreen({super.key, required this.leadId, required this.customer_name, required this.location});

  @override
  State<PostponeLeadScreen> createState() => _PostponeLeadScreenState();
}

class _PostponeLeadScreenState extends State<PostponeLeadScreen> {

  //fetch reason start code
  List<ReasonItem> reasons = [];
  String? selectedReason;
  final TextEditingController remark=TextEditingController();
  void loadReasons() async {
    try {
      final fetchedReasons = await ReasonService.fetchReasons(widget.leadId);
      setState(() {
        reasons = fetchedReasons;
      });
    } catch (e) {
      print("Error loading reasons: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load reasons")),
      );
    }
  }
  //end fetch reason code here

  String currentDate = "";
  String currentTime = "";

  void setCurrentDate() {
    DateTime now = DateTime.now();
    setState(() {
      currentDate = '${now.day}-${now.month}-${now.year}';
      currentTime = '${now.hour}:${now.minute}:${now.second}';
      print(currentDate);  // optional
    });
  }
  String _location = '';
  String uid = '';
  Future<void> loadUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    uid = prefs.getString('uid') ?? '';
  }
  @override
  void initState() {
    super.initState();
    setCurrentDate();
    loadReasons();
    loadUserData();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appInsideColor,
        title:  Text(widget.customer_name.toString(),
          style: TextStyle(color: AppConstant.appTextColor,fontSize: 17),
        ),
          iconTheme: IconThemeData(color:AppConstant.appIconColor),
      ),
      body:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(widget.location.toString()),
            // Text(widget.leadId.toString()),
            // Text(uid.toString()),
            // Text(currentDate.toString()),
            // Text(currentTime.toString()),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Select reason for Refix Appointment : *',style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold,fontFamily: 'RaleWay'),),
            ),
            reasons.isEmpty?CircularProgressIndicator()
                : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      hint: Text('Select Reason',style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal),),
                      value: selectedReason,
                      items: reasons.map((item) {
                        return DropdownMenuItem<String>(
                          value: item.reason,
                          child: Text(item.reason,style: TextStyle(fontSize: 11.5,color: Colors.black,fontWeight: FontWeight.bold),),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedReason = value;
                        });
                      },
                      decoration:  InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Enter remarks for Refix Appointment : ',style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold,fontFamily: 'RaleWay'),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: remark,
                decoration: InputDecoration(
                    hint: Text("Enter here remark?"),
                    border: OutlineInputBorder()
                ),
              ),
            ),

          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity, // 👈 full width
            height: 50,             // 👈 fixed height
            child: ElevatedButton(
              onPressed: () async {
                try {
                  final result = await postponeLead(
                    loginId:uid.toString(),
                    leadId: widget.leadId.toString(),
                    remark: remark.toString(),
                    location:widget.location.toString(),
                    reason: selectedReason!,
                    newDate: currentDate,
                    newTime:currentTime,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(result.message)),

                  );
                  Navigator.pop(context);
                } catch (e) {
                  print("Error: $e");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Failed to postpone lead")),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:AppConstant.appBattonBack, // 👈 button color
                foregroundColor: AppConstant.appTextColor,      // 👈 text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // 👈 rounded corners
                ),
                elevation: 4, // 👈 shadow
              ),
              child: const Text(
                "Postpone Lead",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
