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
    PostsApies.postsApies.getPostDetailById(widget.id!);
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
              'الرئيسية/المقالات/تفاصيل المقال',
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
                var post = postsController.getPostDetailData!.value;
                return post.title == null ? const LoadingArticleDetails() : SingleChildScrollView(
                  padding: EdgeInsets.zero,
                  physics:const BouncingScrollPhysics(),
                  child: ArticleDetailItem(
                    imgUrl: post.yoastHeadJson?.ogImage?[0].url ?? '',
                    category: 'قسم المكياج',
                    date: DateFormat('dd-MM-yyyy').format(DateFormat('yyyy-MM-dd').parse(post.date!)),
                    title: post.title?.rendered ?? '',
                    description: parse(post.content?.rendered).documentElement!.text,
                    onTapReadMore: (){},
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
