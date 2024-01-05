import 'package:get/get.dart';

import '../model/post_details_response.dart';
import '../model/posts_response.dart';
import '../model/related_post_response.dart';

class PostsController extends GetxController {
  Rx<ListPostsResponse>? getPostsData = ListPostsResponse().obs;
  Rx<PostDetailResponse>? getPostDetailData = PostDetailResponse().obs;
  Rx<ListRelatedPostsResponse>? getRelatedPostDetailData =
      ListRelatedPostsResponse().obs;
}
