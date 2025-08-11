import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:peckme/view/child_executive_screen.dart';
import 'package:peckme/view/postponed_lead_screen.dart';
import 'package:peckme/view/refix_lead_screen.dart';
import 'package:peckme/view/widget/webview_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher.dart' as intent;

import '../controller/lead_detail_controller.dart';
import '../model/lead_detail_model.dart';
import '../model/new_lead_model.dart';
import '../services/SDKLauncher.dart';
import '../services/getCurrentLocation.dart';
import '../utils/app_constant.dart';

class LeadDetailScreen extends StatefulWidget {
  Lead lead;
   LeadDetailScreen({super.key, required this.lead});

  @override
  State<LeadDetailScreen> createState() => _LeadDetailScreenState();
}

class _LeadDetailScreenState extends State<LeadDetailScreen> {


  Future<LeadResponse?>? _futureLead;
  final platform=const MethodChannel("com.example.peckme/channel1");
  String user_id = '';
  void loadUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {

      user_id = prefs.getString('uid') ?? '';

    });
  }
  _callNativeMethod({
    required String clientId,
    required String leadId,
    required String customerName,
    required String sessionId,
    required String amzAppID,
    required String user_id,
    required String branch_id,
    required String auth_id,
    required String client_lead_id,
    required String gpslat,
    required String gpslong,
    required String banID,
    required String userName,
    required String athena_lead_id,
    required String agentName,
    }) async{
    try{
      //it should be same on the flutter side and native side method name
      // String message=await platform.invokeMethod("callNativeMethod");
      final result = await platform.invokeMethod('callNativeMethod', {
        "client_id": clientId, // You can change this dynamically
        "lead_id": leadId, // You can change this dynamically
        "sessionId": sessionId, // You can change this dynamically
        "amzAppID": amzAppID,
        "customerName": customerName, // You can change this dynamically
        "user_id": user_id,
        "branch_id": branch_id,
        "auth_id": auth_id,
        "client_lead_id": client_lead_id,
        "gpslat": gpslat,
        "gpslong": gpslong,
        "banID": banID,
        "userName": userName,
        "athena_lead_id": athena_lead_id,
        "agentName": agentName,

      });
      print("Result from native: $result");
      Get.snackbar("Message from native", '$result',
        backgroundColor:AppConstant.appSnackBarBackground, // Background color of the snackbar
        colorText: Colors.black, // Color of the title and message text
        snackPosition: SnackPosition.TOP, // Position of the snackbar (TOP or BOTTOM)
        margin: const EdgeInsets.all(10), // Margin around the snackbar
        borderRadius: 10, // Border radius of the snackbar
        animationDuration: const Duration(milliseconds: 500), // Animation duration
        duration: const Duration(seconds: 3), // Duration the snackbar is displayed
        icon: const Icon(Icons.error, color: Colors.black), // Optional icon
        shouldIconPulse: true, // Whether the icon should pulse
        isDismissible: true, // Whether the snackbar can be dismissed by swiping
        dismissDirection: DismissDirection.horizontal,);
    }on PlatformException catch(e){
      print("Exception while calling Native Method  : $e");
    }
  }
  void openNXTServices() {
    launchOtherApp('https://oapnext.icicibank.com:8443/OAPNxtService/zct/SessionService/escpGetSessionId'); // Example deep link for Facebook Lite
    // Or, if you know the package ID for Android:
    // launchOtherApp('market://details?id=com.facebook.lite'); // Opens Play Store page
  }

  // Function to launch another app
  Future<void> launchOtherApp(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      // Handle the case where the app cannot be launched (e.g., app not installed)
      print('Could not launch $url');
      // Optionally, redirect to the app store
      // await launchUrl(Uri.parse('https://play.google.com/store/apps/details?id=com.example.otherapp'));
    }
  }

  String location_lat = '';
  String location_long = '';
  void _getLocation() async {
    try {
      Position position = await getCurrentLocation();
      setState(() {
        location_lat = '${position.latitude}';
        location_long = '${position.longitude}';
      });
    } catch (e) {
      setState(() {
        location_lat = 'Error: ${e.toString()}';
        location_long = 'Error: ${e.toString()}';
      });
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureLead = LeadDetailsController.fetchLeadById(widget.lead.leadId);
    _getLocation();
    loadUserData();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:AppConstant.appInsideColor,
        title: Text('Lead Details ',style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),),
          iconTheme: IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<LeadResponse?>(
      future: _futureLead,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData && snapshot.data!.data.isNotEmpty) {
          final lead = snapshot.data!.data[0]; // Get the first item
          final String? callDate = lead.callDate;

          print("Shubham id :$callDate");
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Text(location_lat+location_long),

                  Card(
                    color: Colors.white,
                    elevation: 5,
                    child: Container(
                      //color: Colors.white,
                      height: MediaQuery.of(context).size.height*0.4,
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text("Lead_id - ", style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.black)),
                                          Text(lead.leadId, style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.black,fontSize: 12)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text("Client_id - ", style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.black)),
                                        Text(lead.clientId, style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.black,fontSize: 12)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text("Customer Name - ", style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.black)),
                                          Text(lead.customerName, style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.black,fontSize: 12)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),


                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text("Address - ", style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.black)),
                                          Expanded(child: Text(lead.resAddress,textAlign:TextAlign.left,maxLines: 6,overflow: TextOverflow.clip, style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.black,fontSize: 12))),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),


                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text("Customer Name - ", style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.black)),
                                          Text(lead.customerName, style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.black,fontSize: 12)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),


                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  Divider(),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.9,
                          child: ElevatedButton(
                            onPressed: () async {
                              List<Map<String, dynamic>> leadData = [];

                              // 2. Iterate through the selectedLeads and format each one

                                leadData.add({
                                  "leadid": lead.leadId, // Get the lead ID from the current lead object
                                });


                              // 3. Wrap the list in the final parent map
                              Map<String, dynamic> finalPayload = {
                                "lead_id": leadData,
                              };
                              Get.to(()=>ChildExecutiveScreen(data:finalPayload));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppConstant.appBattonBack,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            ),
                            child: Text('Transfer Lead'.toUpperCase(),style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      ),
            
            
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: (){
                            Get.to(()=>PostponeLeadScreen(leadId:lead.leadId.toString(),customer_name:lead.customerName.toString(),location:lead.location));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppConstant.appBattonBack,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          ),
                          child:   Text('Postponed', style: TextStyle(color: Colors.white,fontSize: 15,fontWeight:FontWeight.normal)),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: ElevatedButton(

                          onPressed: (){
                            Get.to(()=>RefixLeadScreen(leadId:lead.leadId.toString(),customer_name:lead.customerName.toString()));
                          },
                          style: ElevatedButton.styleFrom(

                            backgroundColor: AppConstant.appBattonBack,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          ),
                          child:   Text('Reflix', style: TextStyle(color: Colors.white,fontSize: 15,fontWeight:FontWeight.normal)),
                        ),
                      ),
            
                    ],
                  ),
                  lead.client_mobile_app=="1"?
                    lead.clientId=="11"?
                    ElevatedButton(
                      onPressed: ()  async {
                        String name = '';
                        String uid = '';
                        String branchId = '';
                        String authId = '';
                        String userToken='';
                        final SharedPreferences prefs = await SharedPreferences.getInstance();
                        setState(() {
                          name = prefs.getString('name') ?? '';
                          uid = prefs.getString('uid') ?? '';
                          branchId = prefs.getString('branchId') ?? '';
                          userToken = prefs.getString('userToken') ?? '';
                          authId = prefs.getString('authId') ?? '';
                        });
                        _callNativeMethod(
                          clientId: lead.clientId,
                          leadId: lead.leadId,
                          sessionId: userToken,
                          amzAppID: lead.athenaLeadId,
                          customerName: lead.customerName,
                          banID:authId,
                          userName:authId,
                          athena_lead_id:lead.athenaLeadId,
                          agentName:name,
                          user_id: uid,
                          branch_id: branchId,
                          auth_id: authId,
                          client_lead_id:lead.athenaLeadId,
                          gpslat:location_lat,
                          gpslong:location_long,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:  AppConstant.appBattonBack,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      ),
                      child: const  Center(child: Text('Start Biometrics', style: TextStyle(color: Colors.white,fontSize: 15,fontWeight:FontWeight.normal))),
                    ):
                    lead.clientId=="89"?
                    ElevatedButton(
                      onPressed: (){
                        Get.snackbar("Onfield Prepaid", 'Onfield Prepaid Card',
                          backgroundColor:AppConstant.appSnackBarBackground, // Background color of the snackbar
                          colorText: Colors.black, // Color of the title and message text
                          snackPosition: SnackPosition.TOP, // Position of the snackbar (TOP or BOTTOM)
                          margin: const EdgeInsets.all(10), // Margin around the snackbar
                          borderRadius: 10, // Border radius of the snackbar
                          animationDuration: const Duration(milliseconds: 500), // Animation duration
                          duration: const Duration(seconds: 3), // Duration the snackbar is displayed
                          icon: const Icon(Icons.error, color: Colors.black), // Optional icon
                          shouldIconPulse: true, // Whether the icon should pulse
                          isDismissible: true, // Whether the snackbar can be dismissed by swiping
                          dismissDirection: DismissDirection.horizontal,);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:  AppConstant.appBattonBack,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      ),
                      child: const  Center(child: Text('Add Details',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white,fontSize: 15,fontWeight:FontWeight.normal,fontFamily: 'impact',))),
                    ):
                    lead.clientId=="38"?
                    ElevatedButton(
                      onPressed: () async{
                        String name = '';
                        String uid = '';
                        String branchId = '';
                        String authId = '';
                        String userToken='';
                        final SharedPreferences prefs = await SharedPreferences.getInstance();
                        setState(() {
                          name = prefs.getString('name') ?? '';
                          uid = prefs.getString('uid') ?? '';
                          branchId = prefs.getString('branchId') ?? '';
                          userToken = prefs.getString('userToken') ?? '';
                          authId = prefs.getString('authId') ?? '';
                        });
                        _callNativeMethod(
                          clientId: lead.clientId,
                          leadId: lead.leadId,
                          sessionId: userToken,
                          amzAppID: lead.athenaLeadId,
                          customerName: lead.customerName,
                          banID:authId,
                          userName:authId,
                          athena_lead_id:lead.athenaLeadId,
                          agentName:name,
                          user_id: uid,
                          branch_id: branchId,
                          auth_id: authId,
                          client_lead_id:lead.athenaLeadId,
                          gpslat:location_lat,
                          gpslong:location_long,
                        );
                        openNXTServices();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppConstant.appBattonBack,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      ),
                      child: const  Center(child: Text('OAPNxt App', style: TextStyle(color: Colors.white,fontSize: 15,fontWeight:FontWeight.normal))),
                    ):
                    lead.clientId=="28"?
                    ElevatedButton(
                      onPressed: () async{
                        String name = '';
                        String uid = '';
                        String branchId = '';
                        String authId = '';
                        String userToken='';
                        final SharedPreferences prefs = await SharedPreferences.getInstance();
                        setState(() {
                          name = prefs.getString('name') ?? '';
                          uid = prefs.getString('uid') ?? '';
                          branchId = prefs.getString('branchId') ?? '';
                          userToken = prefs.getString('userToken') ?? '';
                          authId = prefs.getString('authId') ?? '';
                        });
                        _callNativeMethod(
                          clientId: lead.clientId,
                          leadId: lead.leadId,
                          sessionId: userToken,
                          amzAppID: lead.athenaLeadId,
                          customerName: lead.customerName,
                          banID:authId,
                          userName:authId,
                          athena_lead_id:lead.athenaLeadId,
                          agentName:name,
                          user_id: uid,
                          branch_id: branchId,
                          auth_id: authId,
                          client_lead_id:lead.athenaLeadId,
                          gpslat:location_lat,
                          gpslong:location_long,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:  AppConstant.appBattonBack,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      ),
                      child: const  Center(child: Text('Opennxt Assisted', style: TextStyle(color: Colors.white,fontSize: 15,fontWeight:FontWeight.normal))),
                    ):
                    ElevatedButton(
                      onPressed: ()async{
                        String name = '';
                        String uid = '';
                        String branchId = '';
                        String authId = '';
                        String userToken='';
                        final SharedPreferences prefs = await SharedPreferences.getInstance();
                        setState(() {
                          name = prefs.getString('name') ?? '';
                          uid = prefs.getString('uid') ?? '';
                          branchId = prefs.getString('branchId') ?? '';
                          userToken = prefs.getString('userToken') ?? '';
                          authId = prefs.getString('authId') ?? '';
                        });
                        _callNativeMethod(
                          clientId: lead.clientId,
                          leadId: lead.leadId,
                          sessionId: userToken,
                          amzAppID: lead.athenaLeadId,
                          customerName: lead.customerName,
                          banID:authId,
                          userName:authId,
                          athena_lead_id:lead.athenaLeadId,
                          agentName:name,
                          user_id: uid,
                          branch_id: branchId,
                          auth_id: authId,
                          client_lead_id:lead.athenaLeadId,
                          gpslat:location_lat,
                          gpslong:location_long,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:  AppConstant.appBattonBack,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      ),
                      child: const  Center(child: Text('Open ICICI App', style: TextStyle(color: Colors.white,fontSize: 15,fontWeight:FontWeight.normal))),
                    ):
                  lead.client_mobile_app=="2"?
                    lead.fiData==1?
                    ElevatedButton(
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppConstant.appBattonBack,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      ),
                      child: const  Center(child: Text('Select Doc', style: TextStyle(color: Colors.white,fontSize: 15,fontWeight:FontWeight.normal))),
                    ):
                    lead.clientId=="61"?ElevatedButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => WebViewScreen(
                              url:"https://fms.bizipac.com/apinew/apps1/index.php?lead_id=${lead.leadId}#!/",
                              customerName:lead.customerName,
                              client: lead.clientName,
                              leadid: lead.leadId,
                                fidatal:lead.fiData,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:  AppConstant.appBattonBack,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      ),
                      child: const  Center(child: Text('Field Invest', style: TextStyle(color: Colors.white,fontSize: 15,fontWeight:FontWeight.normal))),
                    ):lead.clientId=="63"?ElevatedButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => WebViewScreen(
                              url:"https://fms.bizipac.com/apinew/apps1/index.php?lead_id=${lead.leadId}#!/",
                              customerName:lead.customerName,
                              client: lead.clientName,
                              leadid: lead.leadId,
                              fidatal:lead.fiData,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:  AppConstant.appBattonBack,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      ),
                      child: const  Center(child: Text('Field Invest', style: TextStyle(color: Colors.white,fontSize: 15,fontWeight:FontWeight.normal))),
                    ):lead.clientId=="68"?ElevatedButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => WebViewScreen(
                              url:"https://fms.bizipac.com/apinew/chola_fi/index.php?lead_id=${lead.leadId}#!/",
                              customerName:lead.customerName,
                              client: lead.clientName,
                              leadid: lead.leadId,
                              fidatal:lead.fiData,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:  AppConstant.appBattonBack,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      ),
                      child: const  Center(child: Text('Field Invest', style: TextStyle(color: Colors.white,fontSize: 15,fontWeight:FontWeight.normal))),
                    ):lead.clientId=="71"?ElevatedButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => WebViewScreen(
                              url:"https://fms.bizipac.com/apinew/paysense_fi/index.php?lead_id=${lead.leadId}#!/",
                              customerName:lead.customerName,
                              client: lead.clientName,
                              leadid: lead.leadId,
                              fidatal:lead.fiData,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:  AppConstant.appBattonBack,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      ),
                      child: const  Center(child: Text('Field Invest', style: TextStyle(color: Colors.white,fontSize: 15,fontWeight:FontWeight.normal))),
                    ):lead.clientId=="72"?ElevatedButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => WebViewScreen(
                              url:"https://fms.bizipac.com/apinew/tata_fi/index.php?lead_id=${lead.leadId}#!/",
                              customerName:lead.customerName,
                              client: lead.clientName,
                              leadid: lead.leadId,
                              fidatal:lead.fiData,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:  AppConstant.appBattonBack,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      ),
                      child: const  Center(child: Text('Field Invest', style: TextStyle(color: Colors.white,fontSize: 15,fontWeight:FontWeight.normal))),
                    ):lead.clientId=="75"?ElevatedButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => WebViewScreen(
                              url:"https://fms.bizipac.com/apinew/hytone_fi/index.php?lead_id=${lead.leadId}#!/",
                              customerName:lead.customerName,
                              client: lead.clientName,
                              leadid: lead.leadId,
                              fidatal:lead.fiData,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:  AppConstant.appBattonBack,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      ),
                      child: const  Center(child: Text('Field Invest', style: TextStyle(color: Colors.white,fontSize: 15,fontWeight:FontWeight.normal))),
                    ):lead.clientId=="79"?ElevatedButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => WebViewScreen(
                              url:"https://fms.bizipac.com/apinew/fmec_fi/index.php?lead_id=${lead.leadId}#!/",
                              customerName:lead.customerName,
                              client: lead.clientName,
                              leadid: lead.leadId,
                              fidatal:lead.fiData,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:  AppConstant.appBattonBack,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      ),
                      child: const  Center(child: Text('Field Invest', style: TextStyle(color: Colors.white,fontSize: 15,fontWeight:FontWeight.normal))),
                    ):lead.clientId=="80"?ElevatedButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => WebViewScreen(
                              url:"https://fms.bizipac.com/apinew/fmec_Rem_fi/index.php?lead_id=${lead.leadId}#!/",
                              customerName:lead.customerName,
                              client: lead.clientName,
                              leadid: lead.leadId,
                              fidatal:lead.fiData,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:  AppConstant.appBattonBack,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      ),
                      child: const  Center(child: Text('Field Invest', style: TextStyle(color: Colors.white,fontSize: 15,fontWeight:FontWeight.normal))),
                    ):ElevatedButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => WebViewScreen(
                              url:"https://fms.bizipac.com/fi/index.php?lead_id=${lead.leadId}#!/",
                              customerName:lead.customerName,
                              client: lead.clientName,
                              leadid: lead.leadId,
                              fidatal:lead.fiData,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:  AppConstant.appBattonBack,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      ),
                      child: const  Center(child: Text('Field Invest', style: TextStyle(color: Colors.white,fontSize: 15,fontWeight:FontWeight.normal))),
                    ):
                  lead.client_mobile_app=="3"?
                  ElevatedButton(
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      backgroundColor:  AppConstant.appBattonBack,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    ),
                    child: const  Center(child: Text('Open fi url', style: TextStyle(color: Colors.white,fontSize: 15,fontWeight:FontWeight.normal))),
                  ):ElevatedButton(
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstant.appBattonBack,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    ),
                    child: const Center(
                        child: Text('Select doc',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight:FontWeight.normal
                            )
                        )
                    ),
                  ),lead.clientId==49?Text("Message (Bank Bazar staus ${lead.surrogate})",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 15,
                        fontWeight:FontWeight.bold
                    ),):Text(''),
                  ElevatedButton(
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      backgroundColor:  Colors.green,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    ),
                    child: const  Center(child: Text('Status', style: TextStyle(color: Colors.white,fontSize: 15,fontWeight:FontWeight.normal))),
                  ),
                  ElevatedButton(
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstant.appInsideColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    ),
                    child: const  Center(child: Text('Generate Submission Result', style: TextStyle(color: Colors.white,fontSize: 15,fontWeight:FontWeight.normal))),
                  ),
                ],
                
              ),
            ),
          );
        } else {
          return const Center(child: Text("No lead found."));
        }
      },
    ),

    );
  }
}
