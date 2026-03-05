import 'package:my_flutter_test/core/api/api_config.dart';

class Endpoints {
  static String baseUrl = ApiConfig.baseUrl;
  static String allCountriesProd =
      '$baseUrl/all?fields=name,flags,population,cca2';

  static String searchByName(String name) =>
      '$baseUrl/name/$name?fields=name,flags,population,cca2';

  static String countryDetails(String code) =>
      '$baseUrl/alpha/$code?fields=name,flags,population,capital,region,subregion,area,timezones,cca2';
}
