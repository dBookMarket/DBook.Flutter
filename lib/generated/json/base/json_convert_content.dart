// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:flutter/material.dart' show debugPrint;
import 'package:dbook/common/entities/ads_issue_entity.dart';
import 'package:dbook/common/entities/assets_entity.dart';
import 'package:dbook/common/entities/assets_info_entity.dart';
import 'package:dbook/common/entities/book_entity.dart';
import 'package:dbook/common/entities/collection_entity.dart';
import 'package:dbook/common/entities/concern_opus_entity.dart';
import 'package:dbook/common/entities/drafts_entity.dart';
import 'package:dbook/common/entities/fans_entity.dart';
import 'package:dbook/common/entities/issues_entity.dart';
import 'package:dbook/common/entities/order_info_entity.dart';
import 'package:dbook/common/entities/pending_order_entity.dart';
import 'package:dbook/common/entities/read_info_entity.dart';
import 'package:dbook/common/entities/trades_list_entity.dart';
import 'package:dbook/common/entities/transactions_list_entity.dart';
import 'package:dbook/common/entities/trend_list_entity.dart';
import 'package:dbook/common/entities/user_info_entity.dart';

JsonConvert jsonConvert = JsonConvert();
typedef JsonConvertFunction<T> = T Function(Map<String, dynamic> json);

class JsonConvert {
	static final Map<String, JsonConvertFunction> _convertFuncMap = {
		(AdsIssueEntity).toString(): AdsIssueEntity.fromJson,
		(AdsIssueIssue).toString(): AdsIssueIssue.fromJson,
		(AdsIssueIssueBook).toString(): AdsIssueIssueBook.fromJson,
		(AdsIssueIssueBookAuthor).toString(): AdsIssueIssueBookAuthor.fromJson,
		(AdsIssueIssueBookPreview).toString(): AdsIssueIssueBookPreview.fromJson,
		(AdsIssueIssuePriceRange).toString(): AdsIssueIssuePriceRange.fromJson,
		(AdsIssueIssueTrade).toString(): AdsIssueIssueTrade.fromJson,
		(AdsIssueIssueBookmark).toString(): AdsIssueIssueBookmark.fromJson,
		(AssetsEntity).toString(): AssetsEntity.fromJson,
		(AssetsIssue).toString(): AssetsIssue.fromJson,
		(AssetsBookmark).toString(): AssetsBookmark.fromJson,
		(AssetsInfoEntity).toString(): AssetsInfoEntity.fromJson,
		(AssetsInfoResults).toString(): AssetsInfoResults.fromJson,
		(AssetsInfoResultsIssue).toString(): AssetsInfoResultsIssue.fromJson,
		(AssetsInfoResultsBookmark).toString(): AssetsInfoResultsBookmark.fromJson,
		(BookEntity).toString(): BookEntity.fromJson,
		(BookAuthor).toString(): BookAuthor.fromJson,
		(BookPreview).toString(): BookPreview.fromJson,
		(CollectionEntity).toString(): CollectionEntity.fromJson,
		(CollectionIssue).toString(): CollectionIssue.fromJson,
		(CollectionIssueBook).toString(): CollectionIssueBook.fromJson,
		(CollectionIssueBookAuthor).toString(): CollectionIssueBookAuthor.fromJson,
		(ConcernOpusEntity).toString(): ConcernOpusEntity.fromJson,
		(ConcernOpusIssue).toString(): ConcernOpusIssue.fromJson,
		(ConcernOpusIssueBook).toString(): ConcernOpusIssueBook.fromJson,
		(ConcernOpusIssueBookAuthor).toString(): ConcernOpusIssueBookAuthor.fromJson,
		(DraftsEntity).toString(): DraftsEntity.fromJson,
		(DraftsAuthor).toString(): DraftsAuthor.fromJson,
		(FansEntity).toString(): FansEntity.fromJson,
		(FansAuthor).toString(): FansAuthor.fromJson,
		(IssuesEntity).toString(): IssuesEntity.fromJson,
		(IssuesBook).toString(): IssuesBook.fromJson,
		(IssuesBookAuthor).toString(): IssuesBookAuthor.fromJson,
		(IssuesBookPreview).toString(): IssuesBookPreview.fromJson,
		(IssuesPriceRange).toString(): IssuesPriceRange.fromJson,
		(IssuesTrade).toString(): IssuesTrade.fromJson,
		(IssuesBookmark).toString(): IssuesBookmark.fromJson,
		(IssuesToken).toString(): IssuesToken.fromJson,
		(OrderInfoEntity).toString(): OrderInfoEntity.fromJson,
		(PendingOrderEntity).toString(): PendingOrderEntity.fromJson,
		(PendingOrderUser).toString(): PendingOrderUser.fromJson,
		(PendingOrderIssue).toString(): PendingOrderIssue.fromJson,
		(PendingOrderIssueBook).toString(): PendingOrderIssueBook.fromJson,
		(PendingOrderIssueBookAuthor).toString(): PendingOrderIssueBookAuthor.fromJson,
		(PendingOrderIssueBookPreview).toString(): PendingOrderIssueBookPreview.fromJson,
		(ReadInfoEntity).toString(): ReadInfoEntity.fromJson,
		(ReadInfoBookmark).toString(): ReadInfoBookmark.fromJson,
		(TradesListEntity).toString(): TradesListEntity.fromJson,
		(TradesListUser).toString(): TradesListUser.fromJson,
		(TradesListIssue).toString(): TradesListIssue.fromJson,
		(TradesListIssueBook).toString(): TradesListIssueBook.fromJson,
		(TradesListIssueBookAuthor).toString(): TradesListIssueBookAuthor.fromJson,
		(TradesListIssueBookPreview).toString(): TradesListIssueBookPreview.fromJson,
		(TransactionsListEntity).toString(): TransactionsListEntity.fromJson,
		(TransactionsListIssue).toString(): TransactionsListIssue.fromJson,
		(TransactionsListIssuesToken).toString(): TransactionsListIssuesToken.fromJson,
		(TransactionsListIssueBook).toString(): TransactionsListIssueBook.fromJson,
		(TransactionsListIssueBookAuthor).toString(): TransactionsListIssueBookAuthor.fromJson,
		(TransactionsListIssueBookPreview).toString(): TransactionsListIssueBookPreview.fromJson,
		(TransactionsListSeller).toString(): TransactionsListSeller.fromJson,
		(TransactionsListBuyer).toString(): TransactionsListBuyer.fromJson,
		(TrendListEntity).toString(): TrendListEntity.fromJson,
		(UserInfoEntity).toString(): UserInfoEntity.fromJson,
		(UserInfoStatistic).toString(): UserInfoStatistic.fromJson,
	};

  T? convert<T>(dynamic value) {
    if (value == null) {
      return null;
    }
    return asT<T>(value);
  }

  List<T?>? convertList<T>(List<dynamic>? value) {
    if (value == null) {
      return null;
    }
    try {
      return value.map((dynamic e) => asT<T>(e)).toList();
    } catch (e, stackTrace) {
      debugPrint('asT<$T> $e $stackTrace');
      return <T>[];
    }
  }

  List<T>? convertListNotNull<T>(dynamic value) {
    if (value == null) {
      return null;
    }
    try {
      return (value as List<dynamic>).map((dynamic e) => asT<T>(e)!).toList();
    } catch (e, stackTrace) {
      debugPrint('asT<$T> $e $stackTrace');
      return <T>[];
    }
  }

  T? asT<T extends Object?>(dynamic value) {
    if(value == null){
      return null;
    }
    if (value is T) {
      return value;
    }
    final String type = T.toString();
    try {
      final String valueS = value.toString();
      if (type == "String") {
        return valueS as T;
      } else if (type == "int") {
        final int? intValue = int.tryParse(valueS);
        if (intValue == null) {
          return double.tryParse(valueS)?.toInt() as T?;
        } else {
          return intValue as T;
        }
      } else if (type == "double") {
        return double.parse(valueS) as T;
      } else if (type == "DateTime") {
        return DateTime.parse(valueS) as T;
      } else if (type == "bool") {
        if (valueS == '0' || valueS == '1') {
          return (valueS == '1') as T;
        }
        return (valueS == 'true') as T;
      } else if (type == "Map" || type.startsWith("Map<")) {
        return value as T;
      } else {
        if (_convertFuncMap.containsKey(type)) {
          return _convertFuncMap[type]!(value) as T;
        } else {
          throw UnimplementedError('$type unimplemented');
        }
      }
    } catch (e, stackTrace) {
      debugPrint('asT<$T> $e $stackTrace');
      return null;
    }
  }

	//list is returned by type
	static M? _getListChildType<M>(List<Map<String, dynamic>> data) {
		if(<AdsIssueEntity>[] is M){
			return data.map<AdsIssueEntity>((Map<String, dynamic> e) => AdsIssueEntity.fromJson(e)).toList() as M;
		}
		if(<AdsIssueIssue>[] is M){
			return data.map<AdsIssueIssue>((Map<String, dynamic> e) => AdsIssueIssue.fromJson(e)).toList() as M;
		}
		if(<AdsIssueIssueBook>[] is M){
			return data.map<AdsIssueIssueBook>((Map<String, dynamic> e) => AdsIssueIssueBook.fromJson(e)).toList() as M;
		}
		if(<AdsIssueIssueBookAuthor>[] is M){
			return data.map<AdsIssueIssueBookAuthor>((Map<String, dynamic> e) => AdsIssueIssueBookAuthor.fromJson(e)).toList() as M;
		}
		if(<AdsIssueIssueBookPreview>[] is M){
			return data.map<AdsIssueIssueBookPreview>((Map<String, dynamic> e) => AdsIssueIssueBookPreview.fromJson(e)).toList() as M;
		}
		if(<AdsIssueIssuePriceRange>[] is M){
			return data.map<AdsIssueIssuePriceRange>((Map<String, dynamic> e) => AdsIssueIssuePriceRange.fromJson(e)).toList() as M;
		}
		if(<AdsIssueIssueTrade>[] is M){
			return data.map<AdsIssueIssueTrade>((Map<String, dynamic> e) => AdsIssueIssueTrade.fromJson(e)).toList() as M;
		}
		if(<AdsIssueIssueBookmark>[] is M){
			return data.map<AdsIssueIssueBookmark>((Map<String, dynamic> e) => AdsIssueIssueBookmark.fromJson(e)).toList() as M;
		}
		if(<AssetsEntity>[] is M){
			return data.map<AssetsEntity>((Map<String, dynamic> e) => AssetsEntity.fromJson(e)).toList() as M;
		}
		if(<AssetsIssue>[] is M){
			return data.map<AssetsIssue>((Map<String, dynamic> e) => AssetsIssue.fromJson(e)).toList() as M;
		}
		if(<AssetsBookmark>[] is M){
			return data.map<AssetsBookmark>((Map<String, dynamic> e) => AssetsBookmark.fromJson(e)).toList() as M;
		}
		if(<AssetsInfoEntity>[] is M){
			return data.map<AssetsInfoEntity>((Map<String, dynamic> e) => AssetsInfoEntity.fromJson(e)).toList() as M;
		}
		if(<AssetsInfoResults>[] is M){
			return data.map<AssetsInfoResults>((Map<String, dynamic> e) => AssetsInfoResults.fromJson(e)).toList() as M;
		}
		if(<AssetsInfoResultsIssue>[] is M){
			return data.map<AssetsInfoResultsIssue>((Map<String, dynamic> e) => AssetsInfoResultsIssue.fromJson(e)).toList() as M;
		}
		if(<AssetsInfoResultsBookmark>[] is M){
			return data.map<AssetsInfoResultsBookmark>((Map<String, dynamic> e) => AssetsInfoResultsBookmark.fromJson(e)).toList() as M;
		}
		if(<BookEntity>[] is M){
			return data.map<BookEntity>((Map<String, dynamic> e) => BookEntity.fromJson(e)).toList() as M;
		}
		if(<BookAuthor>[] is M){
			return data.map<BookAuthor>((Map<String, dynamic> e) => BookAuthor.fromJson(e)).toList() as M;
		}
		if(<BookPreview>[] is M){
			return data.map<BookPreview>((Map<String, dynamic> e) => BookPreview.fromJson(e)).toList() as M;
		}
		if(<CollectionEntity>[] is M){
			return data.map<CollectionEntity>((Map<String, dynamic> e) => CollectionEntity.fromJson(e)).toList() as M;
		}
		if(<CollectionIssue>[] is M){
			return data.map<CollectionIssue>((Map<String, dynamic> e) => CollectionIssue.fromJson(e)).toList() as M;
		}
		if(<CollectionIssueBook>[] is M){
			return data.map<CollectionIssueBook>((Map<String, dynamic> e) => CollectionIssueBook.fromJson(e)).toList() as M;
		}
		if(<CollectionIssueBookAuthor>[] is M){
			return data.map<CollectionIssueBookAuthor>((Map<String, dynamic> e) => CollectionIssueBookAuthor.fromJson(e)).toList() as M;
		}
		if(<ConcernOpusEntity>[] is M){
			return data.map<ConcernOpusEntity>((Map<String, dynamic> e) => ConcernOpusEntity.fromJson(e)).toList() as M;
		}
		if(<ConcernOpusIssue>[] is M){
			return data.map<ConcernOpusIssue>((Map<String, dynamic> e) => ConcernOpusIssue.fromJson(e)).toList() as M;
		}
		if(<ConcernOpusIssueBook>[] is M){
			return data.map<ConcernOpusIssueBook>((Map<String, dynamic> e) => ConcernOpusIssueBook.fromJson(e)).toList() as M;
		}
		if(<ConcernOpusIssueBookAuthor>[] is M){
			return data.map<ConcernOpusIssueBookAuthor>((Map<String, dynamic> e) => ConcernOpusIssueBookAuthor.fromJson(e)).toList() as M;
		}
		if(<DraftsEntity>[] is M){
			return data.map<DraftsEntity>((Map<String, dynamic> e) => DraftsEntity.fromJson(e)).toList() as M;
		}
		if(<DraftsAuthor>[] is M){
			return data.map<DraftsAuthor>((Map<String, dynamic> e) => DraftsAuthor.fromJson(e)).toList() as M;
		}
		if(<FansEntity>[] is M){
			return data.map<FansEntity>((Map<String, dynamic> e) => FansEntity.fromJson(e)).toList() as M;
		}
		if(<FansAuthor>[] is M){
			return data.map<FansAuthor>((Map<String, dynamic> e) => FansAuthor.fromJson(e)).toList() as M;
		}
		if(<IssuesEntity>[] is M){
			return data.map<IssuesEntity>((Map<String, dynamic> e) => IssuesEntity.fromJson(e)).toList() as M;
		}
		if(<IssuesBook>[] is M){
			return data.map<IssuesBook>((Map<String, dynamic> e) => IssuesBook.fromJson(e)).toList() as M;
		}
		if(<IssuesBookAuthor>[] is M){
			return data.map<IssuesBookAuthor>((Map<String, dynamic> e) => IssuesBookAuthor.fromJson(e)).toList() as M;
		}
		if(<IssuesBookPreview>[] is M){
			return data.map<IssuesBookPreview>((Map<String, dynamic> e) => IssuesBookPreview.fromJson(e)).toList() as M;
		}
		if(<IssuesPriceRange>[] is M){
			return data.map<IssuesPriceRange>((Map<String, dynamic> e) => IssuesPriceRange.fromJson(e)).toList() as M;
		}
		if(<IssuesTrade>[] is M){
			return data.map<IssuesTrade>((Map<String, dynamic> e) => IssuesTrade.fromJson(e)).toList() as M;
		}
		if(<IssuesBookmark>[] is M){
			return data.map<IssuesBookmark>((Map<String, dynamic> e) => IssuesBookmark.fromJson(e)).toList() as M;
		}
		if(<IssuesToken>[] is M){
			return data.map<IssuesToken>((Map<String, dynamic> e) => IssuesToken.fromJson(e)).toList() as M;
		}
		if(<OrderInfoEntity>[] is M){
			return data.map<OrderInfoEntity>((Map<String, dynamic> e) => OrderInfoEntity.fromJson(e)).toList() as M;
		}
		if(<PendingOrderEntity>[] is M){
			return data.map<PendingOrderEntity>((Map<String, dynamic> e) => PendingOrderEntity.fromJson(e)).toList() as M;
		}
		if(<PendingOrderUser>[] is M){
			return data.map<PendingOrderUser>((Map<String, dynamic> e) => PendingOrderUser.fromJson(e)).toList() as M;
		}
		if(<PendingOrderIssue>[] is M){
			return data.map<PendingOrderIssue>((Map<String, dynamic> e) => PendingOrderIssue.fromJson(e)).toList() as M;
		}
		if(<PendingOrderIssueBook>[] is M){
			return data.map<PendingOrderIssueBook>((Map<String, dynamic> e) => PendingOrderIssueBook.fromJson(e)).toList() as M;
		}
		if(<PendingOrderIssueBookAuthor>[] is M){
			return data.map<PendingOrderIssueBookAuthor>((Map<String, dynamic> e) => PendingOrderIssueBookAuthor.fromJson(e)).toList() as M;
		}
		if(<PendingOrderIssueBookPreview>[] is M){
			return data.map<PendingOrderIssueBookPreview>((Map<String, dynamic> e) => PendingOrderIssueBookPreview.fromJson(e)).toList() as M;
		}
		if(<ReadInfoEntity>[] is M){
			return data.map<ReadInfoEntity>((Map<String, dynamic> e) => ReadInfoEntity.fromJson(e)).toList() as M;
		}
		if(<ReadInfoBookmark>[] is M){
			return data.map<ReadInfoBookmark>((Map<String, dynamic> e) => ReadInfoBookmark.fromJson(e)).toList() as M;
		}
		if(<TradesListEntity>[] is M){
			return data.map<TradesListEntity>((Map<String, dynamic> e) => TradesListEntity.fromJson(e)).toList() as M;
		}
		if(<TradesListUser>[] is M){
			return data.map<TradesListUser>((Map<String, dynamic> e) => TradesListUser.fromJson(e)).toList() as M;
		}
		if(<TradesListIssue>[] is M){
			return data.map<TradesListIssue>((Map<String, dynamic> e) => TradesListIssue.fromJson(e)).toList() as M;
		}
		if(<TradesListIssueBook>[] is M){
			return data.map<TradesListIssueBook>((Map<String, dynamic> e) => TradesListIssueBook.fromJson(e)).toList() as M;
		}
		if(<TradesListIssueBookAuthor>[] is M){
			return data.map<TradesListIssueBookAuthor>((Map<String, dynamic> e) => TradesListIssueBookAuthor.fromJson(e)).toList() as M;
		}
		if(<TradesListIssueBookPreview>[] is M){
			return data.map<TradesListIssueBookPreview>((Map<String, dynamic> e) => TradesListIssueBookPreview.fromJson(e)).toList() as M;
		}
		if(<TransactionsListEntity>[] is M){
			return data.map<TransactionsListEntity>((Map<String, dynamic> e) => TransactionsListEntity.fromJson(e)).toList() as M;
		}
		if(<TransactionsListIssue>[] is M){
			return data.map<TransactionsListIssue>((Map<String, dynamic> e) => TransactionsListIssue.fromJson(e)).toList() as M;
		}
		if(<TransactionsListIssuesToken>[] is M){
			return data.map<TransactionsListIssuesToken>((Map<String, dynamic> e) => TransactionsListIssuesToken.fromJson(e)).toList() as M;
		}
		if(<TransactionsListIssueBook>[] is M){
			return data.map<TransactionsListIssueBook>((Map<String, dynamic> e) => TransactionsListIssueBook.fromJson(e)).toList() as M;
		}
		if(<TransactionsListIssueBookAuthor>[] is M){
			return data.map<TransactionsListIssueBookAuthor>((Map<String, dynamic> e) => TransactionsListIssueBookAuthor.fromJson(e)).toList() as M;
		}
		if(<TransactionsListIssueBookPreview>[] is M){
			return data.map<TransactionsListIssueBookPreview>((Map<String, dynamic> e) => TransactionsListIssueBookPreview.fromJson(e)).toList() as M;
		}
		if(<TransactionsListSeller>[] is M){
			return data.map<TransactionsListSeller>((Map<String, dynamic> e) => TransactionsListSeller.fromJson(e)).toList() as M;
		}
		if(<TransactionsListBuyer>[] is M){
			return data.map<TransactionsListBuyer>((Map<String, dynamic> e) => TransactionsListBuyer.fromJson(e)).toList() as M;
		}
		if(<TrendListEntity>[] is M){
			return data.map<TrendListEntity>((Map<String, dynamic> e) => TrendListEntity.fromJson(e)).toList() as M;
		}
		if(<UserInfoEntity>[] is M){
			return data.map<UserInfoEntity>((Map<String, dynamic> e) => UserInfoEntity.fromJson(e)).toList() as M;
		}
		if(<UserInfoStatistic>[] is M){
			return data.map<UserInfoStatistic>((Map<String, dynamic> e) => UserInfoStatistic.fromJson(e)).toList() as M;
		}

		debugPrint("${M.toString()} not found");
	
		return null;
}

	static M? fromJsonAsT<M>(dynamic json) {
		if (json is List) {
			return _getListChildType<M>(json.map((e) => e as Map<String, dynamic>).toList());
		} else {
			return jsonConvert.asT<M>(json);
		}
	}
}