import 'package:dbook/generated/json/base/json_field.dart';
import 'package:dbook/generated/json/order_info_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class OrderInfoEntity {

	String? hash;
	@JSONField(name: "created_at")
	int? createdAt;
	String? from;
	String? to;
	String? status;
	@JSONField(name: "block_chain")
	String? blockChain;
	String? currency;
	int? quantity;
	num? price;
	String? cover;
	String? bookName;
  
  OrderInfoEntity();

  factory OrderInfoEntity.fromJson(Map<String, dynamic> json) => $OrderInfoEntityFromJson(json);

  Map<String, dynamic> toJson() => $OrderInfoEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}