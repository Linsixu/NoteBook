import 'dart:io';

import 'package:flutter/material.dart';

class FileImageEx extends FileImage {
  int fileSize;

  FileImageEx(File file, {double scale = 1.0})
      : assert(file != null),
        assert(scale != null),
        super(file, scale: scale) {
    fileSize = file.lengthSync();
  }

  @override
  bool operator ==(dynamic other) {
    if(other.runtimeType != runtimeType)
      return false;
    final FileImageEx typeOther = other;
    return file?.path == typeOther.file?.path
        &&scale == typeOther.scale && fileSize == typeOther.fileSize;
  }

}
