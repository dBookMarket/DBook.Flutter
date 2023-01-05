import 'package:dbook/generated/json/base/json_convert_content.dart';
import 'package:dbook/common/entities/book_entity.dart';

BookEntity $BookEntityFromJson(Map<String, dynamic> json) {
	final BookEntity bookEntity = BookEntity();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		bookEntity.id = id;
	}
	final String? createdAt = jsonConvert.convert<String>(json['created_at']);
	if (createdAt != null) {
		bookEntity.createdAt = createdAt;
	}
	final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
	if (updatedAt != null) {
		bookEntity.updatedAt = updatedAt;
	}
	final BookAuthor? author = jsonConvert.convert<BookAuthor>(json['author']);
	if (author != null) {
		bookEntity.author = author;
	}
	final String? title = jsonConvert.convert<String>(json['title']);
	if (title != null) {
		bookEntity.title = title;
	}
	final String? desc = jsonConvert.convert<String>(json['desc']);
	if (desc != null) {
		bookEntity.desc = desc;
	}
	final String? coverUrl = jsonConvert.convert<String>(json['cover_url']);
	if (coverUrl != null) {
		bookEntity.coverUrl = coverUrl;
	}
	final String? status = jsonConvert.convert<String>(json['status']);
	if (status != null) {
		bookEntity.status = status;
	}
	final BookPreview? preview = jsonConvert.convert<BookPreview>(json['preview']);
	if (preview != null) {
		bookEntity.preview = preview;
	}
	final int? nPages = jsonConvert.convert<int>(json['n_pages']);
	if (nPages != null) {
		bookEntity.nPages = nPages;
	}
	final String? cid = jsonConvert.convert<String>(json['cid']);
	if (cid != null) {
		bookEntity.cid = cid;
	}
	final bool? hasIssued = jsonConvert.convert<bool>(json['has_issued']);
	if (hasIssued != null) {
		bookEntity.hasIssued = hasIssued;
	}
	return bookEntity;
}

Map<String, dynamic> $BookEntityToJson(BookEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['created_at'] = entity.createdAt;
	data['updated_at'] = entity.updatedAt;
	data['author'] = entity.author?.toJson();
	data['title'] = entity.title;
	data['desc'] = entity.desc;
	data['cover_url'] = entity.coverUrl;
	data['status'] = entity.status;
	data['preview'] = entity.preview?.toJson();
	data['n_pages'] = entity.nPages;
	data['cid'] = entity.cid;
	data['has_issued'] = entity.hasIssued;
	return data;
}

BookAuthor $BookAuthorFromJson(Map<String, dynamic> json) {
	final BookAuthor bookAuthor = BookAuthor();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		bookAuthor.id = id;
	}
	final String? address = jsonConvert.convert<String>(json['address']);
	if (address != null) {
		bookAuthor.address = address;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		bookAuthor.name = name;
	}
	final String? desc = jsonConvert.convert<String>(json['desc']);
	if (desc != null) {
		bookAuthor.desc = desc;
	}
	final String? avatarUrl = jsonConvert.convert<String>(json['avatar_url']);
	if (avatarUrl != null) {
		bookAuthor.avatarUrl = avatarUrl;
	}
	final String? websiteUrl = jsonConvert.convert<String>(json['website_url']);
	if (websiteUrl != null) {
		bookAuthor.websiteUrl = websiteUrl;
	}
	final String? discordUrl = jsonConvert.convert<String>(json['discord_url']);
	if (discordUrl != null) {
		bookAuthor.discordUrl = discordUrl;
	}
	final String? twitterUrl = jsonConvert.convert<String>(json['twitter_url']);
	if (twitterUrl != null) {
		bookAuthor.twitterUrl = twitterUrl;
	}
	return bookAuthor;
}

Map<String, dynamic> $BookAuthorToJson(BookAuthor entity) {
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

BookPreview $BookPreviewFromJson(Map<String, dynamic> json) {
	final BookPreview bookPreview = BookPreview();
	final String? fileUrl = jsonConvert.convert<String>(json['file_url']);
	if (fileUrl != null) {
		bookPreview.fileUrl = fileUrl;
	}
	return bookPreview;
}

Map<String, dynamic> $BookPreviewToJson(BookPreview entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['file_url'] = entity.fileUrl;
	return data;
}