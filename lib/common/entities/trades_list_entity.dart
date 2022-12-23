import 'package:dbook/generated/json/base/json_field.dart';
import 'package:dbook/generated/json/trades_list_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class TradesListEntity {

	int? id;
	@JSONField(name: "created_at")
	String? createdAt;
	@JSONField(name: "updated_at")
	String? updatedAt;
	TradesListUser? user;
	String? issue;
	int? quantity;
	double? price;
	@JSONField(name: "is_owned")
	bool? isOwned;
  
  TradesListEntity();

  factory TradesListEntity.fromJson(Map<String, dynamic> json) => $TradesListEntityFromJson(json);

  Map<String, dynamic> toJson() => $TradesListEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class TradesListUser {

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
  
  TradesListUser();

  factory TradesListUser.fromJson(Map<String, dynamic> json) => $TradesListUserFromJson(json);

  Map<String, dynamic> toJson() => $TradesListUserToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}