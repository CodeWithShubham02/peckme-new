import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:peckme/utils/app_constant.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../received_lead_screen.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  final String customerName;
  final String leadid;
  final String client;
  final String clientid;

  const WebViewScreen({
    Key? key,
    required this.customerName,
    required this.leadid,
    required this.client,
    required this.url,
    required this.clientid,
  }) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen>
    with WidgetsBindingObserver {
  late WebViewController _controller;

  bool _isLoading = false;
  bool _browserOpened = false; // 👈 important flag

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    if (widget.clientid == "97" || widget.clientid == "87") {
      _openBrowser();
    } else {
      _initWebView();
    }
  }

  // ✅ WEBVIEW INIT
  Future<void> _initWebView() async {
    await _requestLocationPermission();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) {
            print("✅ Page Loaded: $url");
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));

    setState(() {});
  }

  // ✅ OPEN BROWSER
  Future<void> _openBrowser() async {
    Uri uri = Uri.parse(widget.url);

    if (await canLaunchUrl(uri)) {
      _browserOpened = true;

      await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
    } else {
      Get.snackbar("Error", "Could not open browser");
    }
  }

  // ✅ HANDLE APP RESUME (MOST IMPORTANT)
  bool _isFromBrowser = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed && _browserOpened) {
      print("🔄 App resumed from browser");

      if (_isFromBrowser) return; // prevent multiple calls
      _isFromBrowser = true;

      // 👇 IMPORTANT: delay lagao
      await Future.delayed(const Duration(seconds: 1));

      _browserOpened = false;

      _checkFiStatus();

      // reset after some time
      Future.delayed(const Duration(seconds: 2), () {
        _isFromBrowser = false;
      });
    }
  }

  // ✅ LOCATION PERMISSION
  Future<void> _requestLocationPermission() async {
    var status = await Permission.location.status;

    if (status.isDenied) {
      status = await Permission.location.request();
    }

    if (status.isPermanentlyDenied) {
      openAppSettings();
    }

    print("Permission: $status");
  }

  // ✅ FI STATUS API
  Future<void> _checkFiStatus() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    final String apiUrl =
        "https://fms.bizipac.com/apinew/ws_new/new_lead_detail.php?lead_id=${widget.leadid}";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        final firstItem = decoded["data"][0];
        int fiData = firstItem["fiData"] ?? 0;

        print("FI DATA: $fiData");

        if (fiData == 1) {
          Get.offAll(() => ReceivedLeadScreen());

          Get.rawSnackbar(
            message: "Upload the documents.!",
            backgroundColor: AppConstant.appBarColor,
          );
        } else {
          Get.rawSnackbar(
            message: "Complete FI properly!",
            backgroundColor: AppConstant.appBarColor,
          );
        }
      } else {
        Get.rawSnackbar(
          message: "Server Error: ${response.statusCode}",
          backgroundColor: AppConstant.appBarColor,
        );
      }
    } catch (e) {
      Get.snackbar("Error", "$e");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // ✅ UI
  @override
  Widget build(BuildContext context) {
    // 👇 client 97 ke case me blank screen avoid karne ke liye loader show karo
    if (widget.clientid == "97") {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appBarColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow("Customer: ", widget.customerName),
            _buildInfoRow("LeadId: ", widget.leadid),
            _buildInfoRow("Client: ", widget.client),
          ],
        ),
      ),
      body: SafeArea(child: WebViewWidget(controller: _controller)),

      // ✅ Upload Button
      floatingActionButton: InkWell(
        onTap: _isLoading ? null : _checkFiStatus,
        child: Container(
          height: 40,
          width: 120,
          decoration: BoxDecoration(
            color: _isLoading ? Colors.grey[300] : Colors.green[100],
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: _isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text(
                    "Document Upload",
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                  ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Text(label, style: const TextStyle(fontSize: 12)),
        Expanded(
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
}
