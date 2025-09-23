import 'package:flutter/material.dart';
import 'package:peckme/utils/app_constant.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  final String customerName;
  final String leadid;
  final String client;
  final int fidatal;

  WebViewScreen({
    Key? key,
    required this.customerName,
    required this.leadid,
    required this.client,
    required this.url,
    required this.fidatal,
  }) : super(key: key);

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
          backgroundColor: AppConstant.appBarColor,
          iconTheme: IconThemeData(color: Colors.white),
          title: Container(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // optional: aligns text left
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "CustomerName : ",
                        style: TextStyle(fontSize: 13, color: Colors.white),
                      ),
                      Expanded(
                        child: Text(
                          "${widget.customerName}",
                          style: TextStyle(fontSize: 13, color: Colors.white),
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "LeadId : ",
                        style: TextStyle(fontSize: 13, color: Colors.white),
                      ),
                      Text(
                        "${widget.leadid}",
                        style: TextStyle(fontSize: 13, color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "ClientName : ",
                        style: TextStyle(fontSize: 13, color: Colors.white),
                      ),
                      Text(
                        "${widget.client}",
                        style: TextStyle(fontSize: 13, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(child: WebViewWidget(controller: _controller)),
      // floatingActionButton:Row(
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     InkWell(
      //       onTap: (){
      //         if(widget.fidatal==1){
      //           Text("Document upload");
      //         }else{
      //           Get.snackbar(
      //             "Remember this!",
      //             "Kindly complete FI Properly. Follow the instruction.!",
      //             icon:  Image.asset(
      //               "assets/logo/cmp_logo.png",
      //               height: 30,
      //               width: 30,
      //             ),
      //             shouldIconPulse: true,     // Small animation on the icon
      //             backgroundColor:AppConstant.appSnackBarBackground,
      //             colorText: AppConstant.appTextColor,
      //             snackPosition: SnackPosition.BOTTOM, // or TOP
      //             borderRadius: 15,
      //             margin: const EdgeInsets.all(12),
      //             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      //             duration: const Duration(seconds: 3),
      //             isDismissible: true,
      //             forwardAnimationCurve: Curves.easeOutBack,
      //           );
      //         }
      //       },
      //       child: Container(
      //           height: 40,
      //           width: 200,
      //           decoration: BoxDecoration(
      //             color: Colors.green[100],
      //             borderRadius: BorderRadius.circular(5),
      //           ),
      //           child: Center(child: Text("Document Upload"))),
      //     )
      //   ],
      // )
    );
  }
}
