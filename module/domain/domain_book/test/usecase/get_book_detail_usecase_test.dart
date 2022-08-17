import 'package:async/async.dart';
import 'package:domain_book/domain_book.dart';
import 'package:fake_entity_book/fake_entity_book.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_client/network_client.dart';

void main() {
  late GetBookDetailUseCase testUseCase;
  bool shouldGetRepoReturnSuccess = false;

  final testGetBookDetailInterface = FakeGetBookDetailInterface()
    ..stubCall = ({required bookId}) async {
      if (shouldGetRepoReturnSuccess) {
        return Future.value(Result.value(createDummyBook()));
      } else {
        return Future.value(Result.error(const NoInternetException()));
      }
    };

  setUpAll(() {
    testUseCase = GetBookDetailUseCase(testGetBookDetailInterface);
  });

  tearDown(() {
    shouldGetRepoReturnSuccess = false;
  });

  test(
    'when interface impl return error, useCase should return error',
        () async {
      // given
      shouldGetRepoReturnSuccess = false;

      // when then
      final result = await testUseCase.call(bookId: '123');
      expect(result.isError, true);
    },
  );

  test(
    'when interface impl return success, useCase should return success',
        () async {
      // given
      shouldGetRepoReturnSuccess = true;

      // when then
      final result = await testUseCase.call(bookId: '123');
      expect(result.isValue, true);
    },
  );
}
