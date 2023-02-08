import 'package:dbook/generated/json/base/json_field.dart';
import 'package:dbook/generated/json/drafts_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class DraftsEntity {

	int? id;
	@JSONField(name: "created_at")
	String? createdAt;
	@JSONField(name: "updated_at")
	String? updatedAt;
	DraftsAuthor? author;
	String? title;
	String? content;
  
  DraftsEntity();

  factory DraftsEntity.fromJson(Map<String, dynamic> json) => $DraftsEntityFromJson(json);

  Map<String, dynamic> toJson() => $DraftsEntityToJson(this);

  DraftsEntity copyWith({int? id, String? createdAt, String? updatedAt, DraftsAuthor? author, String? title, String? content}) {
      return DraftsEntity()..id= id ?? this.id
			..createdAt= createdAt ?? this.createdAt
			..updatedAt= updatedAt ?? this.updatedAt
			..author= author ?? this.author
			..title= title ?? this.title
			..content= content ?? this.content;
  }
    
  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class DraftsAuthor {

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
  
  DraftsAuthor();

  factory DraftsAuthor.fromJson(Map<String, dynamic> json) => $DraftsAuthorFromJson(json);

  Map<String, dynamic> toJson() => $DraftsAuthorToJson(this);

  DraftsAuthor copyWith({int? id, String? address, String? name, String? desc, String? avatarUrl, String? websiteUrl, String? discordUrl, String? twitterUrl}) {
      return DraftsAuthor()..id= id ?? this.id
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