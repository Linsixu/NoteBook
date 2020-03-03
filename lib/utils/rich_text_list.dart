import 'package:json_annotation/json_annotation.dart';
import 'package:note_book/utils/custom_type_list.dart';
part 'rich_text_list.g.dart';

@JsonSerializable()
class TextEntry {
  CustomTypeList key;
  String value;

  factory TextEntry(CustomTypeList key, String value) = TextEntry._;

  TextEntry._(this.key, this.value);

  factory TextEntry.fromJson(Map<String, dynamic> json) =>
      _$TextEntryFromJson(json);

  Map<String, dynamic> toJson() => _$TextEntryToJson(this);
}

@JsonSerializable()
class RichTextList {
  List<TextEntry> listValue = [];

  factory RichTextList.fromJson(Map<String, dynamic> json) =>
      _$RichTextListFromJson(json);

  Map<String, dynamic> toJson() => _$RichTextListToJson(this);


  RichTextList(this.listValue);

  void initial() {
    if (listValue.length > 0) throw UnsupportedError("列表已被初始化过");
    listValue.add(TextEntry(null, ""));
  }

  void initialList(List<TextEntry> textPicList) {
    if (listValue.length > 0) throw UnsupportedError("列表已被初始化过");
    listValue = List.from(textPicList);
  }

  void insertOne(int currentPosition, String beforeText, String selectText,
      String afterText, CustomTypeList t) {
    if (listValue.length == 0) throw UnsupportedError("列表尚未初始化");
    if (currentPosition < 0) throw ArgumentError("数字[${currentPosition}]不合法");
    if (currentPosition >= listValue.length)
      throw ArgumentError("[${currentPosition}]数组越界了");
    if (t == null) throw ArgumentError("插入数据不能为空");
    listValue[currentPosition].value = beforeText;
    listValue.insert(currentPosition + 1, TextEntry(t, ""));
    listValue.insert(currentPosition + 2, new TextEntry(null, afterText));
  }

  void insert(int currentPosition, String beforeText, String selectText,
      String afterText, List<CustomTypeList> list) {
    if (listValue.length == 0) throw UnsupportedError("列表尚未初始化");
    if (currentPosition < 0) throw ArgumentError("数字[${currentPosition}]不合法");
    if (currentPosition >= listValue.length)
      throw ArgumentError("[${currentPosition}]数组越界了");
    if (list == null) throw ArgumentError("插入列表不能为空");
    if (list.length == 0) return;
    listValue[currentPosition].value = beforeText;
    for (int i = 0; i < list.length; i++) {
      listValue.insert(currentPosition + 2 * i + 1, TextEntry(list[i], ""));
      listValue.insert(currentPosition + 2 * i + 2,
          new TextEntry(null, i == list.length - 1 ? afterText : ""));
    }
  }

  void remove(int currentPosition) {
    if (listValue.length == 0) throw UnsupportedError("列表尚未初始化");
    if (currentPosition >= listValue.length) throw ArgumentError("长度超过了呀！");
    if (currentPosition <= 0) throw Exception("不应该删除第一个！");
    if (currentPosition < listValue.length - 1) {
      String afterText = listValue[currentPosition + 1].value;
      listValue[currentPosition - 1].value += afterText;
      listValue.removeAt(currentPosition + 1);
      listValue.removeAt(currentPosition);
    } else if (currentPosition == listValue.length - 1)
      throw UnsupportedError("不应该删除的是最后一个！");
  }

  List<TextEntry> get list => listValue;

  int get size => listValue.length;

  void printListText() {
    for (TextEntry t in listValue) {
      print("${t.value} \n");
    }
  }

  @override
  String toString() {
    return 'TextPicList{_textPicList: $listValue}';
  }
}
