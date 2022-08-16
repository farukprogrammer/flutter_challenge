import 'package:async/async.dart';
import 'package:network_client/network_client.dart';

import '../model/book.dart';

abstract class GetBooksInterface {
  static const defaultPathUrl = 'https://gutendex.com/books/';

  Future<Result<GoatResponseArray<Book>>> getBooks({
    String pathUrl = defaultPathUrl,
    String? searchQuery,
  });
}
