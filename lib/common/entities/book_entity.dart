import 'package:dbook/generated/json/base/json_field.dart';
import 'package:dbook/generated/json/book_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class BookEntity {

	int? id;
	@JSONField(name: "created_at")
	String? createdAt;
	@JSONField(name: "updated_at")
	String? updatedAt;
	BookAuthor? author;
	String? title;
	String? desc;
	@JSONField(name: "cover_url")
	String? coverUrl;
	String? status;
	BookPreview? preview;
	@JSONField(name: "n_pages")
	int? nPages;
	String? cid;
	@JSONField(name: "has_issued")
	bool? hasIssued;
  
  BookEntity();

  factory BookEntity.fromJson(Map<String, dynamic> json) => $BookEntityFromJson(json);

  Map<String, dynamic> toJson() => $BookEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BookAuthor {

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
  
  BookAuthor();

  factory BookAuthor.fromJson(Map<String, dynamic> json) => $BookAuthorFromJson(json);

  Map<String, dynamic> toJson() => $BookAuthorToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BookPreview {

	@JSONField(name: "file_url")
	String? fileUrl;
  
  BookPreview();

  factory BookPreview.fromJson(Map<String, dynamic> json) => $BookPreviewFromJson(json);

  Map<String, dynamic> toJson() => $BookPreviewToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}