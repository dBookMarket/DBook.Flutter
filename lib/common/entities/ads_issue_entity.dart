import 'package:dbook/generated/json/base/json_field.dart';
import 'package:dbook/generated/json/ads_issue_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class AdsIssueEntity {

	int? id;
	AdsIssueIssue? issue;
  
  AdsIssueEntity();

  factory AdsIssueEntity.fromJson(Map<String, dynamic> json) => $AdsIssueEntityFromJson(json);

  Map<String, dynamic> toJson() => $AdsIssueEntityToJson(this);

  AdsIssueEntity copyWith({int? id, AdsIssueIssue? issue}) {
      return AdsIssueEntity()..id= id ?? this.id
			..issue= issue ?? this.issue;
  }
    
  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class AdsIssueIssue {

	String? id;
	@JSONField(name: "created_at")
	String? createdAt;
	@JSONField(name: "updated_at")
	String? updatedAt;
	AdsIssueIssueBook? book;
	int? quantity;
	double? price;
	double? royalty;
	@JSONField(name: "buy_limit")
	int? buyLimit;
	@JSONField(name: "published_at")
	String? publishedAt;
	int? duration;
	String? status;
	@JSONField(name: "n_circulations")
	int? nCirculations;
	@JSONField(name: "price_range")
	AdsIssueIssuePriceRange? priceRange;
	AdsIssueIssueTrade? trade;
	@JSONField(name: "is_wished")
	bool? isWished;
	@JSONField(name: "n_owners")
	int? nOwners;
	AdsIssueIssueBookmark? bookmark;
	@JSONField(name: "n_owned")
	int? nOwned;
	dynamic token;
	@JSONField(name: "destroy_log")
	String? destroyLog;
  
  AdsIssueIssue();

  factory AdsIssueIssue.fromJson(Map<String, dynamic> json) => $AdsIssueIssueFromJson(json);

  Map<String, dynamic> toJson() => $AdsIssueIssueToJson(this);

  AdsIssueIssue copyWith({String? id, String? createdAt, String? updatedAt, AdsIssueIssueBook? book, int? quantity, double? price, double? royalty, int? buyLimit, String? publishedAt, int? duration, String? status, int? nCirculations, AdsIssueIssuePriceRange? priceRange, AdsIssueIssueTrade? trade, bool? isWished, int? nOwners, AdsIssueIssueBookmark? bookmark, int? nOwned, dynamic token, String? destroyLog}) {
      return AdsIssueIssue()..id= id ?? this.id
			..createdAt= createdAt ?? this.createdAt
			..updatedAt= updatedAt ?? this.updatedAt
			..book= book ?? this.book
			..quantity= quantity ?? this.quantity
			..price= price ?? this.price
			..royalty= royalty ?? this.royalty
			..buyLimit= buyLimit ?? this.buyLimit
			..publishedAt= publishedAt ?? this.publishedAt
			..duration= duration ?? this.duration
			..status= status ?? this.status
			..nCirculations= nCirculations ?? this.nCirculations
			..priceRange= priceRange ?? this.priceRange
			..trade= trade ?? this.trade
			..isWished= isWished ?? this.isWished
			..nOwners= nOwners ?? this.nOwners
			..bookmark= bookmark ?? this.bookmark
			..nOwned= nOwned ?? this.nOwned
			..token= token ?? this.token
			..destroyLog= destroyLog ?? this.destroyLog;
  }
    
  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class AdsIssueIssueBook {

	int? id;
	@JSONField(name: "created_at")
	String? createdAt;
	@JSONField(name: "updated_at")
	String? updatedAt;
	AdsIssueIssueBookAuthor? author;
	String? title;
	String? desc;
	@JSONField(name: "cover_url")
	String? coverUrl;
	String? status;
	AdsIssueIssueBookPreview? preview;
	@JSONField(name: "n_pages")
	int? nPages;
	String? cid;
	@JSONField(name: "has_issued")
	bool? hasIssued;
  
  AdsIssueIssueBook();

  factory AdsIssueIssueBook.fromJson(Map<String, dynamic> json) => $AdsIssueIssueBookFromJson(json);

  Map<String, dynamic> toJson() => $AdsIssueIssueBookToJson(this);

  AdsIssueIssueBook copyWith({int? id, String? createdAt, String? updatedAt, AdsIssueIssueBookAuthor? author, String? title, String? desc, String? coverUrl, String? status, AdsIssueIssueBookPreview? preview, int? nPages, String? cid, bool? hasIssued}) {
      return AdsIssueIssueBook()..id= id ?? this.id
			..createdAt= createdAt ?? this.createdAt
			..updatedAt= updatedAt ?? this.updatedAt
			..author= author ?? this.author
			..title= title ?? this.title
			..desc= desc ?? this.desc
			..coverUrl= coverUrl ?? this.coverUrl
			..status= status ?? this.status
			..preview= preview ?? this.preview
			..nPages= nPages ?? this.nPages
			..cid= cid ?? this.cid
			..hasIssued= hasIssued ?? this.hasIssued;
  }
    
  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class AdsIssueIssueBookAuthor {

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
  
  AdsIssueIssueBookAuthor();

  factory AdsIssueIssueBookAuthor.fromJson(Map<String, dynamic> json) => $AdsIssueIssueBookAuthorFromJson(json);

  Map<String, dynamic> toJson() => $AdsIssueIssueBookAuthorToJson(this);

  AdsIssueIssueBookAuthor copyWith({int? id, String? address, String? name, String? desc, String? avatarUrl, String? websiteUrl, String? discordUrl, String? twitterUrl}) {
      return AdsIssueIssueBookAuthor()..id= id ?? this.id
			..address= address ?? this.address
			..name= name ?? this.name
			..desc= desc ?? this.desc
			..avatarUrl= avatarUrl ?? this.avatarUrl
			..websiteUrl= websiteUrl ?? this.websiteUrl
			..discordUrl= discordUrl ?? this.discordUrl
			..twitterUrl= twitterUrl ?? this.twitterUrl;
  }
    
  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class AdsIssueIssueBookPreview {


  
  AdsIssueIssueBookPreview();

  factory AdsIssueIssueBookPreview.fromJson(Map<String, dynamic> json) => $AdsIssueIssueBookPreviewFromJson(json);

  Map<String, dynamic> toJson() => $AdsIssueIssueBookPreviewToJson(this);

  AdsIssueIssueBookPreview copyWith({key}) {
      return AdsIssueIssueBookPreview();
  }
    
  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class AdsIssueIssuePriceRange {

	@JSONField(name: "min_price")
	double? minPrice;
	@JSONField(name: "max_price")
	double? maxPrice;
  
  AdsIssueIssuePriceRange();

  factory AdsIssueIssuePriceRange.fromJson(Map<String, dynamic> json) => $AdsIssueIssuePriceRangeFromJson(json);

  Map<String, dynamic> toJson() => $AdsIssueIssuePriceRangeToJson(this);

  AdsIssueIssuePriceRange copyWith({double? minPrice, double? maxPrice}) {
      return AdsIssueIssuePriceRange()..minPrice= minPrice ?? this.minPrice
			..maxPrice= maxPrice ?? this.maxPrice;
  }
    
  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class AdsIssueIssueTrade {

	int? id;
	int? quantity;
	double? price;
  
  AdsIssueIssueTrade();

  factory AdsIssueIssueTrade.fromJson(Map<String, dynamic> json) => $AdsIssueIssueTradeFromJson(json);

  Map<String, dynamic> toJson() => $AdsIssueIssueTradeToJson(this);

  AdsIssueIssueTrade copyWith({int? id, int? quantity, double? price}) {
      return AdsIssueIssueTrade()..id= id ?? this.id
			..quantity= quantity ?? this.quantity
			..price= price ?? this.price;
  }
    
  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class AdsIssueIssueBookmark {


  
  AdsIssueIssueBookmark();

  factory AdsIssueIssueBookmark.fromJson(Map<String, dynamic> json) => $AdsIssueIssueBookmarkFromJson(json);

  Map<String, dynamic> toJson() => $AdsIssueIssueBookmarkToJson(this);

  AdsIssueIssueBookmark copyWith({key}) {
      return AdsIssueIssueBookmark();
  }
    
  @override
  String toString() {
    return jsonEncode(this);
  }
}