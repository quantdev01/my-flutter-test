import 'package:flutter/material.dart';
import 'package:my_flutter_test/countries/models/flags.dart';
import 'package:my_flutter_test/utils/constants.dart';


@immutable
class Country {
  final String name;
  final Flags flags;
  final String cca2;
  final String capital;
  final String region;
  final String subRegion;
  final num area;
  final num population;

  const Country({required this.name, required this.flags, required this.population, required this.cca2, required this.capital, required this.region, required this.subRegion, required this.area});

   Country.fromJson(Json json) : name = json['name'].toString(), flags = json['flags'], population = json['population'], cca2 = json['cca2'], capital = json['capital'][0].toString(), 
   region = json['region'], subRegion=json['subRegion'], area= json['area'];
}



// Data Models
// ● CountrySummary (for lists)
// ○ name (common)
// ○ flag (png or svg)
// ○ population
// ○ cca2 (unique identifier)
// ● CountryDetails (for detail screen)
// ○ name (common)
// ○ flags (png or svg)
// ○ population
// ○ capital