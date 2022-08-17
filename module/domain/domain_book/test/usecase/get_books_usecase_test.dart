import 'package:async/async.dart';
import 'package:domain_book/domain_book.dart';
import 'package:fake_entity_book/fake_entity_book.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_client/network_client.dart';

void main() {
  late GetBooksUseCase testUseCase;
  bool shouldGetRepoReturnSuccess = false;

  final testGetBooksInterface = FakeGetBooksInterface()
    ..stubCall = ({required fullUrl, searchQuery}) async {
      if (shouldGetRepoReturnSuccess) {
        return Future.value(Result.value(GoatResponseArray()));
      } else {
        return Future.value(Result.error(const NoInternetException()));
      }
    };

  setUpAll(() {
    testUseCase = GetBooksUseCase(testGetBooksInterface);
  });

  tearDown(() {
    shouldGetRepoReturnSuccess = false;
  });

  test(
    'when interface impl  return error, useCase should return error',
    () async {
      // given
      shouldGetRepoReturnSuccess = false;

      // when then
      final result = await testUseCase.call();
      expect(result.isError, true);
    },
  );

  test(
    'when interface impl  return success, useCase should return success',
    () async {
      // given
      shouldGetRepoReturnSuccess = true;

      // when then
      final result = await testUseCase.call();
      expect(result.isValue, true);
    },
  );
}
