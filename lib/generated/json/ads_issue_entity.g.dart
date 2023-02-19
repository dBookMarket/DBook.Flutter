import 'package:dbook/generated/json/base/json_convert_content.dart';
import 'package:dbook/common/entities/ads_issue_entity.dart';

AdsIssueEntity $AdsIssueEntityFromJson(Map<String, dynamic> json) {
	final AdsIssueEntity adsIssueEntity = AdsIssueEntity();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		adsIssueEntity.id = id;
	}
	final AdsIssueIssue? issue = jsonConvert.convert<AdsIssueIssue>(json['issue']);
	if (issue != null) {
		adsIssueEntity.issue = issue;
	}
	return adsIssueEntity;
}

Map<String, dynamic> $AdsIssueEntityToJson(AdsIssueEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['issue'] = entity.issue?.toJson();
	return data;
}

AdsIssueIssue $AdsIssueIssueFromJson(Map<String, dynamic> json) {
	final AdsIssueIssue adsIssueIssue = AdsIssueIssue();
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		adsIssueIssue.id = id;
	}
	final String? createdAt = jsonConvert.convert<String>(json['created_at']);
	if (createdAt != null) {
		adsIssueIssue.createdAt = createdAt;
	}
	final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
	if (updatedAt != null) {
		adsIssueIssue.updatedAt = updatedAt;
	}
	final AdsIssueIssueBook? book = jsonConvert.convert<AdsIssueIssueBook>(json['book']);
	if (book != null) {
		adsIssueIssue.book = book;
	}
	final int? quantity = jsonConvert.convert<int>(json['quantity']);
	if (quantity != null) {
		adsIssueIssue.quantity = quantity;
	}
	final double? price = jsonConvert.convert<double>(json['price']);
	if (price != null) {
		adsIssueIssue.price = price;
	}
	final double? royalty = jsonConvert.convert<double>(json['royalty']);
	if (royalty != null) {
		adsIssueIssue.royalty = royalty;
	}
	final int? buyLimit = jsonConvert.convert<int>(json['buy_limit']);
	if (buyLimit != null) {
		adsIssueIssue.buyLimit = buyLimit;
	}
	final String? publishedAt = jsonConvert.convert<String>(json['published_at']);
	if (publishedAt != null) {
		adsIssueIssue.publishedAt = publishedAt;
	}
	final int? duration = jsonConvert.convert<int>(json['duration']);
	if (duration != null) {
		adsIssueIssue.duration = duration;
	}
	final String? status = jsonConvert.convert<String>(json['status']);
	if (status != null) {
		adsIssueIssue.status = status;
	}
	final int? nCirculations = jsonConvert.convert<int>(json['n_circulations']);
	if (nCirculations != null) {
		adsIssueIssue.nCirculations = nCirculations;
	}
	final AdsIssueIssuePriceRange? priceRange = jsonConvert.convert<AdsIssueIssuePriceRange>(json['price_range']);
	if (priceRange != null) {
		adsIssueIssue.priceRange = priceRange;
	}
	final AdsIssueIssueTrade? trade = jsonConvert.convert<AdsIssueIssueTrade>(json['trade']);
	if (trade != null) {
		adsIssueIssue.trade = trade;
	}
	final bool? isWished = jsonConvert.convert<bool>(json['is_wished']);
	if (isWished != null) {
		adsIssueIssue.isWished = isWished;
	}
	final int? nOwners = jsonConvert.convert<int>(json['n_owners']);
	if (nOwners != null) {
		adsIssueIssue.nOwners = nOwners;
	}
	final AdsIssueIssueBookmark? bookmark = jsonConvert.convert<AdsIssueIssueBookmark>(json['bookmark']);
	if (bookmark != null) {
		adsIssueIssue.bookmark = bookmark;
	}
	final int? nOwned = jsonConvert.convert<int>(json['n_owned']);
	if (nOwned != null) {
		adsIssueIssue.nOwned = nOwned;
	}
	final dynamic? token = jsonConvert.convert<dynamic>(json['token']);
	if (token != null) {
		adsIssueIssue.token = token;
	}
	final String? destroyLog = jsonConvert.convert<String>(json['destroy_log']);
	if (destroyLog != null) {
		adsIssueIssue.destroyLog = destroyLog;
	}
	return adsIssueIssue;
}

Map<String, dynamic> $AdsIssueIssueToJson(AdsIssueIssue entity) {
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
	data['token'] = entity.token;
	data['destroy_log'] = entity.destroyLog;
	return data;
}

AdsIssueIssueBook $AdsIssueIssueBookFromJson(Map<String, dynamic> json) {
	final AdsIssueIssueBook adsIssueIssueBook = AdsIssueIssueBook();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		adsIssueIssueBook.id = id;
	}
	final String? createdAt = jsonConvert.convert<String>(json['created_at']);
	if (createdAt != null) {
		adsIssueIssueBook.createdAt = createdAt;
	}
	final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
	if (updatedAt != null) {
		adsIssueIssueBook.updatedAt = updatedAt;
	}
	final AdsIssueIssueBookAuthor? author = jsonConvert.convert<AdsIssueIssueBookAuthor>(json['author']);
	if (author != null) {
		adsIssueIssueBook.author = author;
	}
	final String? title = jsonConvert.convert<String>(json['title']);
	if (title != null) {
		adsIssueIssueBook.title = title;
	}
	final String? desc = jsonConvert.convert<String>(json['desc']);
	if (desc != null) {
		adsIssueIssueBook.desc = desc;
	}
	final String? coverUrl = jsonConvert.convert<String>(json['cover_url']);
	if (coverUrl != null) {
		adsIssueIssueBook.coverUrl = coverUrl;
	}
	final String? status = jsonConvert.convert<String>(json['status']);
	if (status != null) {
		adsIssueIssueBook.status = status;
	}
	final AdsIssueIssueBookPreview? preview = jsonConvert.convert<AdsIssueIssueBookPreview>(json['preview']);
	if (preview != null) {
		adsIssueIssueBook.preview = preview;
	}
	final int? nPages = jsonConvert.convert<int>(json['n_pages']);
	if (nPages != null) {
		adsIssueIssueBook.nPages = nPages;
	}
	final String? cid = jsonConvert.convert<String>(json['cid']);
	if (cid != null) {
		adsIssueIssueBook.cid = cid;
	}
	final bool? hasIssued = jsonConvert.convert<bool>(json['has_issued']);
	if (hasIssued != null) {
		adsIssueIssueBook.hasIssued = hasIssued;
	}
	return adsIssueIssueBook;
}

Map<String, dynamic> $AdsIssueIssueBookToJson(AdsIssueIssueBook entity) {
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

AdsIssueIssueBookAuthor $AdsIssueIssueBookAuthorFromJson(Map<String, dynamic> json) {
	final AdsIssueIssueBookAuthor adsIssueIssueBookAuthor = AdsIssueIssueBookAuthor();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		adsIssueIssueBookAuthor.id = id;
	}
	final String? address = jsonConvert.convert<String>(json['address']);
	if (address != null) {
		adsIssueIssueBookAuthor.address = address;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		adsIssueIssueBookAuthor.name = name;
	}
	final String? desc = jsonConvert.convert<String>(json['desc']);
	if (desc != null) {
		adsIssueIssueBookAuthor.desc = desc;
	}
	final String? avatarUrl = jsonConvert.convert<String>(json['avatar_url']);
	if (avatarUrl != null) {
		adsIssueIssueBookAuthor.avatarUrl = avatarUrl;
	}
	final String? websiteUrl = jsonConvert.convert<String>(json['website_url']);
	if (websiteUrl != null) {
		adsIssueIssueBookAuthor.websiteUrl = websiteUrl;
	}
	final String? discordUrl = jsonConvert.convert<String>(json['discord_url']);
	if (discordUrl != null) {
		adsIssueIssueBookAuthor.discordUrl = discordUrl;
	}
	final String? twitterUrl = jsonConvert.convert<String>(json['twitter_url']);
	if (twitterUrl != null) {
		adsIssueIssueBookAuthor.twitterUrl = twitterUrl;
	}
	return adsIssueIssueBookAuthor;
}

Map<String, dynamic> $AdsIssueIssueBookAuthorToJson(AdsIssueIssueBookAuthor entity) {
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

AdsIssueIssueBookPreview $AdsIssueIssueBookPreviewFromJson(Map<String, dynamic> json) {
	final AdsIssueIssueBookPreview adsIssueIssueBookPreview = AdsIssueIssueBookPreview();
	return adsIssueIssueBookPreview;
}

Map<String, dynamic> $AdsIssueIssueBookPreviewToJson(AdsIssueIssueBookPreview entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	return data;
}

AdsIssueIssuePriceRange $AdsIssueIssuePriceRangeFromJson(Map<String, dynamic> json) {
	final AdsIssueIssuePriceRange adsIssueIssuePriceRange = AdsIssueIssuePriceRange();
	final double? minPrice = jsonConvert.convert<double>(json['min_price']);
	if (minPrice != null) {
		adsIssueIssuePriceRange.minPrice = minPrice;
	}
	final double? maxPrice = jsonConvert.convert<double>(json['max_price']);
	if (maxPrice != null) {
		adsIssueIssuePriceRange.maxPrice = maxPrice;
	}
	return adsIssueIssuePriceRange;
}

Map<String, dynamic> $AdsIssueIssuePriceRangeToJson(AdsIssueIssuePriceRange entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['min_price'] = entity.minPrice;
	data['max_price'] = entity.maxPrice;
	return data;
}

AdsIssueIssueTrade $AdsIssueIssueTradeFromJson(Map<String, dynamic> json) {
	final AdsIssueIssueTrade adsIssueIssueTrade = AdsIssueIssueTrade();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		adsIssueIssueTrade.id = id;
	}
	final int? quantity = jsonConvert.convert<int>(json['quantity']);
	if (quantity != null) {
		adsIssueIssueTrade.quantity = quantity;
	}
	final double? price = jsonConvert.convert<double>(json['price']);
	if (price != null) {
		adsIssueIssueTrade.price = price;
	}
	return adsIssueIssueTrade;
}

Map<String, dynamic> $AdsIssueIssueTradeToJson(AdsIssueIssueTrade entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['quantity'] = entity.quantity;
	data['price'] = entity.price;
	return data;
}

AdsIssueIssueBookmark $AdsIssueIssueBookmarkFromJson(Map<String, dynamic> json) {
	final AdsIssueIssueBookmark adsIssueIssueBookmark = AdsIssueIssueBookmark();
	return adsIssueIssueBookmark;
}

Map<String, dynamic> $AdsIssueIssueBookmarkToJson(AdsIssueIssueBookmark entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	return data;
}