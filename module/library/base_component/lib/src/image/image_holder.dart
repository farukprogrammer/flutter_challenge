import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class ImageHolder {
  final String source;
  final NetworkImage? image;
  final File? file;
  final ImageSource imageSource;
  final Uint8List? uint8list;

  final Color? tint;

  /// Image from local asset
  const ImageHolder.asset(this.source, {this.tint}) :
    imageSource = ImageSource.asset, image = null, file = null, uint8list = null;

  /// Image from string url
  const ImageHolder.url(this.source) :
    imageSource = ImageSource.url, image = null, file = null, tint = null, uint8list = null;

  /// Image from [NetworkImage]
  const ImageHolder.network(this.image) :
    imageSource = ImageSource.network, source = "", file = null, tint = null, uint8list = null;

  /// Image from [File]
  const ImageHolder.file(this.file) :
    imageSource = ImageSource.file, image = null, source = "", tint = null, uint8list = null;

  const ImageHolder.memory(this.uint8list) :
    imageSource = ImageSource.memory, source = "", image = null, file = null, tint = null;

  ImageProvider getImageProvider() {
    switch (imageSource) {
      case ImageSource.asset:
        return AssetImage(source);
      case ImageSource.url:
        return NetworkImage(source);
      case ImageSource.network:
        return image ?? const NetworkImage("");
      case ImageSource.file:
        return FileImage(file ?? File(""));
      case ImageSource.memory:
        return MemoryImage(uint8list ?? Uint8List(0));
    }
  }

  @override
  operator ==(other) =>
    other is ImageHolder &&
    other.source == source &&
    other.image == image &&
    other.file?.path == file?.path &&
    other.imageSource == imageSource &&
    other.tint == tint;

  @override
  int get hashCode => hashValues(
    source.hashCode,
    image?.hashCode,
    file?.hashCode,
    imageSource.hashCode,
    tint?.hashCode
  );
}

enum ImageSource {
  asset,
  url,
  network,
  file,
  memory,
}