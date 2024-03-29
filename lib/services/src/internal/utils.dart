import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:perfume_store_mobile_app/services/src/internal/fixtures.dart';
import 'package:perfume_store_mobile_app/services/tabby_flutter_inapp_sdk.dart';

import '../../app_imports.dart';

void debugPrintError(Object error, StackTrace stackTrace) {
  debugPrint('Exception: $error');
  debugPrint('StackTrace: $stackTrace');
}

IOSNavigationResponseAction iosNavigationResponseHandler({
  required TabbyCheckoutCompletion onResult,
  required String nextUrl,
}) {
  if (nextUrl.contains(defaultMerchantUrls.cancel)) {
    onResult(WebViewResult.close);
    return IOSNavigationResponseAction.CANCEL;
  }
  if (nextUrl.contains(defaultMerchantUrls.failure)) {
    onResult(WebViewResult.rejected);
    return IOSNavigationResponseAction.CANCEL;
  }
  if (nextUrl.contains(defaultMerchantUrls.success)) {
    onResult(WebViewResult.authorized);
    return IOSNavigationResponseAction.CANCEL;
  }
  return IOSNavigationResponseAction.ALLOW;
}

void javaScriptHandler(
  List<dynamic> message,
  TabbyCheckoutCompletion onResult,
) {
  try {
    final List<dynamic> events = message.first;
    final msg = events.first as String;
    final resultCode = WebViewResult.values.firstWhere(
      (value) => value.name == msg.toLowerCase(),
    );
    onResult(resultCode);
  } catch (e, s) {
    debugPrintError(e, s);
  }
}

List<String> getLocalStrings({
  required String price,
  required Currency currency,
  required Lang lang,
}) {
  final fullPrice =
      (double.parse(price) / 4).toStringAsFixed(currency.decimals);
  if (lang == Lang.ar) {
    return [
      'أو قسّمها على 4 دفعات شهرية بقيمة ',
      fullPrice,
      ' ${currency.name} ',
      'بدون رسوم أو فوائد. ',
      'لمعرفة المزيد'
    ];
  } else {
    return [
      'or 4 interest-free payments of ',
      fullPrice,
      ' ${currency.name}',
      '. ',
      'Learn more'
    ];
  }
}
