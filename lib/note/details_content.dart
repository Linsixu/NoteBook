import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_book/file/file_function.dart';
import 'package:note_book/model/selected_position.dart';
import 'package:note_book/utils/custom_type_list.dart';
import 'package:note_book/utils/rich_text_list.dart';
import 'package:note_book/utils/show_dialog_helper.dart';
import 'package:note_book/weight/fix_image.dart';
import 'dart:convert' as convert;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  RichTextList<CustomTypeList> textList = RichTextList()..initial();
  int currentPosition = 0;
  TextEditingController currentController;

  @override
  Widget build(BuildContext context) {
    Selected selected = ModalRoute.of(context).settings.arguments;
    String fileName = selected.fileName + "-" + selected.position.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: textList.size,
          itemBuilder: (BuildContext context, int position) {
            textList.list[position].key ??= CustomTypeList();
            if (textList.list[position].key.flag == TypeFlag.text) {
              return TextItem(position, textList.list[position],
                  (index, controller) {
                currentPosition = index;
                currentController = controller;
              });
            } else if (textList.list[position].key.flag == TypeFlag.image) {
              return Stack(
                children: <Widget>[
                  Container(
                    child: Image(
                        image:
                            FileImageEx(File(textList.list[position].key.imageUrl))),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                        icon: Icon(Icons.cancel),
                        iconSize: 35,
                        color: Colors.black38,
                        onPressed: () {
                          deleteImage(textList.list[position].key.imageUrl).then((result) {
                            if (result) {
                              showToast("删除成功");
                              textList.remove(position);
                              setState(() {});
                            } else {
                              showToast("删除失败");
                            }
                          });
                        }),
                  ),
                ],
              );
            }
          },
          scrollDirection: Axis.vertical,
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: "single",
            onPressed: () {
              if (currentController == null) return;
              _takePhoto(fileName);
            },
            tooltip: '相机',
            child: Icon(Icons.camera),
          ),
          FloatingActionButton(
            heroTag: "multi",
            onPressed: () {
              _openGallery(fileName);
            },
            tooltip: '图库',
            child: Icon(Icons.photo),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _takePhoto(String fileName) async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      saveImage(image, fileName, (currentPosition + 1).toString()).then((file) {
        if (file != null) {
          textList.insertOne(
              currentPosition,
              getBeforeText(currentController),
              getSelectText(currentController),
              getAfterText(currentController),
              CustomTypeList(
                  flag: TypeFlag.image,
                  imageUrl: file.path,
                  actualIndex: currentPosition + 1));
          setState(() {});
        }
      });
    }
  }

  _openGallery(String fileName) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    if (currentController == null) return;
    if (currentController == null) return;
    saveImage(image, fileName, (currentPosition + 1).toString()).then((file) {
      if (file != null) {
        textList.insertOne(
            currentPosition,
            getBeforeText(currentController),
            getSelectText(currentController),
            getAfterText(currentController),
            CustomTypeList(
                flag: TypeFlag.image,
                imageUrl: file.path,
                actualIndex: currentPosition + 1));
//        print("${convert.jsonEncode(textList.list[currentPosition + 1].key.toJson())}");
        setState(() {});
      }
    });
  }

  String getAfterText(TextEditingController controller) {
    return controller?.selection?.textAfter(controller.text);
  }

  String getSelectText(TextEditingController controller) {
    return controller?.selection?.textInside(controller.text);
  }

  String getBeforeText(TextEditingController controller) {
    return controller?.selection?.textBefore(controller.text);
  }
}

class TextItem extends StatelessWidget {
  final int index;
  final TextEntry<CustomTypeList, String> _entry;
  final Function focusCallBack;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  TextItem(this.index, this._entry, this.focusCallBack) {
    _controller.text = _entry.value;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: new TextField(
        controller: _controller,
        onChanged: (text) => _entry.value = text,
        keyboardType: TextInputType.multiline,
        textDirection: TextDirection.ltr,
        maxLines: null,
        autofocus: index == 0 ? true : false,
        focusNode: _focusNode
          ..addListener(() {
            if (_focusNode.hasFocus) {
              focusCallBack(index, _controller);
              print("当前选择的是:${index}");
            }
          }),
        decoration: InputDecoration(
          hintText: index == 0 ? "在这里开始..." : "在这里继续...",
          border: InputBorder.none,
        ),
      ),
    );
  }
}
