import 'package:dbook/common/entities/book_entity.dart';
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
	final BookEntity? book = jsonConvert.convert<BookEntity>(json['book']);
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
	final int? royalty = jsonConvert.convert<int>(json['royalty']);
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
	data['token'] = entity.token?.toJson();
	data['destroy_log'] = entity.destroyLog;
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
	final String? createdAt = jsonConvert.convert<String>(json['created_at']);
	if (createdAt != null) {
		issuesToken.createdAt = createdAt;
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
	data['created_at'] = entity.createdAt;
	data['issue'] = entity.issue;
	data['contract_address'] = entity.contractAddress;
	data['block_chain'] = entity.blockChain;
	data['standard'] = entity.standard;
	data['currency'] = entity.currency;
	return data;
}