
import 'package:flutter/material.dart';
import 'package:my_flutter_test/theme/app_colors.dart';
import 'package:my_flutter_test/utils/constants.dart';

class TimeZone extends StatelessWidget {
  final String title;
  const TimeZone({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: BoxBorder.all(color: AppColors.greySearchColor)
    
      ),
      child: Text(title, style: kTextTheme(context).titleLarge,
    
      ),
    );
  }
}