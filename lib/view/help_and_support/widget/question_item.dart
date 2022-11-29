import '../../../services/app_imports.dart';

class QuestionItem extends StatelessWidget {
final String? question;
final String? answer;

  const QuestionItem({super.key, this.question, this.answer});
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0.w),
        border: Border.all(width: 1.0, color: const Color(0xfff2f1f1)),
      ),
      child: ExpansionTile(
        collapsedTextColor: AppColors.primaryColor,
        collapsedIconColor: AppColors.primaryColor,
        iconColor: AppColors.primaryColor,
        title: Row(
          children: [
            const Icon(
              Icons.add,
              color: AppColors.green,
            ),
            SizedBox(
              width: 8.w,
            ),
            CustomText(
              question,
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
              color: AppColors.primaryColor,
            ),
          ],
        ),
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 15.0.w),
            child: Column(
              children: [
                CustomText(
                  answer,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.normal,
                  color:const Color(0xff707070),
                ),
                SizedBox(height: 15.h,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
