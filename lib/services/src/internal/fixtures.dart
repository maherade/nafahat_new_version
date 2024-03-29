import 'package:perfume_store_mobile_app/services/tabby_flutter_inapp_sdk.dart';

final defaultMerchantUrls = MerchantUrls(
  success: 'https://checkout.tabby.ai/success.html',
  failure: 'https://checkout.tabby.ai/failure.html',
  cancel: 'https://checkout.tabby.ai/cancel.html',
);

final snippetWebUrls = <Lang, String>{
  Lang.en: 'https://checkout.tabby.ai/promos/product-page/installments/en/',
  Lang.ar: 'https://checkout.tabby.ai/promos/product-page/installments/ar/',
};
