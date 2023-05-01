import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perfume_store_mobile_app/services/sp_helper.dart';

class MyLocaleController extends GetxController{
  Locale initialLang = SPHelper.spHelper.getDefaultLanguage() == null ? Locale('ar') : Locale(SPHelper.spHelper.getDefaultLanguage()!);
  void changeLang(String codeLang){
    Locale locale = Locale(codeLang);
    SPHelper.spHelper.setDefaultLanguage(codeLang);
    Get.updateLocale(locale);
  }
}