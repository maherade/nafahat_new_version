import 'package:get/get.dart';

import '../model/common_question_response.dart';

class ContactUsController extends GetxController {
  Rx<CommonQuestionResponse>? getCommonQuestionData =
      CommonQuestionResponse().obs;
}
