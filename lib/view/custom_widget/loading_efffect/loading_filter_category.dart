import '../../../services/app_imports.dart';
import '../Skelton.dart';

class LoadingFilterCategory extends StatelessWidget {
  const LoadingFilterCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 6,
      itemBuilder: (context, index) {
        return Row(
          children: [
            Skelton(
              height: 20.h,
              width: 20.w,
              radious: 1,
              margin: 7,
            ),
            SizedBox(
              width: 10.w,
            ),
            Skelton(
              height: 10.h,
              width: 100.w,
              radious: 5.r,
              margin: 7,
            ),
          ],
        );
      },
    );
  }
}
