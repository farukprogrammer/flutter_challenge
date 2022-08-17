import 'package:domain_book/domain_book.dart';
import 'package:entity_book/entity_book.dart';
import 'package:fake_entity_book/fake_entity_book.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:service_locator/service_locator.dart';

main() {
  late final ServiceLocator locator;

  setUpAll(() async {
    locator = GetItServiceLocator();

    locator.registerFactory<GetBooksInterface>(() => FakeGetBooksInterface());
    locator.registerFactory<GetBookDetailInterface>(
      () => FakeGetBookDetailInterface(),
    );
  });

  test(
    'when DomainBookRegistrar register the dependencies, '
    'then it should return correct dependency',
    () async {
      // given
      final domainRegistrar = DomainBookRegistrar();

      // when
      await domainRegistrar.register(locator);

      // then
      expect(locator.get<GetBooksUseCase>(), isNotNull);
      expect(locator.get<GetBookDetailUseCase>(), isNotNull);
    },
  );
}
