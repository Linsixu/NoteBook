// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_type_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomTypeList _$CustomTypeListFromJson(Map<String, dynamic> json) {
  return CustomTypeList(
      flag: _$enumDecodeNullable(_$TypeFlagEnumMap, json['flag']),
      imageUrl: json['imageUrl'],
      actualIndex: json['actualIndex']);
}

Map<String, dynamic> _$CustomTypeListToJson(CustomTypeList instance) =>
    <String, dynamic>{
      'flag': _$TypeFlagEnumMap[instance.flag],
      'imageUrl': instance.imageUrl,
      'actualIndex': instance.actualIndex
    };

T _$enumDecode<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }
  return enumValues.entries
      .singleWhere((e) => e.value == source,
          orElse: () => throw ArgumentError(
              '`$source` is not one of the supported values: '
              '${enumValues.values.join(', ')}'))
      .key;
}

T _$enumDecodeNullable<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source);
}

const _$TypeFlagEnumMap = <TypeFlag, dynamic>{
  TypeFlag.text: 'text',
  TypeFlag.image: 'image',
  TypeFlag.video: 'video',
  TypeFlag.music: 'music'
};
