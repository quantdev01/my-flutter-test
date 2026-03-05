import 'package:flutter/material.dart';
import 'package:my_flutter_test/countries/models/flags.dart';
import 'package:my_flutter_test/countries/models/timezones.dart';
import 'package:my_flutter_test/utils/constants.dart';

@immutable
class CountryDetails {
  final String name;
  final Flags flags;
  final String cca2;
  final String capital;
  final String region;
  final String subregion;
  final num area;
  final num population;
  final Timezones timezones;

  const CountryDetails({
    required this.name,
    required this.flags,
    required this.population,
    required this.cca2,
    required this.capital,
    required this.region,
    required this.subregion,
    required this.area,
    required this.timezones,
  });

  CountryDetails.fromJson(Json json)
    : name = (json['name'] != null && json['name']['common'] != null)
          ? json['name']['common'].toString()
          : 'Unknown',
      flags = json['flags'] != null
          ? Flags.fromJson(json['flags'])
          : const Flags(png: '', svg: '', alt: ''),
      population = json['population'] ?? 0,
      cca2 = json['cca2'] ?? '',
      capital =
          (json['capital'] != null &&
              json['capital'] is List &&
              json['capital'].isNotEmpty)
          ? json['capital'][0].toString()
          : 'No Capital',
      region = json['region'] ?? '',
      subregion = json['subregion'] ?? '',
      area = json['area'] ?? 0,
      timezones = Timezones.fromJson(json);
}
