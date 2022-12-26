import 'package:dbook/generated/json/base/json_convert_content.dart';
import 'package:dbook/common/entities/trend_list_entity.dart';

TrendListEntity $TrendListEntityFromJson(Map<String, dynamic> json) {
	final TrendListEntity trendListEntity = TrendListEntity();
	final String? date = jsonConvert.convert<String>(json['date']);
	if (date != null) {
		trendListEntity.date = date;
	}
	final int? quantities = jsonConvert.convert<int>(json['quantities']);
	if (quantities != null) {
		trendListEntity.quantities = quantities;
	}
	return trendListEntity;
}

Map<String, dynamic> $TrendListEntityToJson(TrendListEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['date'] = entity.date;
	data['quantities'] = entity.quantities;
	return data;
}