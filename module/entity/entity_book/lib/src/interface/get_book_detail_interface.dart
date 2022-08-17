import 'package:async/async.dart';

import '../model/book.dart';

abstract class GetBookDetailInterface {
  static const path = '/books/:id';

  Future<Result<Book>> getBookDetail({
    required String bookId,
  });
}
