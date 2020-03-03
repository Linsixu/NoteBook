import 'package:flutter/material.dart';
import 'package:note_book/utils/show_dialog_helper.dart';

class InputDialog extends Dialog {
  InputDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _newNameController = new TextEditingController();
    // TODO: implement build
    return Material(
        type: MaterialType.transparency, //透明类型
        child: new Center(
          //保证控件居中效果
          child: new SizedBox(
            width: 220.0,
            height: 180.0,
            child: new Container(
                decoration: ShapeDecoration(
                  color: Color(0xffffffff),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                          child: Padding(
                        child: TextField(
                            controller: _newNameController,
                            decoration: InputDecoration(
                                labelText: "新建文件夹名字",
                                hintText: "方便分类",
                                labelStyle: _generateTextStyle(),
                                hintStyle: _generateTextStyle())),
                        padding: EdgeInsets.all(12),
                      )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                              padding: EdgeInsets.all(5.0),
                              child: Text("取消"),
                              color: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                              onPressed: () {
                                return "";
                              },
                            ),
                          ),
                          Expanded(
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                              padding: EdgeInsets.all(5.0),
                              child: Text("确定"),
                              color: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                              onPressed: () {
                                if (_newNameController.text.isEmpty) {
                                  showToast("名字不能为空");
                                  return;
                                } else {
                                  String content = _newNameController.text;
                                  Navigator.pop(context, content);
                                }
                              },
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )),
          ),
        ));
  }

  TextStyle _generateTextStyle() {
    return TextStyle(fontSize: 12);
  }
}
