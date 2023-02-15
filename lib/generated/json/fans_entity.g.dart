import 'package:dbook/generated/json/base/json_convert_content.dart';
import 'package:dbook/common/entities/fans_entity.dart';

FansEntity $FansEntityFromJson(Map<String, dynamic> json) {
	final FansEntity fansEntity = FansEntity();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		fansEntity.id = id;
	}
	final int? user = jsonConvert.convert<int>(json['user']);
	if (user != null) {
		fansEntity.user = user;
	}
	final FansAuthor? author = jsonConvert.convert<FansAuthor>(json['author']);
	if (author != null) {
		fansEntity.author = author;
	}
	return fansEntity;
}

Map<String, dynamic> $FansEntityToJson(FansEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['user'] = entity.user;
	data['author'] = entity.author?.toJson();
	return data;
}

FansAuthor $FansAuthorFromJson(Map<String, dynamic> json) {
	final FansAuthor fansAuthor = FansAuthor();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		fansAuthor.id = id;
	}
	final String? address = jsonConvert.convert<String>(json['address']);
	if (address != null) {
		fansAuthor.address = address;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		fansAuthor.name = name;
	}
	final String? desc = jsonConvert.convert<String>(json['desc']);
	if (desc != null) {
		fansAuthor.desc = desc;
	}
	final String? avatarUrl = jsonConvert.convert<String>(json['avatar_url']);
	if (avatarUrl != null) {
		fansAuthor.avatarUrl = avatarUrl;
	}
	final String? websiteUrl = jsonConvert.convert<String>(json['website_url']);
	if (websiteUrl != null) {
		fansAuthor.websiteUrl = websiteUrl;
	}
	final String? discordUrl = jsonConvert.convert<String>(json['discord_url']);
	if (discordUrl != null) {
		fansAuthor.discordUrl = discordUrl;
	}
	final String? twitterUrl = jsonConvert.convert<String>(json['twitter_url']);
	if (twitterUrl != null) {
		fansAuthor.twitterUrl = twitterUrl;
	}
	return fansAuthor;
}

Map<String, dynamic> $FansAuthorToJson(FansAuthor entity) {
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