import 'package:flutter/material.dart';
import 'package:my_flutter_test/utils/constants.dart';

@immutable
class Flags {
  final String png;
  final String svg;
  final String alt;

  const Flags({required this.png, required this.svg, required this.alt});

  Flags.fromJson(Json json)
    : png = json['png'] ?? '',
      svg = json['svg'] ?? '',
      alt = json['alt'] ?? '';
}
