import 'package:flutter/material.dart';

// mediaquery
Size kMediaSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

TextTheme kTextTheme(BuildContext context) => Theme.of(context).textTheme;
// Padding theme

EdgeInsets kPadding = EdgeInsets.symmetric(horizontal: 20);

// Navigator

void goTo(Widget screen, BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
}

// My Json
typedef Json = Map<String, dynamic>;

extension NumFormatting on num {
  String toMillion() {
    if (this >= 1000000) {
      return '${(this / 1000000).toStringAsFixed(2)} million';
    } else {
      return toString();
    }
  }
}
