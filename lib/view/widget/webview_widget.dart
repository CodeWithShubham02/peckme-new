import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  final String customerName;
  final String leadid;
  final String client;

   WebViewScreen({Key? key,
     required this.customerName,
     required this.leadid,
     required this.client,
     required this.url }) : super(key: key);

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
      appBar: AppBar(title: Text("WebView")),
      body: Container(
        height: MediaQuery.of(context).size.height*2,
          constraints: BoxConstraints.expand(),
          child: WebViewWidget(controller: _controller)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.loadRequest(Uri.parse(widget.url));
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
