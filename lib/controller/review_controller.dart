

import 'package:get/get.dart';

import '../model/review_response.dart';



class ReviewController extends GetxController{
  Rx<ListReviewResponse>? getReviewData = ListReviewResponse().obs;
}