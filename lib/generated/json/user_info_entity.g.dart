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
	final bool? isFans = jsonConvert.convert<bool>(json['is_fans']);
	if (isFans != null) {
		userInfoEntity.isFans = isFans;
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
	data['is_fans'] = entity.isFans;
	data['avatar_url'] = entity.avatarUrl;
	data['banner_url'] = entity.bannerUrl;
	data['statistic'] = entity.statistic?.toJson();
	return data;
}

UserInfoStatistic $UserInfoStatisticFromJson(Map<String, dynamic> json) {
	final UserInfoStatistic userInfoStatistic = UserInfoStatistic();
	final String? totalVolume = jsonConvert.convert<String>(json['total_volume']);
	if (totalVolume != null) {
		userInfoStatistic.totalVolume = totalVolume;
	}
	final String? minPrice = jsonConvert.convert<String>(json['min_price']);
	if (minPrice != null) {
		userInfoStatistic.minPrice = minPrice;
	}
	final String? maxPrice = jsonConvert.convert<String>(json['max_price']);
	if (maxPrice != null) {
		userInfoStatistic.maxPrice = maxPrice;
	}
	final String? totalBooks = jsonConvert.convert<String>(json['total_books']);
	if (totalBooks != null) {
		userInfoStatistic.totalBooks = totalBooks;
	}
	final String? sales = jsonConvert.convert<String>(json['sales']);
	if (sales != null) {
		userInfoStatistic.sales = sales;
	}
	final String? nOwners = jsonConvert.convert<String>(json['n_owners']);
	if (nOwners != null) {
		userInfoStatistic.nOwners = nOwners;
	}
	final String? nDestroyed = jsonConvert.convert<String>(json['n_destroyed']);
	if (nDestroyed != null) {
		userInfoStatistic.nDestroyed = nDestroyed;
	}
	return userInfoStatistic;
}

Map<String, dynamic> $UserInfoStatisticToJson(UserInfoStatistic entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['total_volume'] = entity.totalVolume;
	data['min_price'] = entity.minPrice;
	data['max_price'] = entity.maxPrice;
	data['total_books'] = entity.totalBooks;
	data['sales'] = entity.sales;
	data['n_owners'] = entity.nOwners;
	data['n_destroyed'] = entity.nDestroyed;
	return data;
}