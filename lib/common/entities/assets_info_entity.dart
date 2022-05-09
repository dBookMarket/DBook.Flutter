import 'dart:convert';
import 'package:dbook/generated/json/base/json_field.dart';
import 'package:dbook/generated/json/assets_info_entity.g.dart';

@JsonSerializable()
class AssetsInfoEntity {

	int? count;
	@JSONField(name: "page_size")
	int? pageSize;
	@JSONField(name: "page_count")
	int? pageCount;
	@JSONField(name: "page_number")
	int? pageNumber;
	dynamic next;
	dynamic previous;
	List<AssetsInfoResults>? results;
  
  AssetsInfoEntity();

  factory AssetsInfoEntity.fromJson(Map<String, dynamic> json) => $AssetsInfoEntityFromJson(json);

  Map<String, dynamic> toJson() => $AssetsInfoEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class AssetsInfoResults {

	int? id;
	@JSONField(name: "created_at")
	String? createdAt;
	@JSONField(name: "updated_at")
	String? updatedAt;
	String? user;
	AssetsInfoResultsIssue? issue;
	int? amount;
	AssetsInfoResultsBookmark? bookmark;
  
  AssetsInfoResults();

  factory AssetsInfoResults.fromJson(Map<String, dynamic> json) => $AssetsInfoResultsFromJson(json);

  Map<String, dynamic> toJson() => $AssetsInfoResultsToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class AssetsInfoResultsIssue {

	int? id;
	String? name;
	@JSONField(name: "author_name")
	String? authorName;
	@JSONField(name: "cover_url")
	String? coverUrl;
	@JSONField(name: "n_pages")
	int? nPages;
	String? status;
  
  AssetsInfoResultsIssue();

  factory AssetsInfoResultsIssue.fromJson(Map<String, dynamic> json) => $AssetsInfoResultsIssueFromJson(json);

  Map<String, dynamic> toJson() => $AssetsInfoResultsIssueToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class AssetsInfoResultsBookmark {

	int? id;
	int? issue;
	@JSONField(name: "current_page")
	int? currentPage;
  
  AssetsInfoResultsBookmark();

  factory AssetsInfoResultsBookmark.fromJson(Map<String, dynamic> json) => $AssetsInfoResultsBookmarkFromJson(json);

  Map<String, dynamic> toJson() => $AssetsInfoResultsBookmarkToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}