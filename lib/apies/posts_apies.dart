import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as myGet;
import 'package:perfume_store_mobile_app/services/sp_helper.dart';

import '../const_urls.dart';
import '../controller/posts_controller.dart';
import '../model/post_details_response.dart';
import '../model/posts_response.dart';
import '../model/related_post_response.dart';
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
        queryParameters: {
          "endpoint": "wpposts",
          // 'lang' : SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.statusCode == 200) {
        postsController.getPostsData!.value =
            ListPostsResponse.fromJson(response.data);
        log("getPostsData Successful ");
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }

  getPostDetailById(String? id) async {
    String? token = SPHelper.spHelper.getToken();
    postsController.getPostDetailData!.value = PostDetailResponse();
    postsController.getRelatedPostDetailData!.value =
        ListRelatedPostsResponse();

    try {
      Response response = await Settingss.settings.dio!.get(
        postsURL,
        queryParameters: {
          "endpoint": "wpposts",
          "id": id,
          'lang': SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.statusCode == 200) {
        getRelatedPostIDs(id);
        postsController.getPostDetailData!.value =
            PostDetailResponse.fromJson(response.data);
        log("getPostDetailById Successful ");
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }

  getRelatedPostIDs(String? id) async {
    try {
      Response response = await Dio().get(
        'https://nafahat.com/wp-json/nafahatapi/v1/relatedposts',
        // options: Options(
        //   headers: {
        //     'Authorization': 'Bearer ${SPHelper.spHelper.getAdminToken()}',
        //   },
        // ),
        queryParameters: {
          'post_id': id,
          'lang': SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'
        },
      );
      if (response.statusCode == 200) {
        log(response.data.join(', '));
        getRelatedPost(response.data.join(', '));
        log("getRelatedPostIDs Successful ");
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }

  getRelatedPost(String? ids) async {
    postsController.getRelatedPostDetailData!.value =
        ListRelatedPostsResponse();
    try {
      Response response = await Dio().get(
        'https://nafahat.com/wp-json/wp/v2/posts',
        queryParameters: {
          'include': ids,
          'lang': SPHelper.spHelper.getDefaultLanguage() == 'en' ? 'en' : 'ar'
        },
      );
      if (response.statusCode == 200) {
        postsController.getRelatedPostDetailData!.value =
            ListRelatedPostsResponse.fromJson(response.data);

        log("getManyPost Successful ");
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }
}
