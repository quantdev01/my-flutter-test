
import 'package:flutter/material.dart';
import 'package:my_flutter_test/theme/app_colors.dart';
import 'package:my_flutter_test/utils/constants.dart';

class CountryItem extends StatelessWidget {
  final String imageUrl;
  final String population;
  final String title;
  const CountryItem({
    required this.imageUrl,
    required this.title,
    required this.population,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Row(children: [
          SizedBox(
          height: kMediaSize(context).height *0.07,
          width: kMediaSize(context).width * 0.25,
          
          child: imageUrl.isNotEmpty ? ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(imageUrl, fit: BoxFit.cover,)) : Text('Image not found'),
        
        ),
        SizedBox(width: kMediaSize(context).width * 0.03,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold),)
          ,
          Text('Population: $population', style: TextStyle(color: AppColors.greySearchColor, fontWeight: FontWeight.w300),)
        ],
        ),
        ],),
        Icon(Icons.favorite)
      
      
      
      ],
      
      
      ),
    );
  }
}

