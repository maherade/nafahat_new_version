import 'package:html/parser.dart';
import 'package:intl/intl.dart';

import '../../../apies/posts_apies.dart';
import '../../../controller/posts_controller.dart';
import '../../../services/app_imports.dart';
import '../../custom_widget/loading_efffect/loading_article_detail.dart';
import '../widget/article_detail_item.dart';
import '../widget/article_item.dart';

class ArticleDetailScreen extends StatefulWidget {
  final String? id;

  const ArticleDetailScreen({super.key, this.id});

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  PostsController postsController = Get.find();

  @override
  void initState() {
    PostsApies.postsApies.getPostDetailById(widget.id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0.w),
            child: const BackButton(),
          ),
          SizedBox(
            height: 13.h,
          ),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 21.w),
          //   child: CustomText(
          //     'الرئيسية/المقالات/تفاصيل المقال',
          //     color: const Color(0xff707070),
          //     fontSize: 12.sp,
          //     fontWeight: FontWeight.normal,
          //   ),
          // ),
          SizedBox(
            height: 19.h,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Obx(
                        () {
                      var post = postsController.getPostDetailData!.value;
                      return post.title == null ? const LoadingArticleDetails() : ArticleDetailItem(
                        imgUrl: post.eEmbedded?.wpFeaturedmedia?[0].sourceUrl ?? '',
                        category: 'قسم المكياج',
                        date: DateFormat('dd-MM-yyyy').format(DateFormat('yyyy-MM-dd').parse(post.date!)),
                        title: post.title?.rendered ?? '',
                        description: parse(post.content?.rendered).documentElement!.text,
                        onTapReadMore: (){},
                      );
                    },
                  ),
                  Obx(
                        () {
                      var post = postsController.getRelatedPostDetailData!.value.listRelatedPostResponse;
                      return post == null ? const LoadingArticleDetails() : ListView.builder(
                        itemCount: post.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                        return  GestureDetector(
                          onTap: (){
                            PostsApies.postsApies.getPostDetailById(post[index].id.toString());
                          },
                          child: Container(
                            padding:  EdgeInsets.symmetric(horizontal: 20.w),
                            margin: EdgeInsets.symmetric(vertical: 10.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CachedNetworkImageShare(
                                    urlImage: post[index].yoastHeadJson?.ogImage?[0].url ?? '',
                                    fit: BoxFit.cover,
                                    heigthNumber: 250.h,
                                    borderRadious: 20,
                                    widthNumber: double.infinity),
                                CustomText(post[index].title?.rendered ?? '',fontSize: 13.sp,)
                              ],
                            ),
                          ),
                        );
                      },);
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
