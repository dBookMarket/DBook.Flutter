import 'package:dbook/generated/json/base/json_convert_content.dart';
import 'package:dbook/common/entities/order_info_entity.dart';

OrderInfoEntity $OrderInfoEntityFromJson(Map<String, dynamic> json) {
	final OrderInfoEntity orderInfoEntity = OrderInfoEntity();
	final String? hash = jsonConvert.convert<String>(json['hash']);
	if (hash != null) {
		orderInfoEntity.hash = hash;
	}
	final int? createdAt = jsonConvert.convert<int>(json['created_at']);
	if (createdAt != null) {
		orderInfoEntity.createdAt = createdAt;
	}
	final String? from = jsonConvert.convert<String>(json['from']);
	if (from != null) {
		orderInfoEntity.from = from;
	}
	final String? to = jsonConvert.convert<String>(json['to']);
	if (to != null) {
		orderInfoEntity.to = to;
	}
	final String? status = jsonConvert.convert<String>(json['status']);
	if (status != null) {
		orderInfoEntity.status = status;
	}
	final String? blockChain = jsonConvert.convert<String>(json['block_chain']);
	if (blockChain != null) {
		orderInfoEntity.blockChain = blockChain;
	}
	final String? currency = jsonConvert.convert<String>(json['currency']);
	if (currency != null) {
		orderInfoEntity.currency = currency;
	}
	final int? quantity = jsonConvert.convert<int>(json['quantity']);
	if (quantity != null) {
		orderInfoEntity.quantity = quantity;
	}
	final num? price = jsonConvert.convert<num>(json['price']);
	if (price != null) {
		orderInfoEntity.price = price;
	}
	final String? cover = jsonConvert.convert<String>(json['cover']);
	if (cover != null) {
		orderInfoEntity.cover = cover;
	}
	final String? bookName = jsonConvert.convert<String>(json['bookName']);
	if (bookName != null) {
		orderInfoEntity.bookName = bookName;
	}
	return orderInfoEntity;
}

Map<String, dynamic> $OrderInfoEntityToJson(OrderInfoEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['hash'] = entity.hash;
	data['created_at'] = entity.createdAt;
	data['from'] = entity.from;
	data['to'] = entity.to;
	data['status'] = entity.status;
	data['block_chain'] = entity.blockChain;
	data['currency'] = entity.currency;
	data['quantity'] = entity.quantity;
	data['price'] = entity.price;
	data['cover'] = entity.cover;
	data['bookName'] = entity.bookName;
	return data;
}