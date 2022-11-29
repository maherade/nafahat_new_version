
import 'package:get/get.dart';

class AppController extends GetxController {
  int indexScreen = 0;
  setIndexScreen(int value) {
    indexScreen = value;
    update();
  }
}
