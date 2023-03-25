import 'package:dbook/generated/json/base/json_convert_content.dart';
import 'package:dbook/common/entities/trend_list_entity.dart';

TrendListEntity $TrendListEntityFromJson(Map<String, dynamic> json) {
	final TrendListEntity trendListEntity = TrendListEntity();
	final String? date = jsonConvert.convert<String>(json['date']);
	if (date != null) {
		trendListEntity.date = date;
	}
	final int? quantity = jsonConvert.convert<int>(json['quantity']);
	if (quantity != null) {
		trendListEntity.quantity = quantity;
	}
	final double? price = jsonConvert.convert<double>(json['price']);
	if (price != null) {
		trendListEntity.price = price;
	}
	return trendListEntity;
}

Map<String, dynamic> $TrendListEntityToJson(TrendListEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['date'] = entity.date;
	data['quantity'] = entity.quantity;
	data['price'] = entity.price;
	return data;
}