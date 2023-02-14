import 'package:dbook/generated/json/base/json_convert_content.dart';
import 'package:dbook/common/entities/concern_opus_entity.dart';

ConcernOpusEntity $ConcernOpusEntityFromJson(Map<String, dynamic> json) {
	final ConcernOpusEntity concernOpusEntity = ConcernOpusEntity();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		concernOpusEntity.id = id;
	}
	final String? createdAt = jsonConvert.convert<String>(json['created_at']);
	if (createdAt != null) {
		concernOpusEntity.createdAt = createdAt;
	}
	final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
	if (updatedAt != null) {
		concernOpusEntity.updatedAt = updatedAt;
	}
	final int? user = jsonConvert.convert<int>(json['user']);
	if (user != null) {
		concernOpusEntity.user = user;
	}
	final ConcernOpusIssue? issue = jsonConvert.convert<ConcernOpusIssue>(json['issue']);
	if (issue != null) {
		concernOpusEntity.issue = issue;
	}
	return concernOpusEntity;
}

Map<String, dynamic> $ConcernOpusEntityToJson(ConcernOpusEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['created_at'] = entity.createdAt;
	data['updated_at'] = entity.updatedAt;
	data['user'] = entity.user;
	data['issue'] = entity.issue?.toJson();
	return data;
}

ConcernOpusIssue $ConcernOpusIssueFromJson(Map<String, dynamic> json) {
	final ConcernOpusIssue concernOpusIssue = ConcernOpusIssue();
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		concernOpusIssue.id = id;
	}
	final ConcernOpusIssueBook? book = jsonConvert.convert<ConcernOpusIssueBook>(json['book']);
	if (book != null) {
		concernOpusIssue.book = book;
	}
	final double? price = jsonConvert.convert<double>(json['price']);
	if (price != null) {
		concernOpusIssue.price = price;
	}
	final int? quantity = jsonConvert.convert<int>(json['quantity']);
	if (quantity != null) {
		concernOpusIssue.quantity = quantity;
	}
	final int? nCirculations = jsonConvert.convert<int>(json['n_circulations']);
	if (nCirculations != null) {
		concernOpusIssue.nCirculations = nCirculations;
	}
	final String? publishedAt = jsonConvert.convert<String>(json['published_at']);
	if (publishedAt != null) {
		concernOpusIssue.publishedAt = publishedAt;
	}
	return concernOpusIssue;
}

Map<String, dynamic> $ConcernOpusIssueToJson(ConcernOpusIssue entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['book'] = entity.book?.toJson();
	data['price'] = entity.price;
	data['quantity'] = entity.quantity;
	data['n_circulations'] = entity.nCirculations;
	data['published_at'] = entity.publishedAt;
	return data;
}

ConcernOpusIssueBook $ConcernOpusIssueBookFromJson(Map<String, dynamic> json) {
	final ConcernOpusIssueBook concernOpusIssueBook = ConcernOpusIssueBook();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		concernOpusIssueBook.id = id;
	}
	final String? createdAt = jsonConvert.convert<String>(json['created_at']);
	if (createdAt != null) {
		concernOpusIssueBook.createdAt = createdAt;
	}
	final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
	if (updatedAt != null) {
		concernOpusIssueBook.updatedAt = updatedAt;
	}
	final ConcernOpusIssueBookAuthor? author = jsonConvert.convert<ConcernOpusIssueBookAuthor>(json['author']);
	if (author != null) {
		concernOpusIssueBook.author = author;
	}
	final String? title = jsonConvert.convert<String>(json['title']);
	if (title != null) {
		concernOpusIssueBook.title = title;
	}
	final String? desc = jsonConvert.convert<String>(json['desc']);
	if (desc != null) {
		concernOpusIssueBook.desc = desc;
	}
	final String? coverUrl = jsonConvert.convert<String>(json['cover_url']);
	if (coverUrl != null) {
		concernOpusIssueBook.coverUrl = coverUrl;
	}
	final String? status = jsonConvert.convert<String>(json['status']);
	if (status != null) {
		concernOpusIssueBook.status = status;
	}
	final int? nPages = jsonConvert.convert<int>(json['n_pages']);
	if (nPages != null) {
		concernOpusIssueBook.nPages = nPages;
	}
	final String? cid = jsonConvert.convert<String>(json['cid']);
	if (cid != null) {
		concernOpusIssueBook.cid = cid;
	}
	final bool? hasIssued = jsonConvert.convert<bool>(json['has_issued']);
	if (hasIssued != null) {
		concernOpusIssueBook.hasIssued = hasIssued;
	}
	return concernOpusIssueBook;
}

Map<String, dynamic> $ConcernOpusIssueBookToJson(ConcernOpusIssueBook entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['created_at'] = entity.createdAt;
	data['updated_at'] = entity.updatedAt;
	data['author'] = entity.author?.toJson();
	data['title'] = entity.title;
	data['desc'] = entity.desc;
	data['cover_url'] = entity.coverUrl;
	data['status'] = entity.status;
	data['n_pages'] = entity.nPages;
	data['cid'] = entity.cid;
	data['has_issued'] = entity.hasIssued;
	return data;
}

ConcernOpusIssueBookAuthor $ConcernOpusIssueBookAuthorFromJson(Map<String, dynamic> json) {
	final ConcernOpusIssueBookAuthor concernOpusIssueBookAuthor = ConcernOpusIssueBookAuthor();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		concernOpusIssueBookAuthor.id = id;
	}
	final String? address = jsonConvert.convert<String>(json['address']);
	if (address != null) {
		concernOpusIssueBookAuthor.address = address;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		concernOpusIssueBookAuthor.name = name;
	}
	final String? desc = jsonConvert.convert<String>(json['desc']);
	if (desc != null) {
		concernOpusIssueBookAuthor.desc = desc;
	}
	final String? avatarUrl = jsonConvert.convert<String>(json['avatar_url']);
	if (avatarUrl != null) {
		concernOpusIssueBookAuthor.avatarUrl = avatarUrl;
	}
	final String? websiteUrl = jsonConvert.convert<String>(json['website_url']);
	if (websiteUrl != null) {
		concernOpusIssueBookAuthor.websiteUrl = websiteUrl;
	}
	final String? discordUrl = jsonConvert.convert<String>(json['discord_url']);
	if (discordUrl != null) {
		concernOpusIssueBookAuthor.discordUrl = discordUrl;
	}
	final String? twitterUrl = jsonConvert.convert<String>(json['twitter_url']);
	if (twitterUrl != null) {
		concernOpusIssueBookAuthor.twitterUrl = twitterUrl;
	}
	return concernOpusIssueBookAuthor;
}

Map<String, dynamic> $ConcernOpusIssueBookAuthorToJson(ConcernOpusIssueBookAuthor entity) {
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