import 'dart:ui';

import 'package:base_component/base_component.dart';
import 'package:collection/collection.dart';
import 'package:entity_book/entity_book.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:ui_book/src/locale/book_locale.dart';

class BookDetailComponent extends StatelessWidget {
  static const noImageAsset = 'packages/ui_book/asset/image/no_image.jpg';
  static const double imageWidth = 180;
  static const double imageHeight = 240;
  static const double imagePlaceHolderSize = 300;

  final Book book;
  final VoidCallback? onTapTitle;
  final VoidCallback? onTapAuthor;
  final VoidCallback? onTapDownload;

  const BookDetailComponent({
    Key? key,
    required this.book,
    this.onTapTitle,
    this.onTapAuthor,
    this.onTapDownload,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = GoatLocale.of<BookLocale>(context);

    final imageUrl = book.formats.image?.isNotEmpty == true
        ? book.formats.image!
        : noImageAsset;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          height: imagePlaceHolderSize,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Center(
              child: ImageComponent.network(
                NetworkImage(imageUrl),
                key: UniqueKey(),
                width: imageWidth,
                height: imageHeight,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Tappable(
            onTap: onTapTitle,
            child: TextComponent(
              book.title,
              style: TypographyToken.heading24(),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: Tappable(
            onTap: onTapAuthor,
            child: TextComponent(
              book.authors.firstOrNull?.name ?? '',
              style: TypographyToken.body16(),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: Tappable(
            onTap: onTapDownload,
            child: TextComponent(
              '${locale.downloads}: ${book.downloadCount}',
              style: TypographyToken.caption12(),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: ButtonLinkComponent(
            locale.readHere,
            style: BaseLinkStyle.primary(),
          ),
        ),
      ],
    );
  }
}
