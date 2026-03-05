import 'package:flutter_test/flutter_test.dart';
import 'package:my_flutter_test/countries/bloc/action_load.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('CountryBloc Retry Logic', () {
    late CountryBloc countryBloc;
    const testUrl = 'https://restcountries.com/v3.1/all';

    setUp(() {
      countryBloc = CountryBloc();
    });

    tearDown(() {
      countryBloc.close();
    });

    blocTest<CountryBloc, FetchResult?>(
      'emits [null, FetchResult] with isRetrievedFromCache: false for first load',
      build: () => countryBloc,
      act: (bloc) => bloc.add(const LoadCountriesAction(url: testUrl)),
      expect: () => [
        null,
        isA<FetchResult>().having(
          (r) => r.isRetrievedFromCache,
          'isRetrievedFromCache',
          isFalse,
        ),
      ],
    );

    blocTest<CountryBloc, FetchResult?>(
      'emits [null, FetchResult] with isRetrievedFromCache: true for second load (cached) - bypasses re-emitting null if cached',
      build: () => countryBloc,
      act: (bloc) async {
        bloc.add(const LoadCountriesAction(url: testUrl));
        await Future.delayed(const Duration(seconds: 2));
        bloc.add(const LoadCountriesAction(url: testUrl));
      },
      skip: 2, // Skip first load states
      expect: () => [
        isA<FetchResult>().having(
          (r) => r.isRetrievedFromCache,
          'isRetrievedFromCache',
          isTrue,
        ),
      ],
    );

    blocTest<CountryBloc, FetchResult?>(
      'emits [null, FetchResult] with isRetrievedFromCache: false when isRefresh is true (bypass cache)',
      build: () => countryBloc,
      act: (bloc) async {
        bloc.add(const LoadCountriesAction(url: testUrl));
        await Future.delayed(const Duration(seconds: 2));
        bloc.add(const LoadCountriesAction(url: testUrl, isRefresh: true));
      },
      skip: 2, // Skip first load states
      expect: () => [
        null, // Should emit null again for refresh
        isA<FetchResult>().having(
          (r) => r.isRetrievedFromCache,
          'isRetrievedFromCache',
          isFalse,
        ),
      ],
    );
    group('Loading State Feedback', () {
      blocTest<CountryBloc, FetchResult?>(
        'emits null (loading) before fetching data even if refresh is false (initial load)',
        build: () => countryBloc,
        act: (bloc) => bloc.add(const LoadCountriesAction(url: testUrl)),
        expect: () => [null, isA<FetchResult>()],
      );
    });
  });
}
