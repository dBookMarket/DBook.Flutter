import 'package:dbook/generated/json/base/json_convert_content.dart';
import 'package:dbook/common/entities/assets_entity.dart';

AssetsEntity $AssetsEntityFromJson(Map<String, dynamic> json) {
	final AssetsEntity assetsEntity = AssetsEntity();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		assetsEntity.id = id;
	}
	final String? createdAt = jsonConvert.convert<String>(json['created_at']);
	if (createdAt != null) {
		assetsEntity.createdAt = createdAt;
	}
	final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
	if (updatedAt != null) {
		assetsEntity.updatedAt = updatedAt;
	}
	final String? user = jsonConvert.convert<String>(json['user']);
	if (user != null) {
		assetsEntity.user = user;
	}
	final AssetsIssue? issue = jsonConvert.convert<AssetsIssue>(json['issue']);
	if (issue != null) {
		assetsEntity.issue = issue;
	}
	final int? amount = jsonConvert.convert<int>(json['amount']);
	if (amount != null) {
		assetsEntity.amount = amount;
	}
	final AssetsBookmark? bookmark = jsonConvert.convert<AssetsBookmark>(json['bookmark']);
	if (bookmark != null) {
		assetsEntity.bookmark = bookmark;
	}
	return assetsEntity;
}

Map<String, dynamic> $AssetsEntityToJson(AssetsEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['created_at'] = entity.createdAt;
	data['updated_at'] = entity.updatedAt;
	data['user'] = entity.user;
	data['issue'] = entity.issue?.toJson();
	data['amount'] = entity.amount;
	data['bookmark'] = entity.bookmark?.toJson();
	return data;
}

AssetsIssue $AssetsIssueFromJson(Map<String, dynamic> json) {
	final AssetsIssue assetsIssue = AssetsIssue();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		assetsIssue.id = id;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		assetsIssue.name = name;
	}
	final String? authorName = jsonConvert.convert<String>(json['author_name']);
	if (authorName != null) {
		assetsIssue.authorName = authorName;
	}
	final String? cover = jsonConvert.convert<String>(json['cover']);
	if (cover != null) {
		assetsIssue.cover = cover;
	}
	final int? nPages = jsonConvert.convert<int>(json['n_pages']);
	if (nPages != null) {
		assetsIssue.nPages = nPages;
	}
	return assetsIssue;
}

Map<String, dynamic> $AssetsIssueToJson(AssetsIssue entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['author_name'] = entity.authorName;
	data['cover'] = entity.cover;
	data['n_pages'] = entity.nPages;
	return data;
}

AssetsBookmark $AssetsBookmarkFromJson(Map<String, dynamic> json) {
	final AssetsBookmark assetsBookmark = AssetsBookmark();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		assetsBookmark.id = id;
	}
	final int? issue = jsonConvert.convert<int>(json['issue']);
	if (issue != null) {
		assetsBookmark.issue = issue;
	}
	final int? currentPage = jsonConvert.convert<int>(json['current_page']);
	if (currentPage != null) {
		assetsBookmark.currentPage = currentPage;
	}
	return assetsBookmark;
}

Map<String, dynamic> $AssetsBookmarkToJson(AssetsBookmark entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['issue'] = entity.issue;
	data['current_page'] = entity.currentPage;
	return data;
}