import 'package:dbook/generated/json/base/json_field.dart';
import 'package:dbook/generated/json/pending_order_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class PendingOrderEntity {

	int? id;
	@JSONField(name: "created_at")
	String? createdAt;
	@JSONField(name: "updated_at")
	String? updatedAt;
	PendingOrderUser? user;
	PendingOrderIssue? issue;
	int? quantity;
	double? price;
	@JSONField(name: "is_owned")
	bool? isOwned;
  
  PendingOrderEntity();

  factory PendingOrderEntity.fromJson(Map<String, dynamic> json) => $PendingOrderEntityFromJson(json);

  Map<String, dynamic> toJson() => $PendingOrderEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class PendingOrderUser {

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
  
  PendingOrderUser();

  factory PendingOrderUser.fromJson(Map<String, dynamic> json) => $PendingOrderUserFromJson(json);

  Map<String, dynamic> toJson() => $PendingOrderUserToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class PendingOrderIssue {

	String? id;
	PendingOrderIssueBook? book;
	double? price;
	int? quantity;
	@JSONField(name: "n_circulations")
	int? nCirculations;
	@JSONField(name: "published_at")
	String? publishedAt;
	String? status;
  
  PendingOrderIssue();

  factory PendingOrderIssue.fromJson(Map<String, dynamic> json) => $PendingOrderIssueFromJson(json);

  Map<String, dynamic> toJson() => $PendingOrderIssueToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class PendingOrderIssueBook {

	int? id;
	@JSONField(name: "created_at")
	String? createdAt;
	@JSONField(name: "updated_at")
	String? updatedAt;
	PendingOrderIssueBookAuthor? author;
	String? title;
	String? desc;
	@JSONField(name: "cover_url")
	String? coverUrl;
	String? status;
	PendingOrderIssueBookPreview? preview;
	@JSONField(name: "n_pages")
	int? nPages;
	String? cid;
	@JSONField(name: "has_issued")
	bool? hasIssued;
  
  PendingOrderIssueBook();

  factory PendingOrderIssueBook.fromJson(Map<String, dynamic> json) => $PendingOrderIssueBookFromJson(json);

  Map<String, dynamic> toJson() => $PendingOrderIssueBookToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class PendingOrderIssueBookAuthor {

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
  
  PendingOrderIssueBookAuthor();

  factory PendingOrderIssueBookAuthor.fromJson(Map<String, dynamic> json) => $PendingOrderIssueBookAuthorFromJson(json);

  Map<String, dynamic> toJson() => $PendingOrderIssueBookAuthorToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class PendingOrderIssueBookPreview {

	@JSONField(name: "file_url")
	String? fileUrl;
  
  PendingOrderIssueBookPreview();

  factory PendingOrderIssueBookPreview.fromJson(Map<String, dynamic> json) => $PendingOrderIssueBookPreviewFromJson(json);

  Map<String, dynamic> toJson() => $PendingOrderIssueBookPreviewToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}