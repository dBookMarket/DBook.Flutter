import 'package:dbook/generated/json/base/json_field.dart';
import 'package:dbook/generated/json/concern_opus_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class ConcernOpusEntity {

	int? id;
	@JSONField(name: "created_at")
	String? createdAt;
	@JSONField(name: "updated_at")
	String? updatedAt;
	int? user;
	ConcernOpusIssue? issue;
  
  ConcernOpusEntity();

  factory ConcernOpusEntity.fromJson(Map<String, dynamic> json) => $ConcernOpusEntityFromJson(json);

  Map<String, dynamic> toJson() => $ConcernOpusEntityToJson(this);

  ConcernOpusEntity copyWith({int? id, String? createdAt, String? updatedAt, int? user, ConcernOpusIssue? issue}) {
      return ConcernOpusEntity()..id= id ?? this.id
			..createdAt= createdAt ?? this.createdAt
			..updatedAt= updatedAt ?? this.updatedAt
			..user= user ?? this.user
			..issue= issue ?? this.issue;
  }
    
  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ConcernOpusIssue {

	String? id;
	ConcernOpusIssueBook? book;
	double? price;
	int? quantity;
	@JSONField(name: "n_circulations")
	int? nCirculations;
	@JSONField(name: "published_at")
	String? publishedAt;
  
  ConcernOpusIssue();

  factory ConcernOpusIssue.fromJson(Map<String, dynamic> json) => $ConcernOpusIssueFromJson(json);

  Map<String, dynamic> toJson() => $ConcernOpusIssueToJson(this);

  ConcernOpusIssue copyWith({String? id, ConcernOpusIssueBook? book, double? price, int? quantity, int? nCirculations, String? publishedAt}) {
      return ConcernOpusIssue()..id= id ?? this.id
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
class ConcernOpusIssueBook {

	int? id;
	@JSONField(name: "created_at")
	String? createdAt;
	@JSONField(name: "updated_at")
	String? updatedAt;
	ConcernOpusIssueBookAuthor? author;
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
  
  ConcernOpusIssueBook();

  factory ConcernOpusIssueBook.fromJson(Map<String, dynamic> json) => $ConcernOpusIssueBookFromJson(json);

  Map<String, dynamic> toJson() => $ConcernOpusIssueBookToJson(this);

  ConcernOpusIssueBook copyWith({int? id, String? createdAt, String? updatedAt, ConcernOpusIssueBookAuthor? author, String? title, String? desc, String? coverUrl, String? status,int? nPages, String? cid, bool? hasIssued}) {
      return ConcernOpusIssueBook()..id= id ?? this.id
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
class ConcernOpusIssueBookAuthor {

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
  
  ConcernOpusIssueBookAuthor();

  factory ConcernOpusIssueBookAuthor.fromJson(Map<String, dynamic> json) => $ConcernOpusIssueBookAuthorFromJson(json);

  Map<String, dynamic> toJson() => $ConcernOpusIssueBookAuthorToJson(this);

  ConcernOpusIssueBookAuthor copyWith({int? id, String? address, String? name, String? desc, String? avatarUrl, String? websiteUrl, String? discordUrl, String? twitterUrl}) {
      return ConcernOpusIssueBookAuthor()..id= id ?? this.id
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
