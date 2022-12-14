import 'package:flutter/material.dart';
import 'package:perfume_store_mobile_app/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';


class PaymentsScreen extends StatefulWidget {
 final String? orderKey;
 final String? orderId;

  const PaymentsScreen({super.key, this.orderKey, this.orderId});
  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  double progress = 0;


  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: GestureDetector(
            onTap: (){
              print(widget.orderKey);
              print(widget.orderId);
              },
            child: const Text('Payment')),
      ),
      body: Center(
        child: Column(
          children: [
            LinearProgressIndicator(
              value: progress,
              color: Colors.red,
              backgroundColor: Colors.black,
            ),
            Expanded(
              child: WebView(
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl:
                "https://nafahat.com/checkout/order-pay/${widget.orderId}/?pay_for_order=true&key=${widget.orderKey}",
                onProgress: (progress) {
                  this.progress = progress / 100;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
