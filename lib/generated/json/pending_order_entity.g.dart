import 'package:dbook/generated/json/base/json_convert_content.dart';
import 'package:dbook/common/entities/pending_order_entity.dart';

PendingOrderEntity $PendingOrderEntityFromJson(Map<String, dynamic> json) {
	final PendingOrderEntity pendingOrderEntity = PendingOrderEntity();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		pendingOrderEntity.id = id;
	}
	final String? createdAt = jsonConvert.convert<String>(json['created_at']);
	if (createdAt != null) {
		pendingOrderEntity.createdAt = createdAt;
	}
	final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
	if (updatedAt != null) {
		pendingOrderEntity.updatedAt = updatedAt;
	}
	final PendingOrderUser? user = jsonConvert.convert<PendingOrderUser>(json['user']);
	if (user != null) {
		pendingOrderEntity.user = user;
	}
	final PendingOrderIssue? issue = jsonConvert.convert<PendingOrderIssue>(json['issue']);
	if (issue != null) {
		pendingOrderEntity.issue = issue;
	}
	final int? quantity = jsonConvert.convert<int>(json['quantity']);
	if (quantity != null) {
		pendingOrderEntity.quantity = quantity;
	}
	final double? price = jsonConvert.convert<double>(json['price']);
	if (price != null) {
		pendingOrderEntity.price = price;
	}
	final bool? isOwned = jsonConvert.convert<bool>(json['is_owned']);
	if (isOwned != null) {
		pendingOrderEntity.isOwned = isOwned;
	}
	return pendingOrderEntity;
}

Map<String, dynamic> $PendingOrderEntityToJson(PendingOrderEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['created_at'] = entity.createdAt;
	data['updated_at'] = entity.updatedAt;
	data['user'] = entity.user?.toJson();
	data['issue'] = entity.issue?.toJson();
	data['quantity'] = entity.quantity;
	data['price'] = entity.price;
	data['is_owned'] = entity.isOwned;
	return data;
}

PendingOrderUser $PendingOrderUserFromJson(Map<String, dynamic> json) {
	final PendingOrderUser pendingOrderUser = PendingOrderUser();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		pendingOrderUser.id = id;
	}
	final String? address = jsonConvert.convert<String>(json['address']);
	if (address != null) {
		pendingOrderUser.address = address;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		pendingOrderUser.name = name;
	}
	final String? desc = jsonConvert.convert<String>(json['desc']);
	if (desc != null) {
		pendingOrderUser.desc = desc;
	}
	final String? avatarUrl = jsonConvert.convert<String>(json['avatar_url']);
	if (avatarUrl != null) {
		pendingOrderUser.avatarUrl = avatarUrl;
	}
	final String? websiteUrl = jsonConvert.convert<String>(json['website_url']);
	if (websiteUrl != null) {
		pendingOrderUser.websiteUrl = websiteUrl;
	}
	final String? discordUrl = jsonConvert.convert<String>(json['discord_url']);
	if (discordUrl != null) {
		pendingOrderUser.discordUrl = discordUrl;
	}
	final String? twitterUrl = jsonConvert.convert<String>(json['twitter_url']);
	if (twitterUrl != null) {
		pendingOrderUser.twitterUrl = twitterUrl;
	}
	return pendingOrderUser;
}

Map<String, dynamic> $PendingOrderUserToJson(PendingOrderUser entity) {
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

PendingOrderIssue $PendingOrderIssueFromJson(Map<String, dynamic> json) {
	final PendingOrderIssue pendingOrderIssue = PendingOrderIssue();
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		pendingOrderIssue.id = id;
	}
	final PendingOrderIssueBook? book = jsonConvert.convert<PendingOrderIssueBook>(json['book']);
	if (book != null) {
		pendingOrderIssue.book = book;
	}
	final double? price = jsonConvert.convert<double>(json['price']);
	if (price != null) {
		pendingOrderIssue.price = price;
	}
	final int? quantity = jsonConvert.convert<int>(json['quantity']);
	if (quantity != null) {
		pendingOrderIssue.quantity = quantity;
	}
	final int? nCirculations = jsonConvert.convert<int>(json['n_circulations']);
	if (nCirculations != null) {
		pendingOrderIssue.nCirculations = nCirculations;
	}
	final String? publishedAt = jsonConvert.convert<String>(json['published_at']);
	if (publishedAt != null) {
		pendingOrderIssue.publishedAt = publishedAt;
	}
	final String? status = jsonConvert.convert<String>(json['status']);
	if (status != null) {
		pendingOrderIssue.status = status;
	}
	return pendingOrderIssue;
}

Map<String, dynamic> $PendingOrderIssueToJson(PendingOrderIssue entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['book'] = entity.book?.toJson();
	data['price'] = entity.price;
	data['quantity'] = entity.quantity;
	data['n_circulations'] = entity.nCirculations;
	data['published_at'] = entity.publishedAt;
	data['status'] = entity.status;
	return data;
}

PendingOrderIssueBook $PendingOrderIssueBookFromJson(Map<String, dynamic> json) {
	final PendingOrderIssueBook pendingOrderIssueBook = PendingOrderIssueBook();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		pendingOrderIssueBook.id = id;
	}
	final String? createdAt = jsonConvert.convert<String>(json['created_at']);
	if (createdAt != null) {
		pendingOrderIssueBook.createdAt = createdAt;
	}
	final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
	if (updatedAt != null) {
		pendingOrderIssueBook.updatedAt = updatedAt;
	}
	final PendingOrderIssueBookAuthor? author = jsonConvert.convert<PendingOrderIssueBookAuthor>(json['author']);
	if (author != null) {
		pendingOrderIssueBook.author = author;
	}
	final String? title = jsonConvert.convert<String>(json['title']);
	if (title != null) {
		pendingOrderIssueBook.title = title;
	}
	final String? desc = jsonConvert.convert<String>(json['desc']);
	if (desc != null) {
		pendingOrderIssueBook.desc = desc;
	}
	final String? coverUrl = jsonConvert.convert<String>(json['cover_url']);
	if (coverUrl != null) {
		pendingOrderIssueBook.coverUrl = coverUrl;
	}
	final String? status = jsonConvert.convert<String>(json['status']);
	if (status != null) {
		pendingOrderIssueBook.status = status;
	}
	final PendingOrderIssueBookPreview? preview = jsonConvert.convert<PendingOrderIssueBookPreview>(json['preview']);
	if (preview != null) {
		pendingOrderIssueBook.preview = preview;
	}
	final int? nPages = jsonConvert.convert<int>(json['n_pages']);
	if (nPages != null) {
		pendingOrderIssueBook.nPages = nPages;
	}
	final String? cid = jsonConvert.convert<String>(json['cid']);
	if (cid != null) {
		pendingOrderIssueBook.cid = cid;
	}
	final bool? hasIssued = jsonConvert.convert<bool>(json['has_issued']);
	if (hasIssued != null) {
		pendingOrderIssueBook.hasIssued = hasIssued;
	}
	return pendingOrderIssueBook;
}

Map<String, dynamic> $PendingOrderIssueBookToJson(PendingOrderIssueBook entity) {
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

PendingOrderIssueBookAuthor $PendingOrderIssueBookAuthorFromJson(Map<String, dynamic> json) {
	final PendingOrderIssueBookAuthor pendingOrderIssueBookAuthor = PendingOrderIssueBookAuthor();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		pendingOrderIssueBookAuthor.id = id;
	}
	final String? address = jsonConvert.convert<String>(json['address']);
	if (address != null) {
		pendingOrderIssueBookAuthor.address = address;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		pendingOrderIssueBookAuthor.name = name;
	}
	final String? desc = jsonConvert.convert<String>(json['desc']);
	if (desc != null) {
		pendingOrderIssueBookAuthor.desc = desc;
	}
	final String? avatarUrl = jsonConvert.convert<String>(json['avatar_url']);
	if (avatarUrl != null) {
		pendingOrderIssueBookAuthor.avatarUrl = avatarUrl;
	}
	final String? websiteUrl = jsonConvert.convert<String>(json['website_url']);
	if (websiteUrl != null) {
		pendingOrderIssueBookAuthor.websiteUrl = websiteUrl;
	}
	final String? discordUrl = jsonConvert.convert<String>(json['discord_url']);
	if (discordUrl != null) {
		pendingOrderIssueBookAuthor.discordUrl = discordUrl;
	}
	final String? twitterUrl = jsonConvert.convert<String>(json['twitter_url']);
	if (twitterUrl != null) {
		pendingOrderIssueBookAuthor.twitterUrl = twitterUrl;
	}
	return pendingOrderIssueBookAuthor;
}

Map<String, dynamic> $PendingOrderIssueBookAuthorToJson(PendingOrderIssueBookAuthor entity) {
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

PendingOrderIssueBookPreview $PendingOrderIssueBookPreviewFromJson(Map<String, dynamic> json) {
	final PendingOrderIssueBookPreview pendingOrderIssueBookPreview = PendingOrderIssueBookPreview();
	final String? fileUrl = jsonConvert.convert<String>(json['file_url']);
	if (fileUrl != null) {
		pendingOrderIssueBookPreview.fileUrl = fileUrl;
	}
	return pendingOrderIssueBookPreview;
}

Map<String, dynamic> $PendingOrderIssueBookPreviewToJson(PendingOrderIssueBookPreview entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['file_url'] = entity.fileUrl;
	return data;
}