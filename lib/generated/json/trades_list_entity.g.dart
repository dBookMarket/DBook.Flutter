import 'package:dbook/generated/json/base/json_convert_content.dart';
import 'package:dbook/common/entities/trades_list_entity.dart';

TradesListEntity $TradesListEntityFromJson(Map<String, dynamic> json) {
	final TradesListEntity tradesListEntity = TradesListEntity();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		tradesListEntity.id = id;
	}
	final String? createdAt = jsonConvert.convert<String>(json['created_at']);
	if (createdAt != null) {
		tradesListEntity.createdAt = createdAt;
	}
	final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
	if (updatedAt != null) {
		tradesListEntity.updatedAt = updatedAt;
	}
	final TradesListUser? user = jsonConvert.convert<TradesListUser>(json['user']);
	if (user != null) {
		tradesListEntity.user = user;
	}
	final String? issue = jsonConvert.convert<String>(json['issue']);
	if (issue != null) {
		tradesListEntity.issue = issue;
	}
	final int? quantity = jsonConvert.convert<int>(json['quantity']);
	if (quantity != null) {
		tradesListEntity.quantity = quantity;
	}
	final double? price = jsonConvert.convert<double>(json['price']);
	if (price != null) {
		tradesListEntity.price = price;
	}
	final bool? isOwned = jsonConvert.convert<bool>(json['is_owned']);
	if (isOwned != null) {
		tradesListEntity.isOwned = isOwned;
	}
	return tradesListEntity;
}

Map<String, dynamic> $TradesListEntityToJson(TradesListEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['created_at'] = entity.createdAt;
	data['updated_at'] = entity.updatedAt;
	data['user'] = entity.user?.toJson();
	data['issue'] = entity.issue;
	data['quantity'] = entity.quantity;
	data['price'] = entity.price;
	data['is_owned'] = entity.isOwned;
	return data;
}

TradesListUser $TradesListUserFromJson(Map<String, dynamic> json) {
	final TradesListUser tradesListUser = TradesListUser();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		tradesListUser.id = id;
	}
	final String? address = jsonConvert.convert<String>(json['address']);
	if (address != null) {
		tradesListUser.address = address;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		tradesListUser.name = name;
	}
	final String? desc = jsonConvert.convert<String>(json['desc']);
	if (desc != null) {
		tradesListUser.desc = desc;
	}
	final String? avatarUrl = jsonConvert.convert<String>(json['avatar_url']);
	if (avatarUrl != null) {
		tradesListUser.avatarUrl = avatarUrl;
	}
	final String? websiteUrl = jsonConvert.convert<String>(json['website_url']);
	if (websiteUrl != null) {
		tradesListUser.websiteUrl = websiteUrl;
	}
	final String? discordUrl = jsonConvert.convert<String>(json['discord_url']);
	if (discordUrl != null) {
		tradesListUser.discordUrl = discordUrl;
	}
	final String? twitterUrl = jsonConvert.convert<String>(json['twitter_url']);
	if (twitterUrl != null) {
		tradesListUser.twitterUrl = twitterUrl;
	}
	return tradesListUser;
}

Map<String, dynamic> $TradesListUserToJson(TradesListUser entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['address'] = entity.address;
	data['name'] = entity.name;
	data['desc'] = entity.desc;
	data['avatar_url'] = entity.avatarUrl;
	data['website_url'] = entity.websiteUrl;
	data['discord_url'] = entity.discordUrl;
	data['twitter_url'] = entity.twitterUrl;
	return data;
}