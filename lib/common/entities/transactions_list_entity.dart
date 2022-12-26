import 'package:dbook/generated/json/base/json_field.dart';
import 'package:dbook/generated/json/transactions_list_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class TransactionsListEntity {

	int? id;
	@JSONField(name: "created_at")
	String? createdAt;
	@JSONField(name: "updated_at")
	String? updatedAt;
	int? trade;
	TransactionsListIssue? issue;
	int? quantity;
	double? price;
	TransactionsListSeller? seller;
	TransactionsListBuyer? buyer;
	String? status;
	String? hash;
	@JSONField(name: "source")
	int? xSource;
	String? type;
  
  TransactionsListEntity();

  factory TransactionsListEntity.fromJson(Map<String, dynamic> json) => $TransactionsListEntityFromJson(json);

  Map<String, dynamic> toJson() => $TransactionsListEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class TransactionsListIssue {

	String? id;
	TransactionsListIssueBook? book;
	double? price;
	int? quantity;
	@JSONField(name: "n_circulations")
	int? nCirculations;
	@JSONField(name: "published_at")
	String? publishedAt;
  
  TransactionsListIssue();

  factory TransactionsListIssue.fromJson(Map<String, dynamic> json) => $TransactionsListIssueFromJson(json);

  Map<String, dynamic> toJson() => $TransactionsListIssueToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class TransactionsListIssueBook {

	int? id;
	@JSONField(name: "created_at")
	String? createdAt;
	@JSONField(name: "updated_at")
	String? updatedAt;
	TransactionsListIssueBookAuthor? author;
	String? title;
	String? desc;
	@JSONField(name: "cover_url")
	String? coverUrl;
	String? status;
	TransactionsListIssueBookPreview? preview;
	@JSONField(name: "n_pages")
	int? nPages;
	String? cid;
  
  TransactionsListIssueBook();

  factory TransactionsListIssueBook.fromJson(Map<String, dynamic> json) => $TransactionsListIssueBookFromJson(json);

  Map<String, dynamic> toJson() => $TransactionsListIssueBookToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class TransactionsListIssueBookAuthor {

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
  
  TransactionsListIssueBookAuthor();

  factory TransactionsListIssueBookAuthor.fromJson(Map<String, dynamic> json) => $TransactionsListIssueBookAuthorFromJson(json);

  Map<String, dynamic> toJson() => $TransactionsListIssueBookAuthorToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class TransactionsListIssueBookPreview {


  
  TransactionsListIssueBookPreview();

  factory TransactionsListIssueBookPreview.fromJson(Map<String, dynamic> json) => $TransactionsListIssueBookPreviewFromJson(json);

  Map<String, dynamic> toJson() => $TransactionsListIssueBookPreviewToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class TransactionsListSeller {

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
  
  TransactionsListSeller();

  factory TransactionsListSeller.fromJson(Map<String, dynamic> json) => $TransactionsListSellerFromJson(json);

  Map<String, dynamic> toJson() => $TransactionsListSellerToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class TransactionsListBuyer {

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
  
  TransactionsListBuyer();

  factory TransactionsListBuyer.fromJson(Map<String, dynamic> json) => $TransactionsListBuyerFromJson(json);

  Map<String, dynamic> toJson() => $TransactionsListBuyerToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}