import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyLoadingWidget extends StatelessWidget {
  Widget child;
  bool isShow;
  String text;
  List<Widget> children = List<Widget>();

  MyLoadingWidget({ Key key, this.child, this.isShow, this.text})
      : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    children.add(child);
    if (isShow) {
      children.add(SizedBox.expand( //
          child: new Container(
            decoration: ShapeDecoration(
              color: Colors.black54,
              shape: RoundedRectangleBorder(),
            ),
            child: new Center( //保证控件居中效果
              child: new SizedBox(
                width: 120.0,
                height: 120.0,
                child: new Container(
                  decoration: ShapeDecoration(
                    color: Color(0xffffffff),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                  ),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new CircularProgressIndicator(),
                      new Padding(
                        padding: const EdgeInsets.only(
                          top: 20.0,
                        ),
                        child: new Text(
                          text,
                          style: new TextStyle(fontSize: 12.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )// 创建透明层
      ));
    } else {

    }
    return Stack(children: children);
  }
}