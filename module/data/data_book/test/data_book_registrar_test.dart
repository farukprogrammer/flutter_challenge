import 'package:data_book/data_book.dart';
import 'package:data_book/src/repo/book_repository.dart';
import 'package:entity_book/entity_book.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_client/network_client.dart';
import 'package:service_locator/service_locator.dart';

main() {
  late final ServiceLocator locator;

  setUpAll(() async {
    locator = GetItServiceLocator();

    locator.registerRegistrar(
      NetworkClientRegistrar(baseUrl: 'https://fakebaseurl.com'),
    );
  });

  test(
    'when DataBookRegistrar register the dependencies, '
    'then it should return correct dependency',
    () async {
      // given
      final dataRegistrar = DataBookRegistrar();

      // when
      await dataRegistrar.register(locator);

      // then
      expect(locator.get<BookRepository>(), isNotNull);
      expect(locator.get<GetBooksInterface>(), isNotNull);
      expect(locator.get<GetBookDetailInterface>(), isNotNull);
    },
  );
}
