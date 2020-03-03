import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:note_book/weight/input_dialog.dart';
import 'package:note_book/weight/loading_view.dart';

showLoadingDialog(BuildContext context, String content) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new LoadingDialog(
          //调用对话框
          text: content,
        );
      });
}

Future<String> showNewFileDialog(BuildContext context) async {
  var result = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return InputDialog();
      });
  return result;
}

Future<bool> showToast(String message) async{
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      textColor: Colors.black,
      fontSize: 8,
      backgroundColor: Colors.white);
}
