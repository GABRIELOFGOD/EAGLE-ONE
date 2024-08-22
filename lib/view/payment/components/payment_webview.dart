import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youdoc/common/color_extention.dart';

class PaymentWebview extends StatefulWidget {
  const PaymentWebview({
    super.key,
    required this.link,
  });
  final String link;

  @override
  State<PaymentWebview> createState() => _PaymentWebviewState();
}

class _PaymentWebviewState extends State<PaymentWebview> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.link));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () async {
              if (await controller.canGoBack()) {
                controller.goBack();
              } else {
                Navigator.pop(context); // Navigate back to the previous page
              }
            },
          ),
      ),
      backgroundColor: TColor.primaryBg,
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
