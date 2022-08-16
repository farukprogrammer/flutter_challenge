import 'package:collection/collection.dart';
import 'package:base_component/base_component.dart';
import 'package:entity_book/entity_book.dart';
import 'package:flutter/material.dart';

import 'fade_in_text_component.dart';

class BookComponent extends StatelessWidget {
  final Book book;
  final VoidCallback? onTap;

  const BookComponent({
    Key? key,
    required this.book,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 36, 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageComponent.url(
              book.formats.image ?? '',
              width: 80,
              height: 120,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                FadeInTextComponent(
                  book.title,
                  style: TypographyToken.caption12(),
                  width: 240,
                ),
                const SizedBox(height: 6),
                FadeInTextComponent(
                  book.authors.firstOrNull?.name ?? '',
                  style: TypographyToken.body14Bold(),
                  width: 240,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
