// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rich_text_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextEntry _$TextEntryFromJson(Map<String, dynamic> json) {
  return TextEntry(
      json['key'] == null
          ? null
          : CustomTypeList.fromJson(json['key'] as Map<String, dynamic>),
      json['value'] as String);
}

Map<String, dynamic> _$TextEntryToJson(TextEntry instance) =>
    <String, dynamic>{'key': instance.key, 'value': instance.value};

RichTextList _$RichTextListFromJson(Map<String, dynamic> json) {
  return RichTextList((json['listValue'] as List)
      ?.map((e) =>
          e == null ? null : TextEntry.fromJson(e as Map<String, dynamic>))
      ?.toList())
    ..currentImagePosition = json['currentImagePosition'] as int;
}

Map<String, dynamic> _$RichTextListToJson(RichTextList instance) =>
    <String, dynamic>{
      'listValue': instance.listValue,
      'currentImagePosition': instance.currentImagePosition
    };
