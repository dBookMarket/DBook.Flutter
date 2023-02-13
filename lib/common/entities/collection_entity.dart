import 'package:dbook/generated/json/base/json_field.dart';
import 'package:dbook/generated/json/collection_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class CollectionEntity {

	int? id;
	CollectionIssue? issue;
	int? quantity;
  
  CollectionEntity();

  factory CollectionEntity.fromJson(Map<String, dynamic> json) => $CollectionEntityFromJson(json);

  Map<String, dynamic> toJson() => $CollectionEntityToJson(this);

  CollectionEntity copyWith({int? id, CollectionIssue? issue, int? quantity}) {
      return CollectionEntity()..id= id ?? this.id
			..issue= issue ?? this.issue
			..quantity= quantity ?? this.quantity;
  }
    
  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class CollectionIssue {

	String? id;
	CollectionIssueBook? book;
	double? price;
	int? quantity;
	@JSONField(name: "n_circulations")
	int? nCirculations;
	@JSONField(name: "published_at")
	String? publishedAt;
  
  CollectionIssue();

  factory CollectionIssue.fromJson(Map<String, dynamic> json) => $CollectionIssueFromJson(json);

  Map<String, dynamic> toJson() => $CollectionIssueToJson(this);

  CollectionIssue copyWith({String? id, CollectionIssueBook? book, double? price, int? quantity, int? nCirculations, String? publishedAt}) {
      return CollectionIssue()..id= id ?? this.id
			..book= book ?? this.book
			..price= price ?? this.price
			..quantity= quantity ?? this.quantity
			..nCirculations= nCirculations ?? this.nCirculations
			..publishedAt= publishedAt ?? this.publishedAt;
  }
    
  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class CollectionIssueBook {

	int? id;
	@JSONField(name: "created_at")
	String? createdAt;
	@JSONField(name: "updated_at")
	String? updatedAt;
	CollectionIssueBookAuthor? author;
	String? title;
	String? desc;
	@JSONField(name: "cover_url")
	String? coverUrl;
	String? status;
	@JSONField(name: "n_pages")
	int? nPages;
	String? cid;
	@JSONField(name: "has_issued")
	bool? hasIssued;
  
  CollectionIssueBook();

  factory CollectionIssueBook.fromJson(Map<String, dynamic> json) => $CollectionIssueBookFromJson(json);

  Map<String, dynamic> toJson() => $CollectionIssueBookToJson(this);

  CollectionIssueBook copyWith({int? id, String? createdAt, String? updatedAt, CollectionIssueBookAuthor? author, String? title, String? desc, String? coverUrl, String? status,  int? nPages, String? cid, bool? hasIssued}) {
      return CollectionIssueBook()..id= id ?? this.id
			..createdAt= createdAt ?? this.createdAt
			..updatedAt= updatedAt ?? this.updatedAt
			..author= author ?? this.author
			..title= title ?? this.title
			..desc= desc ?? this.desc
			..coverUrl= coverUrl ?? this.coverUrl
			..status= status ?? this.status
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
class CollectionIssueBookAuthor {

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
  
  CollectionIssueBookAuthor();

  factory CollectionIssueBookAuthor.fromJson(Map<String, dynamic> json) => $CollectionIssueBookAuthorFromJson(json);

  Map<String, dynamic> toJson() => $CollectionIssueBookAuthorToJson(this);

  CollectionIssueBookAuthor copyWith({int? id, String? address, String? name, String? desc, String? avatarUrl, String? websiteUrl, String? discordUrl, String? twitterUrl}) {
      return CollectionIssueBookAuthor()..id= id ?? this.id
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
