import 'package:dbook/generated/json/base/json_convert_content.dart';
import 'package:dbook/common/entities/drafts_entity.dart';

DraftsEntity $DraftsEntityFromJson(Map<String, dynamic> json) {
	final DraftsEntity draftsEntity = DraftsEntity();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		draftsEntity.id = id;
	}
	final String? createdAt = jsonConvert.convert<String>(json['created_at']);
	if (createdAt != null) {
		draftsEntity.createdAt = createdAt;
	}
	final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
	if (updatedAt != null) {
		draftsEntity.updatedAt = updatedAt;
	}
	final DraftsAuthor? author = jsonConvert.convert<DraftsAuthor>(json['author']);
	if (author != null) {
		draftsEntity.author = author;
	}
	final String? title = jsonConvert.convert<String>(json['title']);
	if (title != null) {
		draftsEntity.title = title;
	}
	final String? content = jsonConvert.convert<String>(json['content']);
	if (content != null) {
		draftsEntity.content = content;
	}
	return draftsEntity;
}

Map<String, dynamic> $DraftsEntityToJson(DraftsEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['created_at'] = entity.createdAt;
	data['updated_at'] = entity.updatedAt;
	data['author'] = entity.author?.toJson();
	data['title'] = entity.title;
	data['content'] = entity.content;
	return data;
}

DraftsAuthor $DraftsAuthorFromJson(Map<String, dynamic> json) {
	final DraftsAuthor draftsAuthor = DraftsAuthor();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		draftsAuthor.id = id;
	}
	final String? address = jsonConvert.convert<String>(json['address']);
	if (address != null) {
		draftsAuthor.address = address;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		draftsAuthor.name = name;
	}
	final String? desc = jsonConvert.convert<String>(json['desc']);
	if (desc != null) {
		draftsAuthor.desc = desc;
	}
	final String? avatarUrl = jsonConvert.convert<String>(json['avatar_url']);
	if (avatarUrl != null) {
		draftsAuthor.avatarUrl = avatarUrl;
	}
	final String? websiteUrl = jsonConvert.convert<String>(json['website_url']);
	if (websiteUrl != null) {
		draftsAuthor.websiteUrl = websiteUrl;
	}
	final String? discordUrl = jsonConvert.convert<String>(json['discord_url']);
	if (discordUrl != null) {
		draftsAuthor.discordUrl = discordUrl;
	}
	final String? twitterUrl = jsonConvert.convert<String>(json['twitter_url']);
	if (twitterUrl != null) {
		draftsAuthor.twitterUrl = twitterUrl;
	}
	return draftsAuthor;
}

Map<String, dynamic> $DraftsAuthorToJson(DraftsAuthor entity) {
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