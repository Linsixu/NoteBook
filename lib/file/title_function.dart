import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

const String TITLE_PATH = "title";
const String TITLE_END = "data.json";

Future<bool> saveTitleData(String contents) async {
  bool result = false;
  IOSink sink;
  File file = await _getTitleFile();
  try {
    sink = file.openWrite();
    sink.write(contents);
    await sink.flush();
    result = true;
  } catch (e) {
    print("存储失败:$e");
    result = false;
  } finally {
    sink?.close();
  }
  return result;
}

Future<String> getTitleData() async {
  try {
    final file = await _getTitleFile();
    String dates = await file.readAsString();
    return dates;
  } catch (e) {
    return "";
  }
}

Future<File> _getTitleFile() async {
  Directory imageFile;
  await _getDirectoryPath().then((path) {
    imageFile = Directory(path + "/$TITLE_PATH");
  });
  try {
    bool exists = await imageFile.exists();
    if (!exists) {
      imageFile.create();
    }
  } catch (e) {
    print("创建目录出错=$e");
  }
  return File('${imageFile.path}/TITLE_END');
}

Future<bool> saveTitleFile() async {
  Directory imageFile;
  await _getDirectoryPath().then((path) {
    imageFile = Directory(path + "/$TITLE_PATH");
  });
  try {
    bool exists = await imageFile.exists();
    if (!exists) {
      imageFile.create();
      var file = File(imageFile.path);
    } else {}
  } catch (e) {
    print("创建目录出错=$e");
  }
}

Future<String> _getDirectoryPath() async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}
