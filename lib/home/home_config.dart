import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:my_flutter_test/core/api/api_endpoints.dart';
import 'package:my_flutter_test/countries/bloc/action_load.dart';
import 'package:my_flutter_test/countries/screens/countries_screen.dart';
import 'package:my_flutter_test/countries/screens/favorites_screen.dart';

class HomeConfig extends StatefulWidget {
  const HomeConfig({super.key});

  @override
  State<HomeConfig> createState() => _HomeConfigState();
}

class _HomeConfigState extends State<HomeConfig> {
  List items = [];
  int _selectedIndex = 0;

  @override
  void initState() {
    items = [const CountriesScreen(), const FavoritesScreen()];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        final bloc = context.read<CountryBloc>();
        bloc.add(
          LoadCountriesAction(url: Endpoints.allCountriesProd, isRefresh: true),
        );
        // Wait for the loading to complete
        await bloc.stream.firstWhere((state) => state?.isLoading == false);
      },
      child: Scaffold(
        body: items[_selectedIndex],

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black.withValues(alpha: 0.7),

          items: [
            BottomNavigationBarItem(
              icon: Icon(Iconsax.home),
              label: 'Home',
              activeIcon: Icon(Iconsax.home1),
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.heart),
              label: 'Favorites',
              activeIcon: Icon(Iconsax.heart5),
            ),
          ],
        ),
      ),
    );
  }
}
