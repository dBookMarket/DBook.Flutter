import 'package:dbook/generated/json/base/json_convert_content.dart';
import 'package:dbook/common/entities/assets_info_entity.dart';

AssetsInfoEntity $AssetsInfoEntityFromJson(Map<String, dynamic> json) {
	final AssetsInfoEntity assetsInfoEntity = AssetsInfoEntity();
	final int? count = jsonConvert.convert<int>(json['count']);
	if (count != null) {
		assetsInfoEntity.count = count;
	}
	final int? pageSize = jsonConvert.convert<int>(json['page_size']);
	if (pageSize != null) {
		assetsInfoEntity.pageSize = pageSize;
	}
	final int? pageCount = jsonConvert.convert<int>(json['page_count']);
	if (pageCount != null) {
		assetsInfoEntity.pageCount = pageCount;
	}
	final int? pageNumber = jsonConvert.convert<int>(json['page_number']);
	if (pageNumber != null) {
		assetsInfoEntity.pageNumber = pageNumber;
	}
	final dynamic? next = jsonConvert.convert<dynamic>(json['next']);
	if (next != null) {
		assetsInfoEntity.next = next;
	}
	final dynamic? previous = jsonConvert.convert<dynamic>(json['previous']);
	if (previous != null) {
		assetsInfoEntity.previous = previous;
	}
	final List<AssetsInfoResults>? results = jsonConvert.convertListNotNull<AssetsInfoResults>(json['results']);
	if (results != null) {
		assetsInfoEntity.results = results;
	}
	return assetsInfoEntity;
}

Map<String, dynamic> $AssetsInfoEntityToJson(AssetsInfoEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['count'] = entity.count;
	data['page_size'] = entity.pageSize;
	data['page_count'] = entity.pageCount;
	data['page_number'] = entity.pageNumber;
	data['next'] = entity.next;
	data['previous'] = entity.previous;
	data['results'] =  entity.results?.map((v) => v.toJson()).toList();
	return data;
}

AssetsInfoResults $AssetsInfoResultsFromJson(Map<String, dynamic> json) {
	final AssetsInfoResults assetsInfoResults = AssetsInfoResults();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		assetsInfoResults.id = id;
	}
	final String? createdAt = jsonConvert.convert<String>(json['created_at']);
	if (createdAt != null) {
		assetsInfoResults.createdAt = createdAt;
	}
	final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
	if (updatedAt != null) {
		assetsInfoResults.updatedAt = updatedAt;
	}
	final String? user = jsonConvert.convert<String>(json['user']);
	if (user != null) {
		assetsInfoResults.user = user;
	}
	final AssetsInfoResultsIssue? issue = jsonConvert.convert<AssetsInfoResultsIssue>(json['issue']);
	if (issue != null) {
		assetsInfoResults.issue = issue;
	}
	final int? amount = jsonConvert.convert<int>(json['amount']);
	if (amount != null) {
		assetsInfoResults.amount = amount;
	}
	final AssetsInfoResultsBookmark? bookmark = jsonConvert.convert<AssetsInfoResultsBookmark>(json['bookmark']);
	if (bookmark != null) {
		assetsInfoResults.bookmark = bookmark;
	}
	return assetsInfoResults;
}

Map<String, dynamic> $AssetsInfoResultsToJson(AssetsInfoResults entity) {
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

AssetsInfoResultsIssue $AssetsInfoResultsIssueFromJson(Map<String, dynamic> json) {
	final AssetsInfoResultsIssue assetsInfoResultsIssue = AssetsInfoResultsIssue();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		assetsInfoResultsIssue.id = id;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		assetsInfoResultsIssue.name = name;
	}
	final String? authorName = jsonConvert.convert<String>(json['author_name']);
	if (authorName != null) {
		assetsInfoResultsIssue.authorName = authorName;
	}
	final String? coverUrl = jsonConvert.convert<String>(json['cover_url']);
	if (coverUrl != null) {
		assetsInfoResultsIssue.coverUrl = coverUrl;
	}
	final int? nPages = jsonConvert.convert<int>(json['n_pages']);
	if (nPages != null) {
		assetsInfoResultsIssue.nPages = nPages;
	}
	final String? status = jsonConvert.convert<String>(json['status']);
	if (status != null) {
		assetsInfoResultsIssue.status = status;
	}
	return assetsInfoResultsIssue;
}

Map<String, dynamic> $AssetsInfoResultsIssueToJson(AssetsInfoResultsIssue entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['author_name'] = entity.authorName;
	data['cover_url'] = entity.coverUrl;
	data['n_pages'] = entity.nPages;
	data['status'] = entity.status;
	return data;
}

AssetsInfoResultsBookmark $AssetsInfoResultsBookmarkFromJson(Map<String, dynamic> json) {
	final AssetsInfoResultsBookmark assetsInfoResultsBookmark = AssetsInfoResultsBookmark();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		assetsInfoResultsBookmark.id = id;
	}
	final int? issue = jsonConvert.convert<int>(json['issue']);
	if (issue != null) {
		assetsInfoResultsBookmark.issue = issue;
	}
	final int? currentPage = jsonConvert.convert<int>(json['current_page']);
	if (currentPage != null) {
		assetsInfoResultsBookmark.currentPage = currentPage;
	}
	return assetsInfoResultsBookmark;
}

Map<String, dynamic> $AssetsInfoResultsBookmarkToJson(AssetsInfoResultsBookmark entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['issue'] = entity.issue;
	data['current_page'] = entity.currentPage;
	return data;
}