import 'package:json_annotation/json_annotation.dart';

part 'custom_type_list.g.dart';
@JsonSerializable()
class CustomTypeList {
  TypeFlag flag; //默认为文字——0：文字，1：图片，2：视频，3：音乐
  var imageUrl;
  var actualIndex;
  CustomTypeList({this.flag = TypeFlag.text, this.imageUrl, this.actualIndex});

  factory CustomTypeList.fromJson(Map<String, dynamic> json) =>
      _$CustomTypeListFromJson(json);

  Map<String, dynamic> toJson() => _$CustomTypeListToJson(this);
}

enum TypeFlag { text, image, video, music }
