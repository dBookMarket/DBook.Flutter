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
	IssuesPriceRange? priceRange;
	IssuesTrade? trade;
	@JSONField(name: "is_wished")
	bool? isWished;
	@JSONField(name: "n_owners")
	int? nOwners;
	IssuesBookmark? bookmark;
	@JSONField(name: "n_owned")
	int? nOwned;
	IssuesToken? token;
	@JSONField(name: "destroy_log")
	String? destroyLog;
  
  IssuesEntity();

  factory IssuesEntity.fromJson(Map<String, dynamic> json) => $IssuesEntityFromJson(json);

  Map<String, dynamic> toJson() => $IssuesEntityToJson(this);

  IssuesEntity copyWith({String? id, String? createdAt, String? updatedAt, IssuesBook? book, int? quantity, double? price, double? royalty, int? buyLimit, String? publishedAt, int? duration, String? status, int? nCirculations, IssuesPriceRange? priceRange, IssuesTrade? trade, bool? isWished, int? nOwners, IssuesBookmark? bookmark, int? nOwned, dynamic token, String? destroyLog}) {
      return IssuesEntity()..id= id ?? this.id
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
	@JSONField(name: "has_issued")
	bool? hasIssued;
  
  IssuesBook();

  factory IssuesBook.fromJson(Map<String, dynamic> json) => $IssuesBookFromJson(json);

  Map<String, dynamic> toJson() => $IssuesBookToJson(this);

  IssuesBook copyWith({int? id, String? createdAt, String? updatedAt, IssuesBookAuthor? author, String? title, String? desc, String? coverUrl, String? status, IssuesBookPreview? preview, int? nPages, String? cid, bool? hasIssued}) {
      return IssuesBook()..id= id ?? this.id
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

  IssuesBookAuthor copyWith({int? id, String? address, String? name, String? desc, String? avatarUrl, String? websiteUrl, String? discordUrl, String? twitterUrl}) {
      return IssuesBookAuthor()..id= id ?? this.id
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
class IssuesBookPreview {
	@JSONField(name: "file_url")
	String? url;

  
  IssuesBookPreview();

  factory IssuesBookPreview.fromJson(Map<String, dynamic> json) => $IssuesBookPreviewFromJson(json);

  Map<String, dynamic> toJson() => $IssuesBookPreviewToJson(this);

  IssuesBookPreview copyWith({dynamic key}) {
      return IssuesBookPreview();
  }
    
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

  IssuesPriceRange copyWith({double? minPrice, double? maxPrice}) {
      return IssuesPriceRange()..minPrice= minPrice ?? this.minPrice
			..maxPrice= maxPrice ?? this.maxPrice;
  }
    
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

  IssuesTrade copyWith({int? id, int? quantity, double? price}) {
      return IssuesTrade()..id= id ?? this.id
			..quantity= quantity ?? this.quantity
			..price= price ?? this.price;
  }
    
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

  IssuesBookmark copyWith({dynamic key}) {
      return IssuesBookmark();
  }

  @override
  String toString() {
    return jsonEncode(this);
  }
}


@JsonSerializable()
class IssuesToken {

	int? id;
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

	IssuesToken copyWith({int? id, String? issue, String? contractAddress, String? blockChain, String? standard, String? currency}) {
		return IssuesToken()..id= id ?? this.id
			..issue= issue ?? this.issue
			..contractAddress= contractAddress ?? this.contractAddress
			..blockChain= contractAddress ?? this.blockChain
			..standard= contractAddress ?? this.standard
			..currency= contractAddress ?? this.currency
		;
	}

	@override
	String toString() {
		return jsonEncode(this);
	}
}