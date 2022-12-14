import 'package:html/parser.dart';
import 'package:intl/intl.dart';

import '../../../apies/posts_apies.dart';
import '../../../controller/posts_controller.dart';
import '../../../services/app_imports.dart';
import '../../custom_widget/loading_efffect/loading_article.dart';
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
    PostsApies.postsApies.getPostsData();
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 21.w),
            child: CustomText(
              'الرئيسية/المقالات',
              color: const Color(0xff707070),
              fontSize: 12.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            height: 19.h,
          ),
          Expanded(
            child: Obx(
              () {
                var post = postsController.getPostsData!.value.listPostsResponse;

                return post == null ? LoadingArticle() : ListView.builder(
                  padding: EdgeInsets.zero,
                  physics:const BouncingScrollPhysics(),
                  itemCount: post.length,
                  itemBuilder: (context, index) {
                    return ArticleItem(
                      imgUrl: post[index].yoastHeadJson?.ogImage?[0].url ?? '',
                      category: 'قسم المكياج',
                      date: DateFormat('dd-MM-yyyy').format(DateFormat('yyyy-MM-dd').parse(post[index].date!)),
                      title: post[index].title?.rendered ?? '',
                      description: parse(post[index].excerpt?.rendered).documentElement!.text,
                      onTapReadMore: (){
                        Get.to(()=> ArticleDetailScreen(id: post[index].id.toString(),));
                      },
                    );
                  },);
              },
            ),
          )
        ],
      ),
    );
  }
}
