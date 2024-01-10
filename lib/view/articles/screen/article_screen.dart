import 'package:html/parser.dart';
import 'package:intl/intl.dart';

import '../../../apies/posts_apies.dart';
import '../../../controller/posts_controller.dart';
import '../../../services/app_imports.dart';
import '../../custom_widget/loading_efffect/loading_article.dart';
import '../../search/screen/search_screen.dart';
import '../widget/article_item.dart';
import 'article_detail_screen.dart';

class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({Key? key}) : super(key: key);

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  PostsController postsController = Get.find();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      PostsApies.postsApies.getPostsData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText("article_value".tr,
        fontSize: 18.sp,
        fontWeight:  FontWeight.bold,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 17.w),
            child: Image.asset(
              "assets/images/logo.png",
              height: 43.h,
              width: 43.w,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
            padding:   EdgeInsets.symmetric(horizontal: 17.0.w),
            child: GestureDetector(
              onTap: (){
                Get.to(() => const SearchScreen());
              },
              child: Container(
                height: MediaQuery.of(context).size.height*0.06,
                child: TextFormField(

                  decoration: InputDecoration(
                    hintText: 'اكتب كلمه البحث...',
                    filled: true,
                    suffixIcon: Image.asset(
                      'assets/images/search.png',
                      height: MediaQuery.of(context).size.height*0.005,
                      width: MediaQuery.of(context).size.height*0.005,
                    ),
                    fillColor: const Color(0XFFF7F8FA),
                    hintStyle: TextStyle(
                      fontSize: MediaQuery.of(context).size.height*0.018,
                      color: Colors.black54,
                      fontFamily: 'din',
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                  ),

                  style: TextStyle(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.height*0.018,
                  ),

                ),
              ),
            ),
          ),

          SizedBox(
            height: 19.h,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Obx(
                () {
                  var post =
                      postsController.getPostsData!.value.listPostsResponse;
                  return post == null
                      ? const LoadingArticle()
                      : Column(
                          children: [
                            ListView.builder(
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: post.length,
                              itemBuilder: (context, index) {
                                return ArticleItem(
                                  imgUrl: post[index]
                                          .eEmbedded
                                          ?.wpFeaturedmedia?[0]
                                          .sourceUrl ??
                                      '',
                                  // category: 'قسم المكياج',
                                  date: DateFormat('yyyy MMM dd').format(
                                    DateFormat('yyyy-MM-dd')
                                        .parse(post[index].date!),
                                  ),
                                  title: post[index].title?.rendered ?? '',
                                  description:
                                      parse(post[index].excerpt?.rendered)
                                          .documentElement!
                                          .text,
                                  onTapReadMore: () {
                                    Get.to(
                                      () => ArticleDetailScreen(
                                        id: post[index].id.toString(),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Row(
                                children: [
                                  CustomText(
                                    'المقالات المشهورة',
                                    fontSize: 17.sp,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            ListView.builder(
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: post.length > 3 ? 3 : post.length,
                              itemBuilder: (context, index) {
                                return ArticleItem(
                                  imgUrl: post[index]
                                          .eEmbedded
                                          ?.wpFeaturedmedia?[0]
                                          .sourceUrl ??
                                      '',
                                  category: 'قسم المكياج',
                                  date: DateFormat('yyyy MMM dd').format(
                                    DateFormat('yyyy-MM-dd')
                                        .parse(post[index].date!),
                                  ),
                                  title: post[index].title?.rendered ?? '',
                                  description:
                                      parse(post[index].excerpt?.rendered)
                                          .documentElement!
                                          .text,
                                  onTapReadMore: () {
                                    Get.to(
                                      () => ArticleDetailScreen(
                                        id: post[index].id.toString(),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                          ],
                        );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
