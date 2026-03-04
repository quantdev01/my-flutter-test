
import 'package:flutter/material.dart';
import 'package:my_flutter_test/theme/app_colors.dart';

class RowElement extends StatelessWidget {
  final String title;
  final String subTitle;
  const RowElement({
    super.key, required this.title, required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(
            color: AppColors.greySearchColor
            
          ),),
          Text(subTitle)
        ],),
    );
  }
}