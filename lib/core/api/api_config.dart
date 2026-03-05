enum Environment { dev, prod, test }

class ApiConfig {
  static const Environment currentEnv = Environment.dev;
  String code ;
  ApiConfig(this.code);
  

  static const Map<Environment, String> urls = {
    Environment.dev: 'http://127.0.0.1:5500',
    Environment.prod: 'https://restcountries.com/v3.1',
    Environment.test: '',
  };

  static String get baseUrl => urls[currentEnv]!;
}