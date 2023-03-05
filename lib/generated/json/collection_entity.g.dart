import 'package:dbook/generated/json/base/json_convert_content.dart';
import 'package:dbook/common/entities/collection_entity.dart';

CollectionEntity $CollectionEntityFromJson(Map<String, dynamic> json) {
	final CollectionEntity collectionEntity = CollectionEntity();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		collectionEntity.id = id;
	}
	final CollectionIssue? issue = jsonConvert.convert<CollectionIssue>(json['issue']);
	if (issue != null) {
		collectionEntity.issue = issue;
	}
	final int? quantity = jsonConvert.convert<int>(json['quantity']);
	if (quantity != null) {
		collectionEntity.quantity = quantity;
	}
	final String? price = jsonConvert.convert<String>(json['price']);
	if (price != null) {
		collectionEntity.price = price;
	}
	return collectionEntity;
}

Map<String, dynamic> $CollectionEntityToJson(CollectionEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['issue'] = entity.issue?.toJson();
	data['quantity'] = entity.quantity;
	data['price'] = entity.price;
	return data;
}

CollectionIssue $CollectionIssueFromJson(Map<String, dynamic> json) {
	final CollectionIssue collectionIssue = CollectionIssue();
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		collectionIssue.id = id;
	}
	final CollectionIssueBook? book = jsonConvert.convert<CollectionIssueBook>(json['book']);
	if (book != null) {
		collectionIssue.book = book;
	}
	final double? price = jsonConvert.convert<double>(json['price']);
	if (price != null) {
		collectionIssue.price = price;
	}
	final double? duration = jsonConvert.convert<double>(json['duration']);
	if (duration != null) {
		collectionIssue.duration = duration;
	}
	final int? quantity = jsonConvert.convert<int>(json['quantity']);
	if (quantity != null) {
		collectionIssue.quantity = quantity;
	}
	final int? nCirculations = jsonConvert.convert<int>(json['n_circulations']);
	if (nCirculations != null) {
		collectionIssue.nCirculations = nCirculations;
	}
	final String? publishedAt = jsonConvert.convert<String>(json['published_at']);
	if (publishedAt != null) {
		collectionIssue.publishedAt = publishedAt;
	}
	final String? status = jsonConvert.convert<String>(json['status']);
	if (status != null) {
		collectionIssue.status = status;
	}
	return collectionIssue;
}

Map<String, dynamic> $CollectionIssueToJson(CollectionIssue entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['book'] = entity.book?.toJson();
	data['price'] = entity.price;
	data['duration'] = entity.duration;
	data['quantity'] = entity.quantity;
	data['n_circulations'] = entity.nCirculations;
	data['published_at'] = entity.publishedAt;
	data['status'] = entity.status;
	return data;
}

CollectionIssueBook $CollectionIssueBookFromJson(Map<String, dynamic> json) {
	final CollectionIssueBook collectionIssueBook = CollectionIssueBook();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		collectionIssueBook.id = id;
	}
	final String? createdAt = jsonConvert.convert<String>(json['created_at']);
	if (createdAt != null) {
		collectionIssueBook.createdAt = createdAt;
	}
	final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
	if (updatedAt != null) {
		collectionIssueBook.updatedAt = updatedAt;
	}
	final CollectionIssueBookAuthor? author = jsonConvert.convert<CollectionIssueBookAuthor>(json['author']);
	if (author != null) {
		collectionIssueBook.author = author;
	}
	final String? title = jsonConvert.convert<String>(json['title']);
	if (title != null) {
		collectionIssueBook.title = title;
	}
	final String? desc = jsonConvert.convert<String>(json['desc']);
	if (desc != null) {
		collectionIssueBook.desc = desc;
	}
	final String? coverUrl = jsonConvert.convert<String>(json['cover_url']);
	if (coverUrl != null) {
		collectionIssueBook.coverUrl = coverUrl;
	}
	final String? status = jsonConvert.convert<String>(json['status']);
	if (status != null) {
		collectionIssueBook.status = status;
	}
	final int? nPages = jsonConvert.convert<int>(json['n_pages']);
	if (nPages != null) {
		collectionIssueBook.nPages = nPages;
	}
	final String? cid = jsonConvert.convert<String>(json['cid']);
	if (cid != null) {
		collectionIssueBook.cid = cid;
	}
	final bool? hasIssued = jsonConvert.convert<bool>(json['has_issued']);
	if (hasIssued != null) {
		collectionIssueBook.hasIssued = hasIssued;
	}
	return collectionIssueBook;
}

Map<String, dynamic> $CollectionIssueBookToJson(CollectionIssueBook entity) {
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

CollectionIssueBookAuthor $CollectionIssueBookAuthorFromJson(Map<String, dynamic> json) {
	final CollectionIssueBookAuthor collectionIssueBookAuthor = CollectionIssueBookAuthor();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		collectionIssueBookAuthor.id = id;
	}
	final String? address = jsonConvert.convert<String>(json['address']);
	if (address != null) {
		collectionIssueBookAuthor.address = address;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		collectionIssueBookAuthor.name = name;
	}
	final String? desc = jsonConvert.convert<String>(json['desc']);
	if (desc != null) {
		collectionIssueBookAuthor.desc = desc;
	}
	final String? avatarUrl = jsonConvert.convert<String>(json['avatar_url']);
	if (avatarUrl != null) {
		collectionIssueBookAuthor.avatarUrl = avatarUrl;
	}
	final String? websiteUrl = jsonConvert.convert<String>(json['website_url']);
	if (websiteUrl != null) {
		collectionIssueBookAuthor.websiteUrl = websiteUrl;
	}
	final String? discordUrl = jsonConvert.convert<String>(json['discord_url']);
	if (discordUrl != null) {
		collectionIssueBookAuthor.discordUrl = discordUrl;
	}
	final String? twitterUrl = jsonConvert.convert<String>(json['twitter_url']);
	if (twitterUrl != null) {
		collectionIssueBookAuthor.twitterUrl = twitterUrl;
	}
	return collectionIssueBookAuthor;
}

Map<String, dynamic> $CollectionIssueBookAuthorToJson(CollectionIssueBookAuthor entity) {
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