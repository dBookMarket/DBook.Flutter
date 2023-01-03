import 'package:dbook/generated/json/base/json_convert_content.dart';
import 'package:dbook/common/entities/user_info_entity.dart';

UserInfoEntity $UserInfoEntityFromJson(Map<String, dynamic> json) {
	final UserInfoEntity userInfoEntity = UserInfoEntity();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		userInfoEntity.id = id;
	}
	final String? address = jsonConvert.convert<String>(json['address']);
	if (address != null) {
		userInfoEntity.address = address;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		userInfoEntity.name = name;
	}
	final String? desc = jsonConvert.convert<String>(json['desc']);
	if (desc != null) {
		userInfoEntity.desc = desc;
	}
	final String? websiteUrl = jsonConvert.convert<String>(json['website_url']);
	if (websiteUrl != null) {
		userInfoEntity.websiteUrl = websiteUrl;
	}
	final String? discordUrl = jsonConvert.convert<String>(json['discord_url']);
	if (discordUrl != null) {
		userInfoEntity.discordUrl = discordUrl;
	}
	final String? twitterUrl = jsonConvert.convert<String>(json['twitter_url']);
	if (twitterUrl != null) {
		userInfoEntity.twitterUrl = twitterUrl;
	}
	final bool? isVerified = jsonConvert.convert<bool>(json['is_verified']);
	if (isVerified != null) {
		userInfoEntity.isVerified = isVerified;
	}
	final String? avatarUrl = jsonConvert.convert<String>(json['avatar_url']);
	if (avatarUrl != null) {
		userInfoEntity.avatarUrl = avatarUrl;
	}
	final String? bannerUrl = jsonConvert.convert<String>(json['banner_url']);
	if (bannerUrl != null) {
		userInfoEntity.bannerUrl = bannerUrl;
	}
	final UserInfoStatistic? statistic = jsonConvert.convert<UserInfoStatistic>(json['statistic']);
	if (statistic != null) {
		userInfoEntity.statistic = statistic;
	}
	return userInfoEntity;
}

Map<String, dynamic> $UserInfoEntityToJson(UserInfoEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['address'] = entity.address;
	data['name'] = entity.name;
	data['desc'] = entity.desc;
	data['website_url'] = entity.websiteUrl;
	data['discord_url'] = entity.discordUrl;
	data['twitter_url'] = entity.twitterUrl;
	data['is_verified'] = entity.isVerified;
	data['avatar_url'] = entity.avatarUrl;
	data['banner_url'] = entity.bannerUrl;
	data['statistic'] = entity.statistic?.toJson();
	return data;
}

UserInfoStatistic $UserInfoStatisticFromJson(Map<String, dynamic> json) {
	final UserInfoStatistic userInfoStatistic = UserInfoStatistic();
	return userInfoStatistic;
}

Map<String, dynamic> $UserInfoStatisticToJson(UserInfoStatistic entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	return data;
}