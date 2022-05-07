import 'dart:convert';
import 'package:dbook/generated/json/base/json_field.dart';
import 'package:dbook/generated/json/assets_entity.g.dart';

@JsonSerializable()
class AssetsEntity {

	int? id;
	@JSONField(name: "created_at")
	String? createdAt;
	@JSONField(name: "updated_at")
	String? updatedAt;
	String? user;
	AssetsIssue? issue;
	int? amount;
	AssetsBookmark? bookmark;
  
  AssetsEntity();

  factory AssetsEntity.fromJson(Map<String, dynamic> json) => $AssetsEntityFromJson(json);

  Map<String, dynamic> toJson() => $AssetsEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class AssetsIssue {

	int? id;
	String? name;
	@JSONField(name: "author_name")
	String? authorName;
	String? cover;
	@JSONField(name: "n_pages")
	int? nPages;
  
  AssetsIssue();

  factory AssetsIssue.fromJson(Map<String, dynamic> json) => $AssetsIssueFromJson(json);

  Map<String, dynamic> toJson() => $AssetsIssueToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class AssetsBookmark {

	int? id;
	int? issue;
	@JSONField(name: "current_page")
	int? currentPage;
  
  AssetsBookmark();

  factory AssetsBookmark.fromJson(Map<String, dynamic> json) => $AssetsBookmarkFromJson(json);

  Map<String, dynamic> toJson() => $AssetsBookmarkToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}