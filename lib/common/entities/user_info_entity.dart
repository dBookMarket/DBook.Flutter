import 'package:dbook/generated/json/base/json_field.dart';
import 'package:dbook/generated/json/user_info_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class UserInfoEntity {

	int? id;
	String? address;
	String? name;
	String? desc;
	@JSONField(name: "website_url")
	String? websiteUrl;
	@JSONField(name: "discord_url")
	String? discordUrl;
	@JSONField(name: "twitter_url")
	String? twitterUrl;
	@JSONField(name: "is_verified")
	bool? isVerified;
	@JSONField(name: "avatar_url")
	String? avatarUrl;
	@JSONField(name: "banner_url")
	String? bannerUrl;
	UserInfoStatistic? statistic;
  
  UserInfoEntity();

  factory UserInfoEntity.fromJson(Map<String, dynamic> json) => $UserInfoEntityFromJson(json);

  Map<String, dynamic> toJson() => $UserInfoEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class UserInfoStatistic {


  
  UserInfoStatistic();

  factory UserInfoStatistic.fromJson(Map<String, dynamic> json) => $UserInfoStatisticFromJson(json);

  Map<String, dynamic> toJson() => $UserInfoStatisticToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}