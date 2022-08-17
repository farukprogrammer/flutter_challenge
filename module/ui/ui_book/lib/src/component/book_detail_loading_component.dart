import 'package:base_component/base_component.dart';
import 'package:flutter/material.dart';

class BookDetailLoadingComponent extends StatelessWidget {
  static const double imagePlaceHolderSize = 260;

  const BookDetailLoadingComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        LoadingPlaceholderComponent.rectangle(
          width: double.infinity,
          height: imagePlaceHolderSize,
        ),
        SizedBox(height: 16),
        LoadingPlaceholderComponent.rectangle(
          width: 200,
          height: 32,
          radius: CornerToken.radius4,
        ),
        SizedBox(height: 16),
        LoadingPlaceholderComponent.rectangle(
          width: 150,
          height: 16,
          radius: CornerToken.radius4,
        ),
        SizedBox(height: 16),
        LoadingPlaceholderComponent.rectangle(
          width: 120,
          height: 12,
          radius: CornerToken.radius4,
        ),
        SizedBox(height: 16),
        LoadingPlaceholderComponent.rectangle(
          width: 100,
          height: 16,
          radius: CornerToken.radius4,
        ),
      ],
    );
  }
}
