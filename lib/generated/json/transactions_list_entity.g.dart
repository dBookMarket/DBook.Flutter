import 'package:dbook/generated/json/base/json_convert_content.dart';
import 'package:dbook/common/entities/transactions_list_entity.dart';

TransactionsListEntity $TransactionsListEntityFromJson(Map<String, dynamic> json) {
	final TransactionsListEntity transactionsListEntity = TransactionsListEntity();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		transactionsListEntity.id = id;
	}
	final String? createdAt = jsonConvert.convert<String>(json['created_at']);
	if (createdAt != null) {
		transactionsListEntity.createdAt = createdAt;
	}
	final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
	if (updatedAt != null) {
		transactionsListEntity.updatedAt = updatedAt;
	}
	final int? trade = jsonConvert.convert<int>(json['trade']);
	if (trade != null) {
		transactionsListEntity.trade = trade;
	}
	final TransactionsListIssue? issue = jsonConvert.convert<TransactionsListIssue>(json['issue']);
	if (issue != null) {
		transactionsListEntity.issue = issue;
	}
	final int? quantity = jsonConvert.convert<int>(json['quantity']);
	if (quantity != null) {
		transactionsListEntity.quantity = quantity;
	}
	final double? price = jsonConvert.convert<double>(json['price']);
	if (price != null) {
		transactionsListEntity.price = price;
	}
	final TransactionsListSeller? seller = jsonConvert.convert<TransactionsListSeller>(json['seller']);
	if (seller != null) {
		transactionsListEntity.seller = seller;
	}
	final TransactionsListBuyer? buyer = jsonConvert.convert<TransactionsListBuyer>(json['buyer']);
	if (buyer != null) {
		transactionsListEntity.buyer = buyer;
	}
	final String? status = jsonConvert.convert<String>(json['status']);
	if (status != null) {
		transactionsListEntity.status = status;
	}
	final String? hash = jsonConvert.convert<String>(json['hash']);
	if (hash != null) {
		transactionsListEntity.hash = hash;
	}
	final int? xSource = jsonConvert.convert<int>(json['source']);
	if (xSource != null) {
		transactionsListEntity.xSource = xSource;
	}
	final String? type = jsonConvert.convert<String>(json['type']);
	if (type != null) {
		transactionsListEntity.type = type;
	}
	return transactionsListEntity;
}

Map<String, dynamic> $TransactionsListEntityToJson(TransactionsListEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['created_at'] = entity.createdAt;
	data['updated_at'] = entity.updatedAt;
	data['trade'] = entity.trade;
	data['issue'] = entity.issue?.toJson();
	data['quantity'] = entity.quantity;
	data['price'] = entity.price;
	data['seller'] = entity.seller?.toJson();
	data['buyer'] = entity.buyer?.toJson();
	data['status'] = entity.status;
	data['hash'] = entity.hash;
	data['source'] = entity.xSource;
	data['type'] = entity.type;
	return data;
}

TransactionsListIssue $TransactionsListIssueFromJson(Map<String, dynamic> json) {
	final TransactionsListIssue transactionsListIssue = TransactionsListIssue();
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		transactionsListIssue.id = id;
	}
	final TransactionsListIssueBook? book = jsonConvert.convert<TransactionsListIssueBook>(json['book']);
	if (book != null) {
		transactionsListIssue.book = book;
	}
	final TransactionsListIssuesToken? token = jsonConvert.convert<TransactionsListIssuesToken>(json['token']);
	if (token != null) {
		transactionsListIssue.token = token;
	}
	final double? price = jsonConvert.convert<double>(json['price']);
	if (price != null) {
		transactionsListIssue.price = price;
	}
	final int? quantity = jsonConvert.convert<int>(json['quantity']);
	if (quantity != null) {
		transactionsListIssue.quantity = quantity;
	}
	final int? nCirculations = jsonConvert.convert<int>(json['n_circulations']);
	if (nCirculations != null) {
		transactionsListIssue.nCirculations = nCirculations;
	}
	final String? publishedAt = jsonConvert.convert<String>(json['published_at']);
	if (publishedAt != null) {
		transactionsListIssue.publishedAt = publishedAt;
	}
	return transactionsListIssue;
}

Map<String, dynamic> $TransactionsListIssueToJson(TransactionsListIssue entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['book'] = entity.book?.toJson();
	data['token'] = entity.token?.toJson();
	data['price'] = entity.price;
	data['quantity'] = entity.quantity;
	data['n_circulations'] = entity.nCirculations;
	data['published_at'] = entity.publishedAt;
	return data;
}

TransactionsListIssuesToken $TransactionsListIssuesTokenFromJson(Map<String, dynamic> json) {
	final TransactionsListIssuesToken transactionsListIssuesToken = TransactionsListIssuesToken();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		transactionsListIssuesToken.id = id;
	}
	final String? issue = jsonConvert.convert<String>(json['issue']);
	if (issue != null) {
		transactionsListIssuesToken.issue = issue;
	}
	final String? contractAddress = jsonConvert.convert<String>(json['contract_address']);
	if (contractAddress != null) {
		transactionsListIssuesToken.contractAddress = contractAddress;
	}
	final String? blockChain = jsonConvert.convert<String>(json['block_chain']);
	if (blockChain != null) {
		transactionsListIssuesToken.blockChain = blockChain;
	}
	final String? standard = jsonConvert.convert<String>(json['standard']);
	if (standard != null) {
		transactionsListIssuesToken.standard = standard;
	}
	final String? currency = jsonConvert.convert<String>(json['currency']);
	if (currency != null) {
		transactionsListIssuesToken.currency = currency;
	}
	return transactionsListIssuesToken;
}

Map<String, dynamic> $TransactionsListIssuesTokenToJson(TransactionsListIssuesToken entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['issue'] = entity.issue;
	data['contract_address'] = entity.contractAddress;
	data['block_chain'] = entity.blockChain;
	data['standard'] = entity.standard;
	data['currency'] = entity.currency;
	return data;
}

TransactionsListIssueBook $TransactionsListIssueBookFromJson(Map<String, dynamic> json) {
	final TransactionsListIssueBook transactionsListIssueBook = TransactionsListIssueBook();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		transactionsListIssueBook.id = id;
	}
	final String? createdAt = jsonConvert.convert<String>(json['created_at']);
	if (createdAt != null) {
		transactionsListIssueBook.createdAt = createdAt;
	}
	final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
	if (updatedAt != null) {
		transactionsListIssueBook.updatedAt = updatedAt;
	}
	final TransactionsListIssueBookAuthor? author = jsonConvert.convert<TransactionsListIssueBookAuthor>(json['author']);
	if (author != null) {
		transactionsListIssueBook.author = author;
	}
	final String? title = jsonConvert.convert<String>(json['title']);
	if (title != null) {
		transactionsListIssueBook.title = title;
	}
	final String? desc = jsonConvert.convert<String>(json['desc']);
	if (desc != null) {
		transactionsListIssueBook.desc = desc;
	}
	final String? coverUrl = jsonConvert.convert<String>(json['cover_url']);
	if (coverUrl != null) {
		transactionsListIssueBook.coverUrl = coverUrl;
	}
	final String? status = jsonConvert.convert<String>(json['status']);
	if (status != null) {
		transactionsListIssueBook.status = status;
	}
	final TransactionsListIssueBookPreview? preview = jsonConvert.convert<TransactionsListIssueBookPreview>(json['preview']);
	if (preview != null) {
		transactionsListIssueBook.preview = preview;
	}
	final int? nPages = jsonConvert.convert<int>(json['n_pages']);
	if (nPages != null) {
		transactionsListIssueBook.nPages = nPages;
	}
	final String? cid = jsonConvert.convert<String>(json['cid']);
	if (cid != null) {
		transactionsListIssueBook.cid = cid;
	}
	return transactionsListIssueBook;
}

Map<String, dynamic> $TransactionsListIssueBookToJson(TransactionsListIssueBook entity) {
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
	return data;
}

TransactionsListIssueBookAuthor $TransactionsListIssueBookAuthorFromJson(Map<String, dynamic> json) {
	final TransactionsListIssueBookAuthor transactionsListIssueBookAuthor = TransactionsListIssueBookAuthor();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		transactionsListIssueBookAuthor.id = id;
	}
	final String? address = jsonConvert.convert<String>(json['address']);
	if (address != null) {
		transactionsListIssueBookAuthor.address = address;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		transactionsListIssueBookAuthor.name = name;
	}
	final String? desc = jsonConvert.convert<String>(json['desc']);
	if (desc != null) {
		transactionsListIssueBookAuthor.desc = desc;
	}
	final String? avatarUrl = jsonConvert.convert<String>(json['avatar_url']);
	if (avatarUrl != null) {
		transactionsListIssueBookAuthor.avatarUrl = avatarUrl;
	}
	final String? websiteUrl = jsonConvert.convert<String>(json['website_url']);
	if (websiteUrl != null) {
		transactionsListIssueBookAuthor.websiteUrl = websiteUrl;
	}
	final String? discordUrl = jsonConvert.convert<String>(json['discord_url']);
	if (discordUrl != null) {
		transactionsListIssueBookAuthor.discordUrl = discordUrl;
	}
	final String? twitterUrl = jsonConvert.convert<String>(json['twitter_url']);
	if (twitterUrl != null) {
		transactionsListIssueBookAuthor.twitterUrl = twitterUrl;
	}
	return transactionsListIssueBookAuthor;
}

Map<String, dynamic> $TransactionsListIssueBookAuthorToJson(TransactionsListIssueBookAuthor entity) {
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

TransactionsListIssueBookPreview $TransactionsListIssueBookPreviewFromJson(Map<String, dynamic> json) {
	final TransactionsListIssueBookPreview transactionsListIssueBookPreview = TransactionsListIssueBookPreview();
	return transactionsListIssueBookPreview;
}

Map<String, dynamic> $TransactionsListIssueBookPreviewToJson(TransactionsListIssueBookPreview entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	return data;
}

TransactionsListSeller $TransactionsListSellerFromJson(Map<String, dynamic> json) {
	final TransactionsListSeller transactionsListSeller = TransactionsListSeller();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		transactionsListSeller.id = id;
	}
	final String? address = jsonConvert.convert<String>(json['address']);
	if (address != null) {
		transactionsListSeller.address = address;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		transactionsListSeller.name = name;
	}
	final String? desc = jsonConvert.convert<String>(json['desc']);
	if (desc != null) {
		transactionsListSeller.desc = desc;
	}
	final String? avatarUrl = jsonConvert.convert<String>(json['avatar_url']);
	if (avatarUrl != null) {
		transactionsListSeller.avatarUrl = avatarUrl;
	}
	final String? websiteUrl = jsonConvert.convert<String>(json['website_url']);
	if (websiteUrl != null) {
		transactionsListSeller.websiteUrl = websiteUrl;
	}
	final String? discordUrl = jsonConvert.convert<String>(json['discord_url']);
	if (discordUrl != null) {
		transactionsListSeller.discordUrl = discordUrl;
	}
	final String? twitterUrl = jsonConvert.convert<String>(json['twitter_url']);
	if (twitterUrl != null) {
		transactionsListSeller.twitterUrl = twitterUrl;
	}
	return transactionsListSeller;
}

Map<String, dynamic> $TransactionsListSellerToJson(TransactionsListSeller entity) {
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

TransactionsListBuyer $TransactionsListBuyerFromJson(Map<String, dynamic> json) {
	final TransactionsListBuyer transactionsListBuyer = TransactionsListBuyer();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		transactionsListBuyer.id = id;
	}
	final String? address = jsonConvert.convert<String>(json['address']);
	if (address != null) {
		transactionsListBuyer.address = address;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		transactionsListBuyer.name = name;
	}
	final String? desc = jsonConvert.convert<String>(json['desc']);
	if (desc != null) {
		transactionsListBuyer.desc = desc;
	}
	final String? avatarUrl = jsonConvert.convert<String>(json['avatar_url']);
	if (avatarUrl != null) {
		transactionsListBuyer.avatarUrl = avatarUrl;
	}
	final String? websiteUrl = jsonConvert.convert<String>(json['website_url']);
	if (websiteUrl != null) {
		transactionsListBuyer.websiteUrl = websiteUrl;
	}
	final String? discordUrl = jsonConvert.convert<String>(json['discord_url']);
	if (discordUrl != null) {
		transactionsListBuyer.discordUrl = discordUrl;
	}
	final String? twitterUrl = jsonConvert.convert<String>(json['twitter_url']);
	if (twitterUrl != null) {
		transactionsListBuyer.twitterUrl = twitterUrl;
	}
	return transactionsListBuyer;
}

Map<String, dynamic> $TransactionsListBuyerToJson(TransactionsListBuyer entity) {
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