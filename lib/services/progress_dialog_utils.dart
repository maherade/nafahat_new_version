import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';

class ProgressDialogUtils {
  static show() {
    SVProgressHUD.show();
    SVProgressHUD.setBackgroundColor(Colors.red.withOpacity(0.5));
    SVProgressHUD.setBackgroundLayerColor(Colors.red.withOpacity(0.5));
    SVProgressHUD.setBackgroundLayerColor(Colors.red);
    // SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark);
  }

  static hide() {
    SVProgressHUD.dismiss();
  }
}
