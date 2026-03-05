import 'package:my_flutter_test/core/api/api_config.dart';

class ApiEndpoints {
  static String baseUrl = ApiConfig.baseUrl;
  static String allCountries = '$baseUrl/api_test/routes/countries_list.json';
  static String countryInfo = '$baseUrl/api_test/routes/country_infos.json';
}