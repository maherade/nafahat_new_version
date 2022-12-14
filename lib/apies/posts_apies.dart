import 'package:dio/dio.dart';
import 'package:get/get.dart' as myGet;
import 'package:perfume_store_mobile_app/controller/brand_controller.dart';
import 'package:perfume_store_mobile_app/services/sp_helper.dart';

import '../const_urls.dart';
import '../controller/posts_controller.dart';
import '../model/brand_response.dart';
import '../model/post_details_response.dart';
import '../model/posts_response.dart';
import '../services/Settingss.dart';



class PostsApies {
  PostsApies._();

  static PostsApies postsApies = PostsApies._();
  PostsController postsController = myGet.Get.find();

  getPostsData() async {
    String? token = SPHelper.spHelper.getToken();
    postsController.getPostsData!.value = ListPostsResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
        postsURL,
        options: Options(
          headers: {'Authorization': 'Bearer $token'}
        )
      );
      if (response.statusCode == 200) {
        postsController.getPostsData!.value = ListPostsResponse.fromJson(response.data);
        print("getPostsData Successful ${postsController.getPostsData!.value.listPostsResponse![0].yoastHeadJson?.ogImage?[0].url}");
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  getPostDetailById(String id) async {
    String? token = SPHelper.spHelper.getToken();
    postsController.getPostDetailData!.value = PostDetailResponse();
    try {
      Response response = await Settingss.settings.dio!.get(
        '$postsURL/$id',
        options: Options(
          headers: {'Authorization': 'Bearer $token'}
        )
      );
      if (response.statusCode == 200) {
        postsController.getPostDetailData!.value = PostDetailResponse.fromJson(response.data);
        print("getPostDetailById Successful ");
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }


}
