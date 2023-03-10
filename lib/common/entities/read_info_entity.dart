import 'package:dbook/generated/json/base/json_field.dart';
import 'package:dbook/generated/json/read_info_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class ReadInfoEntity {

	@JSONField(name: "file_url")
	String? fileUrl;
	ReadInfoBookmark? bookmark;
  
  ReadInfoEntity();

  factory ReadInfoEntity.fromJson(Map<String, dynamic> json) => $ReadInfoEntityFromJson(json);

  Map<String, dynamic> toJson() => $ReadInfoEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ReadInfoBookmark {

	int? id;
	@JSONField(name: "created_at")
	String? createdAt;
	@JSONField(name: "updated_at")
	String? updatedAt;
	String? issue;
	@JSONField(name: "current_page")
	int? currentPage;
  
  ReadInfoBookmark();

  factory ReadInfoBookmark.fromJson(Map<String, dynamic> json) => $ReadInfoBookmarkFromJson(json);

  Map<String, dynamic> toJson() => $ReadInfoBookmarkToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}