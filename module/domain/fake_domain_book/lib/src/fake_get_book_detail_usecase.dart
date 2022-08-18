import 'package:async/async.dart';
import 'package:domain_book/domain_book.dart';
import 'package:entity_book/entity_book.dart';
import 'package:fake_entity_book/fake_entity_book.dart';
import 'package:nullable_util/nullable_util.dart';

class FakeGetBookDetailUseCase implements GetBookDetailUseCase {
  Result<Book> defaultResult = Result.value(createDummyBook());

  Future<Result<Book>> Function({required String bookId})? stubCall;

  @override
  Future<Result<Book>> call({
    required String bookId,
  }) {
    return stubCall
        .let((it) => it.call(bookId: bookId))
        .or(Future.value(defaultResult));
  }
}
