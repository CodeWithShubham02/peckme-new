import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class IciciWebviewWidget extends StatefulWidget {
  const IciciWebviewWidget({super.key});

  @override
  State<IciciWebviewWidget> createState() => _IciciWebviewWidgetState();
}

class _IciciWebviewWidgetState extends State<IciciWebviewWidget> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://fms.bizipac.com/apinew/secureapi/icici_pre_paid_card_gen.php?user_id=7494&branch_id=53'));
  }

  @override
  Widget build(BuildContext context) {
    return  WebViewWidget(controller: _controller);
  }
}
