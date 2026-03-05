import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_flutter_test/countries/models/country_summary.dart';
import 'package:my_flutter_test/generic_api/generic_api.dart';

@immutable
abstract class LoadAction {
  const LoadAction();
}

@immutable
class LoadCountriesAction implements LoadAction {
  final String url;
  final bool isRefresh;

  const LoadCountriesAction({required this.url, this.isRefresh = false})
    : super();
}

@immutable
class FetchResult {
  final List<CountrySummary> countries;
  final bool isRetrievedFromCache;

  const FetchResult({
    required this.countries,
    required this.isRetrievedFromCache,
  });

  @override
  String toString() =>
      'Countries ${countries.length} is From Cache $isRetrievedFromCache';
}

class CountryBloc extends Bloc<LoadAction, FetchResult?> {
  final Map<String, List<CountrySummary>> _cache = {};

  CountryBloc() : super(null) {
    on<LoadCountriesAction>((event, emit) async {
      final url = event.url;
      if (!event.isRefresh && _cache.containsKey(url)) {
        final cachedCountries = _cache[url]!;
        final result = FetchResult(
          countries: cachedCountries,
          isRetrievedFromCache: true,
        );
        emit(result);
        return;
      }

      emit(null);

      final countries = await GenericApi(client: http.Client())
          .fetchListData<CountrySummary>(
            url,
            (json) => CountrySummary.fromJson(json),
          );
      _cache[url] = countries;
      final result = FetchResult(
        countries: countries,
        isRetrievedFromCache: false,
      );
      emit(result);
    });
  }
}
