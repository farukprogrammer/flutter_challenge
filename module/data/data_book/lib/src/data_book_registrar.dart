import 'package:entity_book/entity_book.dart';
import 'package:service_locator/service_locator.dart';

import 'repo/book_repository.dart';

class DataBookRegistrar implements Registrar {
  @override
  Future<void> register(ServiceLocator locator) async {
    // setup repository dependency
    locator.registerFactory(() => BookRepository(locator()));
    locator.registerFactory<GetBooksInterface>(() => locator<BookRepository>());
  }
}
