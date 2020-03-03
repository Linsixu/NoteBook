import 'dart:io';

import 'package:path_provider/path_provider.dart';

const String TITLE_PATH = "details";
const String TITLE_END = ".json";

Future<bool> saveDetailsData(String contents, String fileName) async {
  bool result = false;
  IOSink sink;
  File file = await _createJsonFile(fileName);
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

Future<String> getDetailsData(String fileName) async {
  try {
    final file = await _createJsonFile(fileName);
    String dates = await file.readAsString();
    return dates;
  } catch (e) {
    return "";
  }
}

/**
 * 创建json文件
 * name是上个页面的文件夹名字，index对应的是哪一行
 */
Future<File> _createJsonFile(String fileName) async {
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
  return File('${imageFile.path}/${fileName}TITLE_END');
}

Future<String> _getDirectoryPath() async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}
