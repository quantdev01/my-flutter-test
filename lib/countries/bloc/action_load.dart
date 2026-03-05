
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_flutter_test/core/api/api_endpoints.dart';
import 'package:my_flutter_test/countries/models/country.dart';
import 'package:my_flutter_test/generic_api/generic_api.dart';

@immutable
abstract class LoadAction{
  const LoadAction();
}

@immutable class LoadCountriesAction implements LoadAction{
  final String url;

  const LoadCountriesAction({required this.url}) :super();
  
}

@immutable
class FetchResult{
  final List<Country> countries;
  final bool isRetrievedFromCache;

  const FetchResult({required this.countries, required this.isRetrievedFromCache});

  @override
  String toString() => 'Countries [${countries.length} is From Cache $isRetrievedFromCache';
}

class CountryBloc extends Bloc<LoadAction, FetchResult> {
  final Map<String, List<Country>> _cache = {};

  CountryBloc(super.initialState){
    on<LoadCountriesAction>((event, emit) async {
      final url = ApiEndpoints.allCountries;
      if (_cache.containsKey(url)){
        final cachedCountries = _cache[url]!;
        final result = FetchResult(countries: cachedCountries, isRetrievedFromCache: true);
        emit(result); 
      } else {
        final countries = await GenericApi(client: http.Client()).fetchListData<Country>(url,(json) => Country.fromJson(json),);
        _cache[url] = countries;
        final result = FetchResult(countries: countries, isRetrievedFromCache: false);
        emit(result);
      }
      
    },)
;
  }

}
