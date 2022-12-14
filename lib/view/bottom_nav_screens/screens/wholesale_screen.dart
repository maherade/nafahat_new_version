import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:perfume_store_mobile_app/colors.dart';
import 'package:perfume_store_mobile_app/controller/app_controller.dart';
import 'package:perfume_store_mobile_app/services/app_imports.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../custom_widget/loading_efffect/loading_send_request.dart';


class WholeSaleScreen extends StatefulWidget {

  @override
  State<WholeSaleScreen> createState() => _WholeSaleScreenState();
}

class _WholeSaleScreenState extends State<WholeSaleScreen> {
  //*********** inAppWebView Options *****************
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));
  double progress = 0;

bool visible = false;
  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    return GetBuilder<AppController>(
      init: AppController(),
      builder: (appController) {
        return Column(
          children: [
            SizedBox(
              height: 100.h,
            ),
            Expanded(
              child: Builder(
                builder: (context) {
                  return Stack(
                    children: [
                      InAppWebView(
                        initialUrlRequest: URLRequest(url: Uri.parse('https://nafahat.com/البيع-بالجملة/')),
                        initialUserScripts: UnmodifiableListView<UserScript>([]),
                        initialOptions: options,
                        onWebViewCreated: (controller) {
                          appController.inAppWebViewController = controller;
                        },
                        onLoadStart: (controller, url) {},
                        androidOnPermissionRequest: (controller, origin, resources) async {
                          return PermissionRequestResponse(
                              resources: resources, action: PermissionRequestResponseAction.GRANT);
                        },
                        onLoadStop: (controller, url) async {
                          appController.inAppWebViewController!.evaluateJavascript(source: "document.querySelector('.menu-item-1045').style.display='none'");
                          appController.inAppWebViewController!.evaluateJavascript(source: "document.querySelector('.all_header_bg').style.display='none'");
                          appController.inAppWebViewController!.evaluateJavascript(source: "document.querySelector('.top_head').style.display='none'");
                          appController.inAppWebViewController!.evaluateJavascript(source: "document.querySelector('.woocommerce-breadcrumb').style.display='none'");
                          appController.inAppWebViewController!.evaluateJavascript(source: "document.querySelector('.logo').style.display='none'");
                          appController.inAppWebViewController!.evaluateJavascript(source: "document.querySelector('.mobile_button').style.display='none'");
                          appController.inAppWebViewController!.evaluateJavascript(source: "document.querySelector('.footer_bg').style.display='none'");

                        },
                        onProgressChanged: (controller, progress) {
                          appController.inAppWebViewController!.evaluateJavascript(source: "document.querySelector('.menu-item-1045').style.display='none'");
                          appController.inAppWebViewController!.evaluateJavascript(source: "document.querySelector('.all_header_bg').style.display='none'");
                          appController.inAppWebViewController!.evaluateJavascript(source: "document.querySelector('.top_head').style.display='none'");
                          appController.inAppWebViewController!.evaluateJavascript(source: "document.querySelector('.woocommerce-breadcrumb').style.display='none'");
                          appController.inAppWebViewController!.evaluateJavascript(source: "document.querySelector('.logo').style.display='none'");
                          appController.inAppWebViewController!.evaluateJavascript(source: "document.querySelector('.footer_bg').style.display='none'");


                          setState(() => this.progress = progress / 100);
                        },
                      ),
                      progress < 0.3
                          ? LoadingSendRequest()
                          :  SizedBox(),
                    ],
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }
}
