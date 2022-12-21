import 'package:dbook/generated/json/base/json_field.dart';
import 'package:dbook/generated/json/issues_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class IssuesEntity {

	String? id;
	@JSONField(name: "created_at")
	String? createdAt;
	@JSONField(name: "updated_at")
	String? updatedAt;
	IssuesBook? book;
	int? quantity;
	double? price;
	int? royalty;
	@JSONField(name: "buy_limit")
	int? buyLimit;
	@JSONField(name: "published_at")
	String? publishedAt;
	int? duration;
	String? status;
	@JSONField(name: "n_circulations")
	int? nCirculations;
	@JSONField(name: "price_range")
	IssuesPriceRange? priceRange;
	IssuesTrade? trade;
	@JSONField(name: "is_wished")
	bool? isWished;
	@JSONField(name: "n_owners")
	int? nOwners;
	IssuesBookmark? bookmark;
	dynamic token;
	@JSONField(name: "destroy_log")
	String? destroyLog;
  
  IssuesEntity();

  factory IssuesEntity.fromJson(Map<String, dynamic> json) => $IssuesEntityFromJson(json);

  Map<String, dynamic> toJson() => $IssuesEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class IssuesBook {

	int? id;
	@JSONField(name: "created_at")
	String? createdAt;
	@JSONField(name: "updated_at")
	String? updatedAt;
	IssuesBookAuthor? author;
	String? title;
	String? desc;
	@JSONField(name: "cover_url")
	String? coverUrl;
	String? status;
	IssuesBookPreview? preview;
	@JSONField(name: "n_pages")
	int? nPages;
	String? cid;
  
  IssuesBook();

  factory IssuesBook.fromJson(Map<String, dynamic> json) => $IssuesBookFromJson(json);

  Map<String, dynamic> toJson() => $IssuesBookToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class IssuesBookAuthor {

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
  
  IssuesBookAuthor();

  factory IssuesBookAuthor.fromJson(Map<String, dynamic> json) => $IssuesBookAuthorFromJson(json);

  Map<String, dynamic> toJson() => $IssuesBookAuthorToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class IssuesBookPreview {


  
  IssuesBookPreview();

  factory IssuesBookPreview.fromJson(Map<String, dynamic> json) => $IssuesBookPreviewFromJson(json);

  Map<String, dynamic> toJson() => $IssuesBookPreviewToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class IssuesPriceRange {

	@JSONField(name: "min_price")
	double? minPrice;
	@JSONField(name: "max_price")
	double? maxPrice;
  
  IssuesPriceRange();

  factory IssuesPriceRange.fromJson(Map<String, dynamic> json) => $IssuesPriceRangeFromJson(json);

  Map<String, dynamic> toJson() => $IssuesPriceRangeToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class IssuesTrade {

	int? id;
	int? quantity;
	double? price;
  
  IssuesTrade();

  factory IssuesTrade.fromJson(Map<String, dynamic> json) => $IssuesTradeFromJson(json);

  Map<String, dynamic> toJson() => $IssuesTradeToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class IssuesBookmark {


  
  IssuesBookmark();

  factory IssuesBookmark.fromJson(Map<String, dynamic> json) => $IssuesBookmarkFromJson(json);

  Map<String, dynamic> toJson() => $IssuesBookmarkToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}