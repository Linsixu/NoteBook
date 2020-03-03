import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as path;

const String IMAGE_PATH = "image";

Future<File> localFile(String fileName) async {
  final path = _getDirectoryPath();
  return File('$path/$fileName');
}

Future<String> _getDirectoryPath() async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> saveImage(File file, String fileName, String position) async {
  Future<File> result;
  await _getImageFileName().then((directory) {
    result = file.copy(getImagePath(directory, fileName, position));
  });
  return result;
}

Future<bool> deleteImage(String filePath) async {
  File file = File(filePath);
  bool result = await file.exists();
  bool deleteResult = false;
  if (result) {
    await file.delete();
    deleteResult = true;
  } else {
    deleteResult = false;
  }
  return deleteResult;
}

String getImagePath(String directory, String fileName, String position) {
  return '$directory/$fileName-$position.png';
}

Future<String> _getImageFileName() async {
  Directory imageFile;
  await _getDirectoryPath().then((path) {
    imageFile = Directory(path + "/$IMAGE_PATH");
  });
  try {
    bool exists = await imageFile.exists();
    if (!exists) {
      imageFile.create();
    }
  } catch (e) {
    print("创建目录出错=$e");
  }
  return imageFile.path;
}
