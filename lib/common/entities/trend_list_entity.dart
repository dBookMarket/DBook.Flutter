import 'package:dbook/generated/json/base/json_field.dart';
import 'package:dbook/generated/json/trend_list_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class TrendListEntity {

	String? date;
	int? quantity;
  double? price;
  
  TrendListEntity();

  factory TrendListEntity.fromJson(Map<String, dynamic> json) => $TrendListEntityFromJson(json);

  Map<String, dynamic> toJson() => $TrendListEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}