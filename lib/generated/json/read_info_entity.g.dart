import 'package:dbook/generated/json/base/json_convert_content.dart';
import 'package:dbook/common/entities/read_info_entity.dart';

ReadInfoEntity $ReadInfoEntityFromJson(Map<String, dynamic> json) {
	final ReadInfoEntity readInfoEntity = ReadInfoEntity();
	final List<String>? files = jsonConvert.convertListNotNull<String>(json['files']);
	if (files != null) {
		readInfoEntity.files = files;
	}
	final String? sk = jsonConvert.convert<String>(json['sk']);
	if (sk != null) {
		readInfoEntity.sk = sk;
	}
	return readInfoEntity;
}

Map<String, dynamic> $ReadInfoEntityToJson(ReadInfoEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['files'] =  entity.files;
	data['sk'] = entity.sk;
	return data;
}