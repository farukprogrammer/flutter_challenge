import 'package:async/async.dart';
import 'package:domain_book/domain_book.dart';
import 'package:entity_book/entity_book.dart';
import 'package:network_client/network_client.dart';
import 'package:nullable_util/nullable_util.dart';

class FakeGetBooksUseCase implements GetBooksUseCase {
  Result<GoatResponseArray<Book>> defaultResult = Result.value(
    GoatResponseArray(),
  );

  Future<Result<GoatResponseArray<Book>>> Function({
    String? fullUrl,
    String? searchQuery,
  })? stubCall;

  @override
  Future<Result<GoatResponseArray<Book>>> call({
    String? fullUrl,
    String? searchQuery,
  }) {
    return stubCall
        .let((it) => it.call(fullUrl: fullUrl, searchQuery: searchQuery))
        .or(Future.value(defaultResult));
  }
}
