class NoInternetException implements Exception {
  const NoInternetException();

  String? get message => 'No Internet Exception';

  StackTrace? get stackTrace => null;

  @override
  String toString() => 'NoInternetException';
}
