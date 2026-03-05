import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_test/core/services/favorites_service.dart';
import 'package:my_flutter_test/countries/bloc/action_load.dart';
import 'package:my_flutter_test/countries/widgets/country_item.dart';
import 'package:my_flutter_test/country_details/screens/screens/country_details_screen.dart';
import 'package:my_flutter_test/utils/constants.dart';
import 'package:my_flutter_test/utils/widgets/custom_app_bar.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final _favoritesService = FavoritesService();
  List<String> _favoriteCodes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final codes = await _favoritesService.getFavorites();
    if (mounted) {
      setState(() {
        _favoriteCodes = codes;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Favorites'),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _favoriteCodes.isEmpty
          ? const Center(child: Text('No countries have been favorited.'))
          : BlocBuilder<CountryBloc, FetchResult?>(
              builder: (context, state) {
                final allCountries = state?.countries ?? [];
                final favorites = allCountries
                    .where((c) => _favoriteCodes.contains(c.cca2))
                    .toList();

                return Padding(
                  padding: kPadding,
                  child: ListView.builder(
                    itemCount: favorites.length,
                    itemBuilder: (context, index) {
                      final country = favorites[index];
                      return GestureDetector(
                        onTap: () {
                          context.read<CountryBloc>().add(
                            LoadCountryDetailsAction(code: country.cca2),
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const CountryDetailsScreen(),
                            ),
                          );
                        },
                        child: CountryItem(
                          imageUrl: country.flags.png,
                          title: country.name,
                          population: country.population.formatPopulation(),
                          cca2: country.cca2,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
