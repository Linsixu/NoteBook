import 'package:json_annotation/json_annotation.dart';

part 'directory_list.g.dart';

@JsonSerializable()
class ListDirectory {
  List<String> title;

  ListDirectory(List<String> title) {
    this.title = title;
  }

  factory ListDirectory.fromJson(Map<String, dynamic> json) =>
      _$ListDirectoryFromJson(json);

  Map<String, dynamic> toJson() => _$ListDirectoryToJson(this);
}
