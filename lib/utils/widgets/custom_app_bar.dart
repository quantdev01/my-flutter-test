
import 'package:flutter/material.dart';
import 'package:my_flutter_test/utils/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  const CustomAppBar({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.copy(kMediaSize(context)),
      child: AppBar(
        animateColor: false,
        centerTitle: true,
       
        
        title: Text(title, style: TextStyle(
        fontWeight: FontWeight.bold
              ),
              ),
      ),
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(50);
}