
import 'package:flutter/material.dart';
import 'package:note_book/model/directory_list.dart';

class LocalListDataModel extends ChangeNotifier{
  ListDirectory directory;

  setLocalData(List<String> lists){
    this.directory.title.addAll(lists);
    notifyListeners();
  }
}