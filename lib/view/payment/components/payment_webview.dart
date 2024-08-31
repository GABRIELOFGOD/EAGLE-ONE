import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youdoc/common/color_extention.dart';
import 'package:youdoc/view/payment/components/payment_confirmation.dart';

class PaymentWebview extends StatefulWidget {
  const PaymentWebview({
    super.key,
    required this.link,
    required this.reference,
    required this.backTo,
  });
  final String link;
  final String reference;
  final Widget backTo;

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
        title: const Text('Payment', style: TextStyle(color: Colors.white,),),
        backgroundColor: TColor.primaryBg,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: () async {
            if (await controller.canGoBack()) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (ctx) =>
                      PaymentConfirmation(reference: widget.reference, backTo: widget.backTo,),
                ),
                (route) => false,
              );
            } else {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (ctx) =>
                      PaymentConfirmation(reference: widget.reference, backTo: widget.backTo,),
                ),
                (route) => false,
              );
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
