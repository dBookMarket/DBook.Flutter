import 'package:dbook/generated/json/base/json_field.dart';
import 'package:dbook/generated/json/fans_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class FansEntity {

	int? id;
	int? user;
	FansAuthor? author;
  
  FansEntity();

  factory FansEntity.fromJson(Map<String, dynamic> json) => $FansEntityFromJson(json);

  Map<String, dynamic> toJson() => $FansEntityToJson(this);

  FansEntity copyWith({int? id, int? user, FansAuthor? author}) {
      return FansEntity()..id= id ?? this.id
			..user= user ?? this.user
			..author= author ?? this.author;
  }
    
  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class FansAuthor {

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
  
  FansAuthor();

  factory FansAuthor.fromJson(Map<String, dynamic> json) => $FansAuthorFromJson(json);

  Map<String, dynamic> toJson() => $FansAuthorToJson(this);

  FansAuthor copyWith({int? id, String? address, String? name, String? desc, String? avatarUrl, String? websiteUrl, String? discordUrl, String? twitterUrl}) {
      return FansAuthor()..id= id ?? this.id
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