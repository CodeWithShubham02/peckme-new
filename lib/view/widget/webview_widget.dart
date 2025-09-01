import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:peckme/utils/app_constant.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  final String customerName;
  final String leadid;
  final String client;
  final int fidatal;

   WebViewScreen({Key? key,
     required this.customerName,
     required this.leadid,
     required this.client,
     required this.url,
     required this.fidatal}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    // Initialize controller
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60), // Set custom height here

        child: AppBar(
          backgroundColor: AppConstant.appInsideColor,
          iconTheme: IconThemeData(color: Colors.white),
          title: Container(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // optional: aligns text left
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("CustomerName : ", style: TextStyle(fontSize: 13,color: Colors.white)),
                      Expanded(child: Text("${widget.customerName}", style: TextStyle(fontSize: 13,color: Colors.white), overflow: TextOverflow.fade,maxLines: 1,)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("LeadId : ", style: TextStyle(fontSize: 13,color: Colors.white)),
                      Text("${widget.leadid}", style: TextStyle(fontSize: 13,color: Colors.white)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("ClientName : ", style: TextStyle(fontSize: 13,color: Colors.white)),
                      Text("${widget.client}", style: TextStyle(fontSize: 13,color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(child: WebViewWidget(controller: _controller)),
      floatingActionButton:Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: (){
              if(widget.fidatal==1){
                Text("Document upload");
              }else{
                Get.snackbar("Remember this", 'Kindly complete FI Properly. Follow the instruction.',
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
              }
            },
            child: Container(
                height: 40,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(child: Text("Document Upload"))),
          )
        ],
      )
    );
  }
}
