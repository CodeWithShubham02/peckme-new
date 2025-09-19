import 'dart:async';
import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:peckme/services/fcm_service.dart';
import 'package:peckme/services/notification_service.dart';
import 'package:peckme/view/notification/send_notification_screen.dart';
import 'package:peckme/view/profile_screen.dart';
import 'package:peckme/view/received_lead_screen.dart';
import 'package:peckme/view/self_lead_alloter_screen.dart';
import 'package:peckme/view/today_completed_lead_screen.dart';
import 'package:peckme/view/today_transferd_lead_screen.dart';
import 'package:peckme/view/transfer_lead_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/lead_status_services.dart';
import '../services/get_server_key.dart';
import '../utils/app_constant.dart';
import 'auth/login.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final Connectivity _connectivity = Connectivity();
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  bool _isDialogShowing = false; // track karega dialog chal raha hai ya nahi

  String name = '';
  String mobile = '';
  String uid = '';
  String rolename = '';
  String roleId = '';
  String branchId = '';
  String branch_name = '';
  String authId = '';
  String image = '';
  String address = '';

  void openIciciActivity() async {
    final intent = AndroidIntent(
      componentName: 'com.bcpl.icici.IciciActivity', // AAR वाली Activity
      package: 'com.example.peckme', // ⚠️ यह आपके app का packageName होना चाहिए
      flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
    );

    await intent.launch();
  }

  void loadUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? '';
      mobile = prefs.getString('mobile') ?? '';
      uid = prefs.getString('uid') ?? '';
      rolename = prefs.getString('rolename') ?? '';
      roleId = prefs.getString('roleId') ?? '';
      branchId = prefs.getString('branchId') ?? '';
      branch_name = prefs.getString('branch_name') ?? '';
      authId = prefs.getString('authId') ?? '';
      image = prefs.getString('image') ?? '';
      address = prefs.getString('address') ?? '';
    });
  }

  DateTime _currentTime = DateTime.now();

  // A Timer variable to control the periodic updates.
  late Timer _timer;

  //user permission allow
  NotificationService notificationService = NotificationService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationService.requestNotificationPermission();
    FCMService.firebaseInit();
    notificationService.firebaseInit(context);
    notificationService.setupInteractMessage(context);

    loadUserData();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
    _checkConnection();
    // Listen continuously
    _connectivity.onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) {
      final result = results.isNotEmpty
          ? results.first
          : ConnectivityResult.none;

      setState(() {
        _connectionStatus = result;
      });

      if (result == ConnectivityResult.none) {
        _showNoInternetDialog();
      } else {
        _closeDialogIfOpen();
      }
    });
  }

  Future<void> _checkConnection() async {
    final result = await _connectivity.checkConnectivity();
    setState(() {
      _connectionStatus = result as ConnectivityResult;
    });

    if (result == ConnectivityResult.none) {
      _showNoInternetDialog();
    }
  }

  void _launchInBrowser(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _showNoInternetDialog() {
    if (!_isDialogShowing && mounted) {
      _isDialogShowing = true;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text("No Internet"),
            content: const Text(
              "Your internet is off. Please check WiFi or Mobile Data.",
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  _isDialogShowing = false;
                  Navigator.of(context).pop();

                  // ✅ Close the app
                  if (Platform.isAndroid) {
                    SystemNavigator.pop(); // Android style close
                  } else if (Platform.isIOS) {
                    exit(
                      0,
                    ); // iOS में यह Apple guideline के खिलाफ है, लेकिन काम करेगा
                  } else {
                    exit(0); // fallback
                  }
                },
                child: const Text("Retry & Exit"),
              ),
            ],
          );
        },
      ).then((_) {
        _isDialogShowing = false;
      });
    }
  }

  void _closeDialogIfOpen() {
    if (_isDialogShowing && Navigator.canPop(context)) {
      Navigator.of(context).pop(); // close dialog
      _isDialogShowing = false;
    }
  }

  String getConnectionType() {
    switch (_connectionStatus) {
      case ConnectivityResult.wifi:
        return "✅ Connected via WiFi";
      case ConnectivityResult.mobile:
        return "✅ Connected via Mobile Data";
      case ConnectivityResult.none:
        return "❌ No Internet";
      default:
        return "Unknown";
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String timeString =
        '${_currentTime.hour.toString().padLeft(2, '0')}:'
        '${_currentTime.minute.toString().padLeft(2, '0')}:'
        '${_currentTime.second.toString().padLeft(2, '0')}';
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: AppConstant.appInsideColor,
        title: Text("Peak Me ", style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => ProfileScreen());
            },
            icon: Icon(Icons.person_pin, color: Colors.black),
          ),
          IconButton(
            onPressed: () async {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text("Logout", style: TextStyle(fontSize: 20)),
                  content: Text(
                    "are you sure you want to logout of your account?",
                  ),
                  actions: [
                    IconButton(
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      icon: Text('No'),
                    ),
                    IconButton(
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.clear();
                        Get.offAll(() => Login());
                      },
                      icon: Text('Yes'),
                    ),
                  ],
                  elevation: 10,
                  backgroundColor: Colors.white,
                ),
              );
            },
            icon: Icon(Icons.logout, color: Colors.black),
            onLongPress: () async {
              // 1️⃣ Fetch server key first
              GetServerKey getServerKey = GetServerKey();
              String? serverKey = await getServerKey.getServerKeyToken();
              print("----------------------");
              print(serverKey);
              print("------------------------");

              // 2️⃣ Show password dialog
              TextEditingController _passwordController =
                  TextEditingController();
              bool passwordCorrect = false;

              await showDialog(
                context: context,
                barrierDismissible: false, // user must tap OK or Cancel
                builder: (context) {
                  return AlertDialog(
                    title: Text("Enter Password"),
                    content: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(hintText: "Password"),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Cancel pressed
                        },
                        child: Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_passwordController.text.trim() == "1111") {
                            passwordCorrect = true;
                            Navigator.of(context).pop();
                          } else {
                            // Optional: show error
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Incorrect password")),
                            );
                          }
                        },
                        child: Text("OK"),
                      ),
                    ],
                  );
                },
              );

              // 3️⃣ Navigate only if password correct
              if (passwordCorrect) {
                Get.to(() => SendMessageScreen(serverKeys: serverKey));
              }
            },
          ),
        ],
      ),
      // drawer: AdminDrawerWidget(),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white24,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 100,
                      width: 150,
                      decoration: BoxDecoration(
                        color: AppConstant.appBattonBack,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 5,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(16),
                      child: InkWell(
                        onTap: () {
                          Get.to(() => ReceivedLeadScreen());
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.dashboard,
                              size: 30,
                              color: Colors.black87,
                            ),
                            SizedBox(height: 12),
                            Text(
                              "Pending Lead's",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 150,
                      decoration: BoxDecoration(
                        color: AppConstant.appBattonBack,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 5,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(16),
                      child: InkWell(
                        onTap: () {
                          Get.to(() => TransferLeadScreen());
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.transfer_within_a_station_outlined,
                              size: 30,
                              color: Colors.black87,
                            ),
                            SizedBox(height: 12),
                            Text(
                              "Transfer Lead's ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 100,
                      width: 150,
                      decoration: BoxDecoration(
                        color: AppConstant.appBattonBack,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 5,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(16),
                      child: InkWell(
                        onTap: () {
                          Get.to(
                            () => LeadCheckScreen(uid: uid, branchId: branchId),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.wallet, size: 30, color: Colors.black87),
                            SizedBox(height: 12),
                            Text(
                              "Self Lead's Alloter",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 150,
                      decoration: BoxDecoration(
                        color: AppConstant.appBattonBack,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 5,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(16),
                      child: InkWell(
                        onTap: () {
                          _launchInBrowser(
                            'https://fms.bizipac.com/apinew/secureapi/icici_pre_paid_card_gen.php?user_id=$uid&branch_id=$branchId#!/',
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.card_travel_outlined,
                              size: 22,
                              color: Colors.black87,
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Submission's ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 100,
                      width: 150,
                      decoration: BoxDecoration(
                        color: AppConstant.appBattonBack,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 5,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(16),
                      child: InkWell(
                        onTap: () {
                          final service = LeadService(
                            baseUrl: "https://fms.bizipac.com/apinew/ws_new",
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => LeadStatusScreen(
                                uid: uid,
                                branchId: branchId,
                                service: service,
                              ),
                            ),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.file_copy_outlined,
                              size: 22,
                              color: Colors.black87,
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Today's Completed Lead's ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 150,
                      decoration: BoxDecoration(
                        color: AppConstant.appBattonBack,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 5,
                            offset: Offset(1, 4),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(16),
                      child: InkWell(
                        onTap: () {
                          Get.to(
                            () => TodayTransferredScreen(uid: uid.toString()),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.transfer_within_a_station_outlined,
                              size: 22,
                              color: Colors.black87,
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Today's Transfer Lead",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 100,
                      width: 150,
                      decoration: BoxDecoration(
                        color: AppConstant.appBattonBack,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 5,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(16),
                      child: InkWell(
                        onTap: () async {
                          GetServerKey getServerKey = GetServerKey();
                          String? serverKey = await getServerKey
                              .getServerKeyToken();
                          print("----------------------");
                          print(serverKey);
                          print("------------------------");
                          Get.to(() => ProfileScreen());
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person_3_sharp,
                              size: 30,
                              color: Colors.black87,
                            ),
                            SizedBox(height: 12),
                            Text(
                              "Profile",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 150),

                Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Current Time : ".toUpperCase(),
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            timeString,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.normal,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Icons.access_time,
                            size: 10,
                            color: Colors.black87,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Version : ",
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            '1.0.01',
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Icons.verified_outlined,
                            size: 10,
                            color: Colors.black87,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Copyrights © 2025 All Rights Reserved by - ",
                                    maxLines: 2,
                                    style: TextStyle(fontSize: 9),
                                  ),
                                  Text(
                                    "Bizipac Couriers Pvt. Ltd.",
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
