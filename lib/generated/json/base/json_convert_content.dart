// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:flutter/material.dart';
import 'package:dbook/common/entities/assets_entity.dart';
import 'package:dbook/common/entities/assets_info_entity.dart';

JsonConvert jsonConvert = JsonConvert();
typedef JsonConvertFunction<T> = T Function(Map<String, dynamic> json);

class JsonConvert {
	static final Map<String, JsonConvertFunction> _convertFuncMap = {
		(AssetsEntity).toString(): AssetsEntity.fromJson,
		(AssetsIssue).toString(): AssetsIssue.fromJson,
		(AssetsBookmark).toString(): AssetsBookmark.fromJson,
		(AssetsInfoEntity).toString(): AssetsInfoEntity.fromJson,
		(AssetsInfoResults).toString(): AssetsInfoResults.fromJson,
		(AssetsInfoResultsIssue).toString(): AssetsInfoResultsIssue.fromJson,
		(AssetsInfoResultsBookmark).toString(): AssetsInfoResultsBookmark.fromJson,
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