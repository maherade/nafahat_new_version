
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../services/app_imports.dart';

class CustomRateRead extends StatelessWidget {
  double? rate;
  double? size;
  CustomRateRead({this.rate, this.size});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: RatingBarIndicator(
        itemPadding: EdgeInsets.zero,
        direction: Axis.horizontal,
        itemCount: 5,
        itemSize: size!,
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: AppColors.starYellowColor,
        ),
        rating: rate!,
      ),
    );
  }
}


class CustomRateWrite extends StatelessWidget {
  VoidCallback? onRatingChanged;
  double? size;
  CustomRateWrite({this.onRatingChanged, this.size});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: RatingBar.builder(
        initialRating: 3,
        minRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemSize: size!,
        itemBuilder: (context, _) =>const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: (rating) => onRatingChanged!(),
      ),
    );
  }
}
