import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CustomTypeList {
  TypeFlag flag; //默认为文字——0：文字，1：图片，2：视频，3：音乐
  var imageUrl;
  var actualIndex;
  CustomTypeList({this.flag = TypeFlag.text, this.imageUrl, this.actualIndex});
}

enum TypeFlag { text, image, video, music }
