import 'package:flutter/material.dart';
import 'package:my_flutter_test/countries/screens/countries_screen.dart';
import 'package:my_flutter_test/country_details/screens/screens/country_details_screen.dart';

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
    items = [
      CountriesScreen(),
      CountryDetailsScreen()
    ]; 
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        
        items:[
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home', activeIcon: Icon(Icons.home)),
         BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Favorites', activeIcon: Icon(Icons.favorite))
      ]),
    );
  }
}