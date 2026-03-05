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
  final String subRegion;
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
    required this.subRegion,
    required this.area,
    required this.timezones,
  });

  CountryDetails.fromJson(Json json)
    : name = json['name']['common'].toString(),
      flags = Flags.fromJson(json['flags']),
      population = json['population'],
      cca2 = json['cca2'],
      capital = (json['capital'] != null && json['capital'].isNotEmpty)
          ? json['capital'][0].toString()
          : 'No Capital',
      region = json['region'] ?? '',
      subRegion = json['subRegion'] ?? '',
      area = json['area'] ?? 0,
      timezones = Timezones.fromJson(json);
}
