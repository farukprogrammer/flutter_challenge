import 'package:entity_book/entity_book.dart';

Book createDummyBook({
  int? bookId,
  String? title,
}) {
  return Book(
    id: bookId ?? 1,
    title: title ?? 'fake_title',
  );
}
