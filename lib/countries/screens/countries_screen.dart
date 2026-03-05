import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_test/core/api/api_endpoints.dart';
import 'package:my_flutter_test/countries/bloc/action_load.dart';
import 'package:my_flutter_test/countries/models/country_summary.dart';
import 'package:my_flutter_test/countries/widgets/country_item.dart';
import 'package:my_flutter_test/theme/app_colors.dart';
import 'package:my_flutter_test/utils/widgets/custom_app_bar.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:my_flutter_test/country_details/screens/screens/country_details_screen.dart';
import 'package:my_flutter_test/utils/constants.dart';
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.greyLight,
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextField(
                onChanged: (value) {
                  context.read<CountryBloc>().add(
                    SearchCountriesAction(query: value),
                  );
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: 'Search for a country',
                  prefixIcon: Icon(
                    Icons.search_outlined,
                    color: AppColors.greySearchColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<CountryBloc, FetchResult?>(
                buildWhen: (previousResult, currentResult) =>
                    previousResult != currentResult,
                builder: (context, fetchResult) {
                  if (fetchResult == null || fetchResult.isLoading) {
                    return ListView.builder(
                      itemCount: 10,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) => Skeletonizer(
                        enabled: true,
                        child: Card(
                          child: CountryItem(
                            imageUrl: '',
                            title: 'Loading Country Name',
                            population: '00.00 million',
                            cca2: '',
                          ),
                        ),
                      ),
                    );
                  }

                  if (fetchResult.error != null) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Error: ${fetchResult.error}'),
                          TextButton(
                            onPressed: () {
                              context.read<CountryBloc>().add(
                                LoadCountriesAction(
                                  url: Endpoints.allCountriesProd,
                                  isRefresh: true,
                                ),
                              );
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  final countries = fetchResult.countries;
                  if (countries == null || countries.isEmpty) {
                    return const Center(child: Text('No countries found.'));
                  }

                  final isLargeScreen = MediaQuery.of(context).size.width > 600;

                  return isLargeScreen
                      ? GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 3,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                          itemCount: countries.length,
                          itemBuilder: (context, index) {
                            return _buildCountryItem(context, countries[index]);
                          },
                        )
                      : ListView.builder(
                          itemCount: countries.length,
                          itemBuilder: (context, index) {
                            return _buildCountryItem(context, countries[index]);
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

  Widget _buildCountryItem(BuildContext context, CountrySummary country) {
    return GestureDetector(
      onTap: () {
        context.read<CountryBloc>().add(
          LoadCountryDetailsAction(code: country.cca2),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CountryDetailsScreen()),
        );
      },
      child: CountryItem(
        imageUrl: country.flags.png,
        title: country.name.length > 20
            ? '${country.name.substring(0, 20)}...'
            : country.name,
        population: country.population.formatPopulation(),
        cca2: country.cca2,
      ),
    );
  }
}

extension Log on Object {
  void log() => developer.log(toString());
}
