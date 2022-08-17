import 'package:async/async.dart';
import 'package:entity_book/entity_book.dart';
import 'package:network_client/network_client.dart';
import 'package:nullable_util/nullable_util.dart';

class FakeGetBooksInterface implements GetBooksInterface {
  Result<GoatResponseArray<Book>> defaultResult =
      Result.value(GoatResponseArray());

  Future<Result<GoatResponseArray<Book>>> Function({
    required String fullUrl,
    String? searchQuery,
  })? stubCall;

  @override
  Future<Result<GoatResponseArray<Book>>> getBooks({
    required String fullUrl,
    String? searchQuery,
  }) {
    return stubCall
        .let((it) => it.call(fullUrl: fullUrl, searchQuery: searchQuery))
        .or(Future.value(defaultResult));
  }
}
