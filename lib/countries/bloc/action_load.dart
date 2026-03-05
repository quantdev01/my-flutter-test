import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_flutter_test/countries/models/country_summary.dart';
import 'package:my_flutter_test/countries/models/country_details.dart';
import 'package:my_flutter_test/generic_api/generic_api.dart';
import 'package:my_flutter_test/core/api/api_endpoints.dart';

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
class SearchCountriesAction implements LoadAction {
  final String query;
  const SearchCountriesAction({required this.query});
}

@immutable
class LoadCountryDetailsAction implements LoadAction {
  final String code;
  const LoadCountryDetailsAction({required this.code});
}

@immutable
class FetchResult {
  final List<CountrySummary>? countries;
  final CountryDetails? details;
  final bool isRetrievedFromCache;
  final bool isLoading;
  final String? error;

  const FetchResult({
    this.countries,
    this.details,
    this.isRetrievedFromCache = false,
    this.isLoading = false,
    this.error,
  });

  FetchResult copyWith({
    List<CountrySummary>? countries,
    CountryDetails? details,
    bool? isRetrievedFromCache,
    bool? isLoading,
    String? error,
  }) {
    return FetchResult(
      countries: countries ?? this.countries,
      details: details ?? this.details,
      isRetrievedFromCache: isRetrievedFromCache ?? this.isRetrievedFromCache,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  String toString() =>
      'Countries ${countries?.length} is From Cache $isRetrievedFromCache';
}

class CountryBloc extends Bloc<LoadAction, FetchResult?> {
  final Map<String, List<CountrySummary>> _cache = {};
  final Map<String, CountryDetails> _detailsCache = {};

  CountryBloc() : super(null) {
    on<LoadCountriesAction>((event, emit) async {
      final url = event.url;
      if (!event.isRefresh && _cache.containsKey(url)) {
        emit(FetchResult(countries: _cache[url]!, isRetrievedFromCache: true));
        return;
      }

      emit(const FetchResult(isLoading: true));

      try {
        final countries = await GenericApi(client: http.Client())
            .fetchListData<CountrySummary>(
              url,
              (json) => CountrySummary.fromJson(json),
            );
        _cache[url] = countries;
        emit(FetchResult(countries: countries, isRetrievedFromCache: false));
      } catch (e) {
        emit(FetchResult(error: e.toString()));
      }
    });

    on<SearchCountriesAction>((event, emit) async {
      if (event.query.isEmpty) {
        add(LoadCountriesAction(url: Endpoints.allCountriesProd));
        return;
      }

      emit(const FetchResult(isLoading: true));

      try {
        final url = Endpoints.searchByName(event.query);
        final countries = await GenericApi(client: http.Client())
            .fetchListData<CountrySummary>(
              url,
              (json) => CountrySummary.fromJson(json),
            );
        emit(FetchResult(countries: countries));
      } catch (e) {
        emit(FetchResult(error: e.toString()));
      }
    });

    on<LoadCountryDetailsAction>((event, emit) async {
      final code = event.code;
      if (_detailsCache.containsKey(code)) {
        emit(
          FetchResult(
            countries: state?.countries,
            details: _detailsCache[code],
            isRetrievedFromCache: true,
          ),
        );
        return;
      }

      emit(
        state?.copyWith(isLoading: true) ?? const FetchResult(isLoading: true),
      );

      try {
        final url = Endpoints.countryDetails(code);
        final detailsList = await GenericApi(client: http.Client())
            .fetchListData<CountryDetails>(
              url,
              (json) => CountryDetails.fromJson(json),
            );

        if (detailsList.isNotEmpty) {
          final details = detailsList.first;
          _detailsCache[code] = details;
          emit(
            state?.copyWith(details: details, isLoading: false) ??
                FetchResult(details: details),
          );
        } else {
          emit(
            state?.copyWith(error: 'No details found', isLoading: false) ??
                const FetchResult(error: 'No details found'),
          );
        }
      } catch (e) {
        emit(
          state?.copyWith(error: e.toString(), isLoading: false) ??
              FetchResult(error: e.toString()),
        );
      }
    });
  }
}
