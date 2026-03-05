import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_test/core/api/api_endpoints.dart';
import 'package:my_flutter_test/countries/bloc/action_load.dart';
import 'package:my_flutter_test/countries/widgets/country_item.dart';
import 'package:my_flutter_test/theme/app_colors.dart';
import 'package:my_flutter_test/utils/widgets/custom_app_bar.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'dart:developer' as developer;

class CountriesScreen extends StatefulWidget {
  const CountriesScreen({super.key});

  @override
  State<CountriesScreen> createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CountryBloc>().add(
      LoadCountriesAction(url: Endpoints.allCountriesProd),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Countries'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.greyLight,
                borderRadius: BorderRadius.circular(16),
              ),

              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hint: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.search_outlined,
                        color: AppColors.greySearchColor,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Search for a country',
                        style: TextStyle(
                          color: AppColors.greySearchColor,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),

            Expanded(
              child: BlocBuilder<CountryBloc, FetchResult?>(
                buildWhen: (previousResult, currentResult) =>
                    previousResult != currentResult,
                builder: (context, fetchResult) {
                  final countries = fetchResult?.countries;
                  fetchResult?.log();
                  if (countries == null) {
                    return ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) => Skeletonizer(
                        enabled: true,

                        child: Card(
                          child: CountryItem(
                            imageUrl: '',
                            title: 'title',
                            population: '',
                          ),
                        ),
                      ),
                    );
                  }
                  return fetchResult!.countries.isEmpty
                      ? Center(
                          child: TextButton(
                            onPressed: () {},
                            child: Text('Retry'),
                          ),
                        )
                      : ListView.builder(
                          itemCount: countries.length,
                          itemBuilder: (context, index) {
                            final country = countries[index];
                            return CountryItem(
                              imageUrl: country.flags.png,
                              title: country.name.length > 20
                                  ? '${country.name.substring(0, 20)}...'
                                  : country.name,
                              population: country.population.toMillion(),
                            );
                          },
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension Log on Object {
  void log() => developer.log(toString());
}

extension ToMorK on num {
  String toMillion() {
    if (this >= 1000000) {
      final millionValue = this / 1000000;
      return '${millionValue.toStringAsFixed(1)}M';
    } else if (this >= 1000) {
      final thousandValue = this / 1000;
      return '${thousandValue.toStringAsFixed(1)}K';
    } else {
      return toString();
    }
  }
}
