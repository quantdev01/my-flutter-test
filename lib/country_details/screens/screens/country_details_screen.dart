import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_test/countries/bloc/action_load.dart';
import 'package:my_flutter_test/countries/models/country_details.dart';
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
    return BlocBuilder<CountryBloc, FetchResult?>(
      builder: (context, state) {
        if (state == null || state.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state.error != null) {
          return Scaffold(
            appBar: CustomAppBar(title: 'Error'),
            body: Center(child: Text('Error: ${state.error}')),
          );
        }

        final details = state.details;
        if (details == null) {
          return Scaffold(
            appBar: CustomAppBar(title: 'Not Found'),
            body: const Center(child: Text('No details found')),
          );
        }

        final isLargeScreen = MediaQuery.of(context).size.width > 600;

        return Scaffold(
          appBar: CustomAppBar(title: details.name),
          body: SingleChildScrollView(
            child: isLargeScreen
                ? Padding(
                    padding: kPadding,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 1, child: _buildFlag(details)),
                        const SizedBox(width: 20),
                        Expanded(flex: 1, child: _buildStats(context, details)),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      _buildFlag(details),
                      const SizedBox(height: 10),
                      Padding(
                        padding: kPadding,
                        child: _buildStats(context, details),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }

  Widget _buildFlag(CountryDetails details) {
    return Hero(
      tag: 'flag-${details.cca2}',
      child: Container(
        width: double.infinity,
        height: kMediaSize(context).height / 3,
        decoration: BoxDecoration(
          color: AppColors.greyColor,
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: NetworkImage(details.flags.png),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildStats(BuildContext context, CountryDetails details) {
    return Column(
      children: [
        Row(
          children: [
            Text('Key Statistics', style: kTextTheme(context).titleLarge),
          ],
        ),
        const SizedBox(height: 20),
        Column(
          children: [
            RowElement(
              title: 'Area',
              subTitle: '${details.area.toString()} sq km',
            ),
            RowElement(
              title: 'Population',
              subTitle: details.population.formatPopulation(),
            ),
            RowElement(title: 'Region', subTitle: details.region),
            RowElement(title: 'Sub Region', subTitle: details.subregion),
            const SizedBox(height: 20),
            Row(
              children: [
                Text('Timezone', style: kTextTheme(context).titleLarge),
              ],
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: details.timezones.timezones
                  .map((tz) => TimeZone(title: tz))
                  .toList(),
            ),
          ],
        ),
      ],
    );
  }
}
