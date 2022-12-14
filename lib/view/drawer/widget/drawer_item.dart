import '../../../services/app_imports.dart';

class DrawerItem extends StatelessWidget {
  final String? title;
  final VoidCallback? onTap;

  DrawerItem({this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          title: CustomText(
            title ?? "",
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        const Divider(),
        SizedBox(
          height: 15.h,
        ),
      ],
    );
  }
}
