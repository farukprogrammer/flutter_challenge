// DON'T EDIT THE CODE.
// This code generated by lib localization.
import 'package:localization/localization.dart';
import 'package:ui_book/src/locale/book_locale_resource.dart';

class BookLocale extends GoatLocale {
  BookLocale([String? languageCode]) : super(languageCode);
  
  String get books {
    return resource.get('books');
  }
  
  String get booksDetail {
    return resource.get('booksDetail');
  }
  
  String get downloads {
    return resource.get('downloads');
  }
  
  String get readHere {
    return resource.get('readHere');
  }
  
  String authors(dynamic s0) {
    return resource.get('authors', args: [s0]);
  }
  
  @override
  LocaleResource get resource {
    return BookLocaleResource(languageCode);
  }
}
