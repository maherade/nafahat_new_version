// ignore_for_file: must_be_immutable

import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../services/app_imports.dart';

class CustomRateRead extends StatelessWidget {
  double? rate;
  double? size;

  CustomRateRead({super.key, this.rate, this.size});

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
  void Function(double)? onRatingChanged;
  double? size;

  CustomRateWrite({super.key, this.onRatingChanged, this.size});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: RatingBar.builder(
        initialRating: 3,
        minRating: 0,
        direction: Axis.horizontal,
        allowHalfRating: false,
        itemCount: 5,
        itemSize: size!,
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: onRatingChanged!,
      ),
    );
  }
}
