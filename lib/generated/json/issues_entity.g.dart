import 'package:dbook/generated/json/base/json_convert_content.dart';
import 'package:dbook/common/entities/issues_entity.dart';

IssuesEntity $IssuesEntityFromJson(Map<String, dynamic> json) {
	final IssuesEntity issuesEntity = IssuesEntity();
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		issuesEntity.id = id;
	}
	final String? createdAt = jsonConvert.convert<String>(json['created_at']);
	if (createdAt != null) {
		issuesEntity.createdAt = createdAt;
	}
	final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
	if (updatedAt != null) {
		issuesEntity.updatedAt = updatedAt;
	}
	final IssuesBook? book = jsonConvert.convert<IssuesBook>(json['book']);
	if (book != null) {
		issuesEntity.book = book;
	}
	final int? quantity = jsonConvert.convert<int>(json['quantity']);
	if (quantity != null) {
		issuesEntity.quantity = quantity;
	}
	final double? price = jsonConvert.convert<double>(json['price']);
	if (price != null) {
		issuesEntity.price = price;
	}
	final double? royalty = jsonConvert.convert<double>(json['royalty']);
	if (royalty != null) {
		issuesEntity.royalty = royalty;
	}
	final int? buyLimit = jsonConvert.convert<int>(json['buy_limit']);
	if (buyLimit != null) {
		issuesEntity.buyLimit = buyLimit;
	}
	final String? publishedAt = jsonConvert.convert<String>(json['published_at']);
	if (publishedAt != null) {
		issuesEntity.publishedAt = publishedAt;
	}
	final int? duration = jsonConvert.convert<int>(json['duration']);
	if (duration != null) {
		issuesEntity.duration = duration;
	}
	final String? status = jsonConvert.convert<String>(json['status']);
	if (status != null) {
		issuesEntity.status = status;
	}
	final int? nCirculations = jsonConvert.convert<int>(json['n_circulations']);
	if (nCirculations != null) {
		issuesEntity.nCirculations = nCirculations;
	}
	final IssuesPriceRange? priceRange = jsonConvert.convert<IssuesPriceRange>(json['price_range']);
	if (priceRange != null) {
		issuesEntity.priceRange = priceRange;
	}
	final IssuesTrade? trade = jsonConvert.convert<IssuesTrade>(json['trade']);
	if (trade != null) {
		issuesEntity.trade = trade;
	}
	final bool? isWished = jsonConvert.convert<bool>(json['is_wished']);
	if (isWished != null) {
		issuesEntity.isWished = isWished;
	}
	final int? nOwners = jsonConvert.convert<int>(json['n_owners']);
	if (nOwners != null) {
		issuesEntity.nOwners = nOwners;
	}
	final IssuesBookmark? bookmark = jsonConvert.convert<IssuesBookmark>(json['bookmark']);
	if (bookmark != null) {
		issuesEntity.bookmark = bookmark;
	}
	final int? nOwned = jsonConvert.convert<int>(json['n_owned']);
	if (nOwned != null) {
		issuesEntity.nOwned = nOwned;
	}
	final IssuesToken? token = jsonConvert.convert<IssuesToken>(json['token']);
	if (token != null) {
		issuesEntity.token = token;
	}
	final String? destroyLog = jsonConvert.convert<String>(json['destroy_log']);
	if (destroyLog != null) {
		issuesEntity.destroyLog = destroyLog;
	}
	return issuesEntity;
}

Map<String, dynamic> $IssuesEntityToJson(IssuesEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['created_at'] = entity.createdAt;
	data['updated_at'] = entity.updatedAt;
	data['book'] = entity.book?.toJson();
	data['quantity'] = entity.quantity;
	data['price'] = entity.price;
	data['royalty'] = entity.royalty;
	data['buy_limit'] = entity.buyLimit;
	data['published_at'] = entity.publishedAt;
	data['duration'] = entity.duration;
	data['status'] = entity.status;
	data['n_circulations'] = entity.nCirculations;
	data['price_range'] = entity.priceRange?.toJson();
	data['trade'] = entity.trade?.toJson();
	data['is_wished'] = entity.isWished;
	data['n_owners'] = entity.nOwners;
	data['bookmark'] = entity.bookmark?.toJson();
	data['n_owned'] = entity.nOwned;
	data['token'] = entity.token?.toJson();
	data['destroy_log'] = entity.destroyLog;
	return data;
}

IssuesBook $IssuesBookFromJson(Map<String, dynamic> json) {
	final IssuesBook issuesBook = IssuesBook();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		issuesBook.id = id;
	}
	final String? createdAt = jsonConvert.convert<String>(json['created_at']);
	if (createdAt != null) {
		issuesBook.createdAt = createdAt;
	}
	final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
	if (updatedAt != null) {
		issuesBook.updatedAt = updatedAt;
	}
	final IssuesBookAuthor? author = jsonConvert.convert<IssuesBookAuthor>(json['author']);
	if (author != null) {
		issuesBook.author = author;
	}
	final String? title = jsonConvert.convert<String>(json['title']);
	if (title != null) {
		issuesBook.title = title;
	}
	final String? desc = jsonConvert.convert<String>(json['desc']);
	if (desc != null) {
		issuesBook.desc = desc;
	}
	final String? coverUrl = jsonConvert.convert<String>(json['cover_url']);
	if (coverUrl != null) {
		issuesBook.coverUrl = coverUrl;
	}
	final String? status = jsonConvert.convert<String>(json['status']);
	if (status != null) {
		issuesBook.status = status;
	}
	final IssuesBookPreview? preview = jsonConvert.convert<IssuesBookPreview>(json['preview']);
	if (preview != null) {
		issuesBook.preview = preview;
	}
	final int? nPages = jsonConvert.convert<int>(json['n_pages']);
	if (nPages != null) {
		issuesBook.nPages = nPages;
	}
	final String? cid = jsonConvert.convert<String>(json['cid']);
	if (cid != null) {
		issuesBook.cid = cid;
	}
	final bool? hasIssued = jsonConvert.convert<bool>(json['has_issued']);
	if (hasIssued != null) {
		issuesBook.hasIssued = hasIssued;
	}
	return issuesBook;
}

Map<String, dynamic> $IssuesBookToJson(IssuesBook entity) {
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

IssuesBookAuthor $IssuesBookAuthorFromJson(Map<String, dynamic> json) {
	final IssuesBookAuthor issuesBookAuthor = IssuesBookAuthor();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		issuesBookAuthor.id = id;
	}
	final String? address = jsonConvert.convert<String>(json['address']);
	if (address != null) {
		issuesBookAuthor.address = address;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		issuesBookAuthor.name = name;
	}
	final String? desc = jsonConvert.convert<String>(json['desc']);
	if (desc != null) {
		issuesBookAuthor.desc = desc;
	}
	final String? avatarUrl = jsonConvert.convert<String>(json['avatar_url']);
	if (avatarUrl != null) {
		issuesBookAuthor.avatarUrl = avatarUrl;
	}
	final String? websiteUrl = jsonConvert.convert<String>(json['website_url']);
	if (websiteUrl != null) {
		issuesBookAuthor.websiteUrl = websiteUrl;
	}
	final String? discordUrl = jsonConvert.convert<String>(json['discord_url']);
	if (discordUrl != null) {
		issuesBookAuthor.discordUrl = discordUrl;
	}
	final String? twitterUrl = jsonConvert.convert<String>(json['twitter_url']);
	if (twitterUrl != null) {
		issuesBookAuthor.twitterUrl = twitterUrl;
	}
	return issuesBookAuthor;
}

Map<String, dynamic> $IssuesBookAuthorToJson(IssuesBookAuthor entity) {
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

IssuesBookPreview $IssuesBookPreviewFromJson(Map<String, dynamic> json) {
	final IssuesBookPreview issuesBookPreview = IssuesBookPreview();
	final String? url = jsonConvert.convert<String>(json['file_url']);
	if (url != null) {
		issuesBookPreview.url = url;
	}
	return issuesBookPreview;
}

Map<String, dynamic> $IssuesBookPreviewToJson(IssuesBookPreview entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['file_url'] = entity.url;
	return data;
}

IssuesPriceRange $IssuesPriceRangeFromJson(Map<String, dynamic> json) {
	final IssuesPriceRange issuesPriceRange = IssuesPriceRange();
	final double? minPrice = jsonConvert.convert<double>(json['min_price']);
	if (minPrice != null) {
		issuesPriceRange.minPrice = minPrice;
	}
	final double? maxPrice = jsonConvert.convert<double>(json['max_price']);
	if (maxPrice != null) {
		issuesPriceRange.maxPrice = maxPrice;
	}
	return issuesPriceRange;
}

Map<String, dynamic> $IssuesPriceRangeToJson(IssuesPriceRange entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['min_price'] = entity.minPrice;
	data['max_price'] = entity.maxPrice;
	return data;
}

IssuesTrade $IssuesTradeFromJson(Map<String, dynamic> json) {
	final IssuesTrade issuesTrade = IssuesTrade();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		issuesTrade.id = id;
	}
	final int? quantity = jsonConvert.convert<int>(json['quantity']);
	if (quantity != null) {
		issuesTrade.quantity = quantity;
	}
	final double? price = jsonConvert.convert<double>(json['price']);
	if (price != null) {
		issuesTrade.price = price;
	}
	return issuesTrade;
}

Map<String, dynamic> $IssuesTradeToJson(IssuesTrade entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['quantity'] = entity.quantity;
	data['price'] = entity.price;
	return data;
}

IssuesBookmark $IssuesBookmarkFromJson(Map<String, dynamic> json) {
	final IssuesBookmark issuesBookmark = IssuesBookmark();
	return issuesBookmark;
}

Map<String, dynamic> $IssuesBookmarkToJson(IssuesBookmark entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	return data;
}

IssuesToken $IssuesTokenFromJson(Map<String, dynamic> json) {
	final IssuesToken issuesToken = IssuesToken();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		issuesToken.id = id;
	}
	final String? issue = jsonConvert.convert<String>(json['issue']);
	if (issue != null) {
		issuesToken.issue = issue;
	}
	final String? contractAddress = jsonConvert.convert<String>(json['contract_address']);
	if (contractAddress != null) {
		issuesToken.contractAddress = contractAddress;
	}
	final String? blockChain = jsonConvert.convert<String>(json['block_chain']);
	if (blockChain != null) {
		issuesToken.blockChain = blockChain;
	}
	final String? standard = jsonConvert.convert<String>(json['standard']);
	if (standard != null) {
		issuesToken.standard = standard;
	}
	final String? currency = jsonConvert.convert<String>(json['currency']);
	if (currency != null) {
		issuesToken.currency = currency;
	}
	return issuesToken;
}

Map<String, dynamic> $IssuesTokenToJson(IssuesToken entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['issue'] = entity.issue;
	data['contract_address'] = entity.contractAddress;
	data['block_chain'] = entity.blockChain;
	data['standard'] = entity.standard;
	data['currency'] = entity.currency;
	return data;
}