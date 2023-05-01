import 'package:perfume_store_mobile_app/services/app_imports.dart';

import '../privacy_policy.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        title: CustomText('privacy_policy_value'.tr,color: Colors.white,fontSize: 18.sp,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [CustomText(privacyPolicies,fontWeight: FontWeight.normal,fontSize: 15.sp,)],
          ),
        ),
      ),
    );
  }
}
