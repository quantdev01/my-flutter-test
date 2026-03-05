import 'package:my_flutter_test/core/api/api_config.dart';

class Endpoints {
  static String baseUrl = ApiConfig.baseUrl;
  static String allCountries = '$baseUrl/api_test/routes/countries_list.json';
  static String allCountriesProd = '$baseUrl/all?fields=name,flags,population,cca2';
  static String countryInfo = '$baseUrl/api_test/routes/country_infos.json';
}