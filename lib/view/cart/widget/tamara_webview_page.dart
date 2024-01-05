import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../apies/order_apies.dart';
import '../../../services/app_imports.dart';

class TamaraWebViewPage extends StatefulWidget {
  final String? paymentUrl;
  final String? orderId;

  final String? customer_id;
  final String? status;
  final String payment_method;
  final String payment_method_title;
  final String firstName;
  final String lastName;
  final String addressOne;
  final String addressTwo;
  final String city;
  final String country;
  final String state;
  final String postcode;
  final String email;
  final String phone;
  final String total;
  final bool setPaid;
  final List<Map<String, dynamic>> listProduct;
  final List<Map<String, dynamic>> listShipment;
  final List<Map<String, dynamic>> listMetaData;
  final List<Map<String, dynamic>> items;
  final String? couponCode;

  const TamaraWebViewPage({
    super.key,
    this.paymentUrl,
    this.orderId,
    this.customer_id,
    this.status,
    required this.payment_method,
    required this.payment_method_title,
    required this.firstName,
    required this.lastName,
    required this.addressOne,
    required this.addressTwo,
    required this.city,
    required this.country,
    required this.state,
    required this.postcode,
    required this.email,
    required this.phone,
    required this.total,
    required this.setPaid,
    required this.listProduct,
    required this.listShipment,
    required this.listMetaData,
    required this.items,
    this.couponCode,
  });

  @override
  _TamaraWebViewPageState createState() => _TamaraWebViewPageState();
}

class _TamaraWebViewPageState extends State<TamaraWebViewPage> {
  InAppWebViewController? webViewController;

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
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        title: const CustomText(
          'اطلب الآن وادفع خلال 30 یوم مع تمارا. بدون رسوم',
          fontSize: 12,
          color: Colors.white,
        ),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: Uri.parse(widget.paymentUrl!),
        ),
        initialOptions: options,
        onWebViewCreated: (controller) {
          webViewController = controller;
        },
        androidOnPermissionRequest: (controller, origin, resources) async {
          return PermissionRequestResponse(
            resources: resources,
            action: PermissionRequestResponseAction.GRANT,
          );
        },
        shouldOverrideUrlLoading: (controller, action) async {
          return handleUrlLoading(controller, action);
        },
      ),
    );
  }

  Future<NavigationActionPolicy> handleUrlLoading(
    InAppWebViewController controller,
    NavigationAction action,
  ) async {
    final uri = Uri.parse(action.request.url.toString());

    try {
      if (uri.toString().contains('paymentStatus')) {
        String? paymentStatus = uri.queryParameters['paymentStatus'];
        if (paymentStatus == 'approved') {
          OrderApies.orderApies.updateTamaraOrder(
            orderID: widget.orderId,
            customer_id: widget.customer_id,
            status: 'processing',
            items: widget.items,
            payment_method: 'tamara-gateway-pay-in-3',
            payment_method_title:
                'اطلب الآن وادفع خلال 30 یوم مع تمارا. بدون رسوم',
            firstName: widget.firstName,
            lastName: widget.lastName,
            addressOne: widget.addressOne,
            addressTwo: widget.addressTwo,
            city: widget.city,
            country: widget.country,
            state: "",
            postcode: widget.postcode,
            email: widget.email,
            phone: widget.phone,
            total: widget.total,
            listProduct: widget.listProduct,
            setPaid: true,
            couponCode: widget.couponCode,
            listShipment: widget.listShipment,
            listMetaData: widget.listMetaData,
          );
          debugPrint('Payment status is approved');
          Get.back();
        } else {
          debugPrint('Payment status is not approved');
          Get.back();
        }
      }
      return NavigationActionPolicy.ALLOW;
    } catch (e) {
      return NavigationActionPolicy.CANCEL;
    }
  }
}
