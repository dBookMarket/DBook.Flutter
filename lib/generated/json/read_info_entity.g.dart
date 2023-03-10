import 'package:dbook/generated/json/base/json_convert_content.dart';
import 'package:dbook/common/entities/read_info_entity.dart';

ReadInfoEntity $ReadInfoEntityFromJson(Map<String, dynamic> json) {
	final ReadInfoEntity readInfoEntity = ReadInfoEntity();
	final String? fileUrl = jsonConvert.convert<String>(json['file_url']);
	if (fileUrl != null) {
		readInfoEntity.fileUrl = fileUrl;
	}
	final ReadInfoBookmark? bookmark = jsonConvert.convert<ReadInfoBookmark>(json['bookmark']);
	if (bookmark != null) {
		readInfoEntity.bookmark = bookmark;
	}
	return readInfoEntity;
}

Map<String, dynamic> $ReadInfoEntityToJson(ReadInfoEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['file_url'] = entity.fileUrl;
	data['bookmark'] = entity.bookmark?.toJson();
	return data;
}

ReadInfoBookmark $ReadInfoBookmarkFromJson(Map<String, dynamic> json) {
	final ReadInfoBookmark readInfoBookmark = ReadInfoBookmark();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		readInfoBookmark.id = id;
	}
	final String? createdAt = jsonConvert.convert<String>(json['created_at']);
	if (createdAt != null) {
		readInfoBookmark.createdAt = createdAt;
	}
	final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
	if (updatedAt != null) {
		readInfoBookmark.updatedAt = updatedAt;
	}
	final String? issue = jsonConvert.convert<String>(json['issue']);
	if (issue != null) {
		readInfoBookmark.issue = issue;
	}
	final int? currentPage = jsonConvert.convert<int>(json['current_page']);
	if (currentPage != null) {
		readInfoBookmark.currentPage = currentPage;
	}
	return readInfoBookmark;
}

Map<String, dynamic> $ReadInfoBookmarkToJson(ReadInfoBookmark entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['created_at'] = entity.createdAt;
	data['updated_at'] = entity.updatedAt;
	data['issue'] = entity.issue;
	data['current_page'] = entity.currentPage;
	return data;
}