import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:perfume_store_mobile_app/apies/order_apies.dart';
import 'package:perfume_store_mobile_app/colors.dart';
import 'package:perfume_store_mobile_app/controller/order_controller.dart';
import 'package:perfume_store_mobile_app/services/sp_helper.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentsScreen extends StatefulWidget {
  final String? orderKey;
  final String? orderId;

  const PaymentsScreen({Key? key, this.orderKey, this.orderId})
      : super(key: key);

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  OrderController orderController = Get.find();
  late WebViewController _webViewController;

  double progress = 0;
  bool _isPageLoaded = false;

  @override
  void initState() {
    OrderApies.orderApies
        .getPaymentUrl(orderId: widget.orderId, orderKey: widget.orderKey);
    super.initState();
  }

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      useShouldOverrideUrlLoading: true,
    ),
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
    ),
  );

  @override
  Widget build(BuildContext context) {
    String baseUrl = 'https://nafahat.com/checkout/order-pay/${widget.orderId}/?pay_for_order=true&key=${widget.orderKey}&naf-token=true';
    String token = SPHelper.spHelper.getToken()!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text('Payment'),
      ),
      body: Obx(
        () {
          var paymentHtml = orderController.getPaymentHtmlPage?.value.htmlUrl;
          return paymentHtml != null
              ? Column(
                  children: [
                    LinearProgressIndicator(
                      value: progress,
                      color: Colors.red,
                      backgroundColor: Colors.black,
                    ),
                    Expanded(
                      child: InAppWebView(
                        initialUrlRequest: URLRequest(
                            url: Uri.parse(baseUrl),
                            headers: {"Authorization": "Bearer $token"}),
                        initialOptions: options,
                        shouldOverrideUrlLoading:
                            (controller, navigationAction) async {
                          var request = navigationAction.request;
                          var url = request.url;
                          var isUrlMatching = url != null &&
                              (!url.path.contains(
                                  '/checkout//session-creating.html')) &&
                              (!url.path.contains(
                                  '/checkout/widgets-user-tracking.html')) &&
                              (url.path.contains('/checkout/') ||
                                  url.path.contains('/cart/'));
                          print(isUrlMatching.toString());
                          print(url!.path.toString());
                          if (isUrlMatching) {
                            if (request.headers != null &&
                                request.headers!["Authorization"] != null) {
                              print('header already set! Allow the current navigation request');
                              return NavigationActionPolicy.ALLOW;
                            } else {
                              request.headers ??= {
                                "Authorization": "Bearer $token"
                              };
                              print('Header not found! Set the "Authorization" header');
                              request.headers!["Authorization"] =
                                  "Bearer $token";
                              print('Make load request with "Authorization" header');
                              controller.loadUrl(urlRequest: request);

                              print('and cancel the current navigation request');
                              return NavigationActionPolicy.CANCEL;
                            }
                          }
                          // always allow all the other requests
                          return NavigationActionPolicy.ALLOW;
                        },
                      ),
                    ),
                  ],
                )
              : const SizedBox();
        },
      ),
    );
  }
}
