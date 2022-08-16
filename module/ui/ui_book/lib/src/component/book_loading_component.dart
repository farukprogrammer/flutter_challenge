import 'package:base_component/base_component.dart';
import 'package:flutter/material.dart';

class BookLoadingComponent extends StatelessWidget {
  const BookLoadingComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 21, 36, 21),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const LoadingPlaceholderComponent.rectangle(
            width: 80,
            height: 120,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(height: 16),
              LoadingPlaceholderComponent.rectangle(
                width: 200,
                height: 16,
                radius: CornerToken.radius4,
              ),
              SizedBox(height: 16),
              LoadingPlaceholderComponent.rectangle(
                width: 100,
                height: 8,
                radius: CornerToken.radius4,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
