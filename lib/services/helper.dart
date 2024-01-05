import 'app_imports.dart';

class Helper {
  static setToast(String msg) {
    return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.primaryColor,
      textColor: AppColors.whiteColor,
      fontSize: 16.0,
    );
  }

  static getSheetError(String title) {
    return Get.snackbar(
      '',
      '',
      messageText: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: CustomText(
              title,
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.red,
            ),
          ),
          const Icon(
            Icons.info,
            color: Colors.red,
          ),
        ],
      ),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
    );
  }

  static getSheetSucsses(String title) {
    return Get.snackbar(
      '',
      '',
      messageText: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            title,
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Colors.green,
          ),
          SizedBox(
            width: ScreenUtil().setWidth(10),
          ),
          const Icon(
            Icons.check,
            color: Colors.green,
          ),
        ],
      ),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
    );
  }

  static loading() {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          const CircularProgressIndicator(
            color: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }

  static var appRaduis = BorderRadius.circular(8.r);
}
