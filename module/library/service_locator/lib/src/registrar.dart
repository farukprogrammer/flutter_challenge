import 'service_locator.dart';

abstract class Registrar {
  Future<void> register(ServiceLocator locator);
}
