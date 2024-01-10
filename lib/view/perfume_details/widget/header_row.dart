import 'package:flutter/material.dart';

import '../../../colors.dart';

class HeaderRow extends StatelessWidget {

  String imagePath;
  Function()? onTap;
    HeaderRow({required this.onTap, required this.imagePath, super.key});

  @override
  Widget build(BuildContext context) {
    return   GestureDetector(
      onTap: onTap,
      child: Container(
         height: 50,
        width: 50 ,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.greyBorder,
        ),
        child: Image.asset(imagePath,
        color: Colors.black,
        ),
      ),
    );
  }
}
