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
	final TradesListIssue? issue = jsonConvert.convert<TradesListIssue>(json['issue']);
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
	data['issue'] = entity.issue?.toJson();
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

TradesListIssue $TradesListIssueFromJson(Map<String, dynamic> json) {
	final TradesListIssue tradesListIssue = TradesListIssue();
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		tradesListIssue.id = id;
	}
	final TradesListIssueBook? book = jsonConvert.convert<TradesListIssueBook>(json['book']);
	if (book != null) {
		tradesListIssue.book = book;
	}
	final double? price = jsonConvert.convert<double>(json['price']);
	if (price != null) {
		tradesListIssue.price = price;
	}
	final int? quantity = jsonConvert.convert<int>(json['quantity']);
	if (quantity != null) {
		tradesListIssue.quantity = quantity;
	}
	final int? nCirculations = jsonConvert.convert<int>(json['n_circulations']);
	if (nCirculations != null) {
		tradesListIssue.nCirculations = nCirculations;
	}
	final String? publishedAt = jsonConvert.convert<String>(json['published_at']);
	if (publishedAt != null) {
		tradesListIssue.publishedAt = publishedAt;
	}
	final String? status = jsonConvert.convert<String>(json['status']);
	if (status != null) {
		tradesListIssue.status = status;
	}
	return tradesListIssue;
}

Map<String, dynamic> $TradesListIssueToJson(TradesListIssue entity) {
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

TradesListIssueBook $TradesListIssueBookFromJson(Map<String, dynamic> json) {
	final TradesListIssueBook tradesListIssueBook = TradesListIssueBook();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		tradesListIssueBook.id = id;
	}
	final String? createdAt = jsonConvert.convert<String>(json['created_at']);
	if (createdAt != null) {
		tradesListIssueBook.createdAt = createdAt;
	}
	final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
	if (updatedAt != null) {
		tradesListIssueBook.updatedAt = updatedAt;
	}
	final TradesListIssueBookAuthor? author = jsonConvert.convert<TradesListIssueBookAuthor>(json['author']);
	if (author != null) {
		tradesListIssueBook.author = author;
	}
	final String? title = jsonConvert.convert<String>(json['title']);
	if (title != null) {
		tradesListIssueBook.title = title;
	}
	final String? desc = jsonConvert.convert<String>(json['desc']);
	if (desc != null) {
		tradesListIssueBook.desc = desc;
	}
	final String? coverUrl = jsonConvert.convert<String>(json['cover_url']);
	if (coverUrl != null) {
		tradesListIssueBook.coverUrl = coverUrl;
	}
	final String? status = jsonConvert.convert<String>(json['status']);
	if (status != null) {
		tradesListIssueBook.status = status;
	}
	final TradesListIssueBookPreview? preview = jsonConvert.convert<TradesListIssueBookPreview>(json['preview']);
	if (preview != null) {
		tradesListIssueBook.preview = preview;
	}
	final int? nPages = jsonConvert.convert<int>(json['n_pages']);
	if (nPages != null) {
		tradesListIssueBook.nPages = nPages;
	}
	final String? cid = jsonConvert.convert<String>(json['cid']);
	if (cid != null) {
		tradesListIssueBook.cid = cid;
	}
	final bool? hasIssued = jsonConvert.convert<bool>(json['has_issued']);
	if (hasIssued != null) {
		tradesListIssueBook.hasIssued = hasIssued;
	}
	return tradesListIssueBook;
}

Map<String, dynamic> $TradesListIssueBookToJson(TradesListIssueBook entity) {
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

TradesListIssueBookAuthor $TradesListIssueBookAuthorFromJson(Map<String, dynamic> json) {
	final TradesListIssueBookAuthor tradesListIssueBookAuthor = TradesListIssueBookAuthor();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		tradesListIssueBookAuthor.id = id;
	}
	final String? address = jsonConvert.convert<String>(json['address']);
	if (address != null) {
		tradesListIssueBookAuthor.address = address;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		tradesListIssueBookAuthor.name = name;
	}
	final String? desc = jsonConvert.convert<String>(json['desc']);
	if (desc != null) {
		tradesListIssueBookAuthor.desc = desc;
	}
	final String? avatarUrl = jsonConvert.convert<String>(json['avatar_url']);
	if (avatarUrl != null) {
		tradesListIssueBookAuthor.avatarUrl = avatarUrl;
	}
	final String? websiteUrl = jsonConvert.convert<String>(json['website_url']);
	if (websiteUrl != null) {
		tradesListIssueBookAuthor.websiteUrl = websiteUrl;
	}
	final String? discordUrl = jsonConvert.convert<String>(json['discord_url']);
	if (discordUrl != null) {
		tradesListIssueBookAuthor.discordUrl = discordUrl;
	}
	final String? twitterUrl = jsonConvert.convert<String>(json['twitter_url']);
	if (twitterUrl != null) {
		tradesListIssueBookAuthor.twitterUrl = twitterUrl;
	}
	return tradesListIssueBookAuthor;
}

Map<String, dynamic> $TradesListIssueBookAuthorToJson(TradesListIssueBookAuthor entity) {
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

TradesListIssueBookPreview $TradesListIssueBookPreviewFromJson(Map<String, dynamic> json) {
	final TradesListIssueBookPreview tradesListIssueBookPreview = TradesListIssueBookPreview();
	final String? fileUrl = jsonConvert.convert<String>(json['file_url']);
	if (fileUrl != null) {
		tradesListIssueBookPreview.fileUrl = fileUrl;
	}
	return tradesListIssueBookPreview;
}

Map<String, dynamic> $TradesListIssueBookPreviewToJson(TradesListIssueBookPreview entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['file_url'] = entity.fileUrl;
	return data;
}