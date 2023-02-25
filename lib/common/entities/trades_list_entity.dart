import 'package:dbook/generated/json/base/json_field.dart';
import 'package:dbook/generated/json/trades_list_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class TradesListEntity {

	int? id;
	@JSONField(name: "created_at")
	String? createdAt;
	@JSONField(name: "updated_at")
	String? updatedAt;
	TradesListUser? user;
	TradesListIssue? issue;
	int? quantity;
	double? price;
	@JSONField(name: "is_owned")
	bool? isOwned;
  
  TradesListEntity();

  factory TradesListEntity.fromJson(Map<String, dynamic> json) => $TradesListEntityFromJson(json);

  Map<String, dynamic> toJson() => $TradesListEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class TradesListUser {

	int? id;
	String? address;
	String? name;
	String? desc;
	@JSONField(name: "avatar_url")
	String? avatarUrl;
	@JSONField(name: "website_url")
	String? websiteUrl;
	@JSONField(name: "discord_url")
	String? discordUrl;
	@JSONField(name: "twitter_url")
	String? twitterUrl;
  
  TradesListUser();

  factory TradesListUser.fromJson(Map<String, dynamic> json) => $TradesListUserFromJson(json);

  Map<String, dynamic> toJson() => $TradesListUserToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class TradesListIssue {

	String? id;
	TradesListIssueBook? book;
	double? price;
	int? quantity;
	@JSONField(name: "n_circulations")
	int? nCirculations;
	@JSONField(name: "published_at")
	String? publishedAt;
	String? status;
  
  TradesListIssue();

  factory TradesListIssue.fromJson(Map<String, dynamic> json) => $TradesListIssueFromJson(json);

  Map<String, dynamic> toJson() => $TradesListIssueToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class TradesListIssueBook {

	int? id;
	@JSONField(name: "created_at")
	String? createdAt;
	@JSONField(name: "updated_at")
	String? updatedAt;
	TradesListIssueBookAuthor? author;
	String? title;
	String? desc;
	@JSONField(name: "cover_url")
	String? coverUrl;
	String? status;
	TradesListIssueBookPreview? preview;
	@JSONField(name: "n_pages")
	int? nPages;
	String? cid;
	@JSONField(name: "has_issued")
	bool? hasIssued;
  
  TradesListIssueBook();

  factory TradesListIssueBook.fromJson(Map<String, dynamic> json) => $TradesListIssueBookFromJson(json);

  Map<String, dynamic> toJson() => $TradesListIssueBookToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class TradesListIssueBookAuthor {

	int? id;
	String? address;
	String? name;
	String? desc;
	@JSONField(name: "avatar_url")
	String? avatarUrl;
	@JSONField(name: "website_url")
	String? websiteUrl;
	@JSONField(name: "discord_url")
	String? discordUrl;
	@JSONField(name: "twitter_url")
	String? twitterUrl;
  
  TradesListIssueBookAuthor();

  factory TradesListIssueBookAuthor.fromJson(Map<String, dynamic> json) => $TradesListIssueBookAuthorFromJson(json);

  Map<String, dynamic> toJson() => $TradesListIssueBookAuthorToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class TradesListIssueBookPreview {

	@JSONField(name: "file_url")
	String? fileUrl;
  
  TradesListIssueBookPreview();

  factory TradesListIssueBookPreview.fromJson(Map<String, dynamic> json) => $TradesListIssueBookPreviewFromJson(json);

  Map<String, dynamic> toJson() => $TradesListIssueBookPreviewToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}