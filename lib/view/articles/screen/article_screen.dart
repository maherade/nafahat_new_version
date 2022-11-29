import '../../../services/app_imports.dart';
import '../widget/article_item.dart';

class ArticlesScreen extends StatelessWidget {
  const ArticlesScreen({Key? key}) : super(key: key);

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
            child: ListView.builder(
              padding: EdgeInsets.zero,
              physics:const BouncingScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
              return ArticleItem(
                imgUrl: 'https://img.freepik.com/free-photo/close-up-photo-inspired-trendy-lady-sparkle-glasses-looking-up-with-mouth-open_197531-7099.jpg?w=740&t=st=1669627228~exp=1669627828~hmac=07fb80d4f295fc8e42398e8dd9c7176b7725f383d8de9ebeb8b7da066b172cd8',
                category: 'قسم المكياج',
                date: '11/11/2022',
                title: 'أحمر الشفاه آيكون من فنتي بيوتي يستحوذ على عين دبي أحد أبرز معالم دبي ',
                description: 'مع حلول الأجواء الباردة في فصل الخريف، تحتاج المرأة الىتغطية إضافية حول عينيها من خلال استخدام  كونسيلر عاليةالجودة تتناغم بشكل خاص مع ألوان المكياج الدافئة والداكنةالدافئة والداكنة',
                onTapReadMore: (){},
              );
            },),
          )
        ],
      ),
    );
  }
}
