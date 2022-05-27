import 'dart:convert';
import 'package:dbook/generated/json/base/json_field.dart';
import 'package:dbook/generated/json/read_info_entity.g.dart';

@JsonSerializable()
class ReadInfoEntity {

	List<String>? files;
	String? sk;
  
  ReadInfoEntity();

  factory ReadInfoEntity.fromJson(Map<String, dynamic> json) => $ReadInfoEntityFromJson(json);

  Map<String, dynamic> toJson() => $ReadInfoEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}