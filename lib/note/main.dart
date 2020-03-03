import 'dart:convert';
import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:note_book/file/title_function.dart';
import 'package:note_book/model/selected_position.dart';
import 'package:note_book/notify/local_data_notify.dart';
import 'package:note_book/utils/show_dialog_helper.dart';
import 'package:provider/provider.dart';

import '../model/directory_list.dart';
import 'details_content.dart';

void main() {
  final localListData = LocalListDataModel();

  runApp(Provider<ListDirectory>.value(
      value: null,
      child: ChangeNotifierProvider.value(
        value: localListData,
        child: MyApp(),
      )));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '图文记录',
      home: NoteListWidget(),
    );
  }
}

class NoteListWidget extends StatefulWidget {
  NoteListWidget({Key key}) : super(key: key);

  @override
  _MyNoteListWidgetState createState() {
    return _MyNoteListWidgetState();
  }
}

class _MyNoteListWidgetState extends State<NoteListWidget> {
  var local = ListDirectory(List<String>());
  bool isload = false;
  bool isShowFileDialog = false;

  @override
  Widget build(BuildContext context) {
    final _localList = Provider.of<LocalListDataModel>(context);
    _localList.directory = local;
    if (!isload) {
      getTitleData().then((data) {
        isload = true;
        if (data.isNotEmpty) {
          try {
            final map = json.decode(data);
            var localData = ListDirectory.fromJson(map);
            _localList.setLocalData(localData.title);
          } catch (e) {
            print("e=$e");
          }
        }
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('本地日记'),
      ),
      body: SizedBox.expand(
        child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  String fileName = _localList.directory.title[index];
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => MyHomePage(title: fileName),
                          settings: RouteSettings(
                              arguments: Selected(index, fileName),
                          )
                      ),
                  );
                },
                child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Align(
                        child: Text('${_localList.directory.title[index]}'))),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
            const Divider(),
            itemCount: _localList.directory.title.length),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!isShowFileDialog) {
            isShowFileDialog = true;
            showNewFileDialog(context).then((fileName) async {
              if (fileName.isNotEmpty) {
                _localList.directory.title.add(fileName);
                showLoadingDialog(context, "正在保持本地数据");
                saveTitleData(convert.jsonEncode(
                    ListDirectory(_localList.directory.title).toJson()))
                    .then((result) {
                  if (result) {
                    Navigator.pop(context);
                    setState(() {});
                    isShowFileDialog = false;
                  }
                });
              }
            });
          }
        },
        tooltip: '创建新文件',
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void deactivate() {}
}
