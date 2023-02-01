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
  @JSONField(name: "is_fans")
  bool? isFans;
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


  @JSONField(name: "total_volume")
  String? totalVolume;

  @JSONField(name: "min_price")
  String? minPrice;

  @JSONField(name: "max_price")
  String? maxPrice;

  @JSONField(name: "total_books")
  String? totalBooks;

  @JSONField(name: "sales")
  String? sales;
  @JSONField(name: "n_owners")
  String? nOwners;
  @JSONField(name: "n_destroyed")
  String? nDestroyed;

  UserInfoStatistic();

  factory UserInfoStatistic.fromJson(Map<String, dynamic> json) => $UserInfoStatisticFromJson(json);

  Map<String, dynamic> toJson() => $UserInfoStatisticToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
