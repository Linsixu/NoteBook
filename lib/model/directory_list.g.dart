// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'directory_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListDirectory _$ListDirectoryFromJson(Map<String, dynamic> json) {
  return ListDirectory(
      (json['title'] as List)?.map((e) => e as String)?.toList());
}

Map<String, dynamic> _$ListDirectoryToJson(ListDirectory instance) =>
    <String, dynamic>{'title': instance.title};
