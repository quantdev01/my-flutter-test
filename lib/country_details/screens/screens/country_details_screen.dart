import 'package:flutter/material.dart';
import 'package:my_flutter_test/country_details/screens/widgets/row_element.dart';
import 'package:my_flutter_test/country_details/screens/widgets/timezone.dart';
import 'package:my_flutter_test/theme/app_colors.dart';
import 'package:my_flutter_test/utils/constants.dart';
import 'package:my_flutter_test/utils/widgets/custom_app_bar.dart';

class CountryDetailsScreen extends StatefulWidget {
  const CountryDetailsScreen({super.key});

  @override
  State<CountryDetailsScreen> createState() => _CountryDetailsScreenState();
}

class _CountryDetailsScreenState extends State<CountryDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Country name'),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: kMediaSize(context).height / 3,
            decoration: BoxDecoration(
              color: AppColors.greyColor,

              borderRadius: BorderRadius.only(topRight: Radius.circular(8), topLeft: Radius.circular(8))
            ),
          ),

          SizedBox(height: 10,)
          ,
          Padding(padding: kPadding,
          child: Column(
            children: [
              Row(
                children: [
                  Text('Key Statistics', style: kTextTheme(context).titleLarge,
                  
                  ),
                ],
              ),

              SizedBox(height: 20,)
              ,
              Column(children: [
                RowElement(
                  title: 'Area',
                  subTitle: '301,340 sq km',
                ),
                RowElement(
                  title: 'Population',
                  subTitle: '60.36 million',
                ),
                RowElement(
                  title: 'Region',
                  subTitle: 'Europe',
                ),
                RowElement(
                  title: 'Sub Region',
                  subTitle: 'Eastern Europe',
                ),

                  SizedBox(height: 10,)
                  ,

                  Row(
                    children: [
                      Text('Timezone', style: kTextTheme(context).titleLarge, ),
                    ],
                  ),

                  SizedBox(height: 20,)
                  ,
                  Row(children: [
                    TimeZone(title: 'UTC+01',),
                    SizedBox(width: 10,)
                    ,
                    TimeZone(title: 'UTC+01',)
                  ],)
                
              ],),
            ],
          ),
          )
          ,

        ],
      ),

    );
  }
}

