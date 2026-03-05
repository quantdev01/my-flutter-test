import 'package:flutter/material.dart';
import 'package:my_flutter_test/countries/models/flags.dart';
import 'package:my_flutter_test/utils/constants.dart';


@immutable
class CountrySummary {
  final String name;
  final Flags flags;
  final String cca2;

  final num population;

  const CountrySummary({required this.name, required this.flags, required this.population, required this.cca2,});

   CountrySummary.fromJson(Json json) : name = json['name']['common'].toString(), flags = Flags.fromJson(json['flags']), population = json['population'], cca2 = json['cca2'];
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