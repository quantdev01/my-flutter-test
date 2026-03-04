import 'package:flutter/material.dart';
import 'package:my_flutter_test/country_details/screens/screens/country_details_screen.dart';
import 'package:my_flutter_test/theme/app_colors.dart';
import 'package:my_flutter_test/utils/constants.dart';
import 'package:my_flutter_test/utils/widgets/custom_app_bar.dart';

class CountriesScreen extends StatefulWidget {
  const CountriesScreen({super.key});

  @override
  State<CountriesScreen> createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Countries',),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.greyLight,
                borderRadius: BorderRadius.circular(16)
              ),


              
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hint: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                Icon(Icons.search_outlined, color:AppColors.greySearchColor,),
                SizedBox(width: 10,)
                ,
                 Text('Search for a country', style: TextStyle(
                  color: AppColors.greySearchColor,
                  fontWeight: FontWeight.w300
                ),)
              ],),
                ),
                
              )
            ),
            SizedBox(height: 10,)
            ,

            Expanded(child: ListView.builder(
              itemCount: 100,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                   goTo(CountryDetailsScreen(), context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Row(children: [
                      Container(
                      height: kMediaSize(context).height *0.07,
                      width: kMediaSize(context).width * 0.25,
                      
                      
                      decoration: BoxDecoration(
                        color: AppColors.greyColor,
                        borderRadius: BorderRadius.circular(8)
                      ),
                    
                    ),
                    SizedBox(width: kMediaSize(context).width * 0.03,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text('Spain', style: TextStyle(fontWeight: FontWeight.bold),)
                      ,
                      Text('Population: 43.1M', style: TextStyle(color: AppColors.greySearchColor, fontWeight: FontWeight.w300),)
                    ],
                    ),
                    ],),
                    Icon(Icons.favorite)
                  
                  
                  
                  ],
                  
                  
                  ),
                ),
              ),
              ),
              )
          ],
        ),
      ),
    );
  }
}

