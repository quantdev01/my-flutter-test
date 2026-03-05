
import 'package:flutter/material.dart';
import 'package:my_flutter_test/utils/constants.dart';

@immutable
class Timezones {
  final List<String> timezones;

  const Timezones({required this.timezones});

   Timezones.fromJson(Json json) : timezones = List<String>.from(json['timezones'] ?? []);
}