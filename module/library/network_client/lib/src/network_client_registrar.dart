import 'package:service_locator/service_locator.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'interceptor/request_interceptor.dart';
import 'network_client.dart';

class NetworkClientRegistrar implements Registrar {
  final String baseUrl;

  NetworkClientRegistrar({required this.baseUrl});

  @override
  Future<void> register(ServiceLocator locator) async {
    locator.registerFactory(() => InternetConnectionChecker());
    locator.registerFactory(() => RequestInterceptor(locator()));
    locator.registerFactory<NetworkClient>(
      () => NetworkClient(baseUrl, requestInterceptor: locator()),
    );
  }
}
