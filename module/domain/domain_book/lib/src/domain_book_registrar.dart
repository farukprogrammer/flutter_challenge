import 'package:service_locator/service_locator.dart';
import 'usecase/get_books_usecase.dart';

class DomainBookRegistrar implements Registrar {
  @override
  Future<void> register(ServiceLocator locator) async {
    locator.registerFactory(() => GetBooksUseCase(locator()));
  }
}
