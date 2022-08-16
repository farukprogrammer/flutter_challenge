import 'package:flutter/material.dart';

import '../color/color_token.dart';
import 'image_holder.dart';

class AvatarComponent extends StatelessWidget {
  final ImageHolder _imageHolder;
  final double _size;

  const AvatarComponent({
    Key? key,
    required ImageHolder imageHolder,
    required double size,
  })  : _imageHolder = imageHolder,
        _size = size,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _size,
      height: _size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: _imageHolder.getImageProvider(),
          fit: BoxFit.cover,
        ),
        color: ColorToken.backgroundLow,
        border: Border.all(
          color: ColorToken.borderSubtle,
          width: 1,
        ),
      ),
    );
  }
}
