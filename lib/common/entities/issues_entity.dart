import 'package:dbook/generated/json/base/json_field.dart';
import 'package:dbook/generated/json/issues_entity.g.dart';
import 'dart:convert';

import 'book_entity.dart';

@JsonSerializable()
class IssuesEntity {

	String? id;
	@JSONField(name: "created_at")
	String? createdAt;
	@JSONField(name: "updated_at")
	String? updatedAt;
	BookEntity? book;
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
	IssuesToken? token;
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

@JsonSerializable()
class IssuesToken {
	int? id;
	@JSONField(name: "created_at")
	String? createdAt;
	String? issue;
	@JSONField(name: "contract_address")
	String? contractAddress;
	@JSONField(name: "block_chain")
	String? blockChain;
	String? standard;
	String? currency;



	IssuesToken();

	factory IssuesToken.fromJson(Map<String, dynamic> json) => $IssuesTokenFromJson(json);

	Map<String, dynamic> toJson() => $IssuesTokenToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}