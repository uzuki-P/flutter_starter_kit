// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:flutter_starter_kit/app/models/pojo/response/success_entity.dart';
import 'package:flutter_starter_kit/generated/json/success_entity_helper.dart';
import 'package:flutter_starter_kit/app/models/pojo/response/refresh_token_entity.dart';
import 'package:flutter_starter_kit/generated/json/refresh_token_entity_helper.dart';
import 'package:flutter_starter_kit/app/models/pojo/response/login_entity.dart';
import 'package:flutter_starter_kit/generated/json/login_entity_helper.dart';

class JsonConvert<T> {
	T fromJson(Map<String, dynamic> json) {
		return _getFromJson<T>(runtimeType, this, json);
	}

  Map<String, dynamic> toJson() {
		return _getToJson<T>(runtimeType, this);
  }

  static _getFromJson<T>(Type type, data, json) {
    switch (type) {			case SuccessEntity:
			return successEntityFromJson(data as SuccessEntity, json) as T;			case RefreshTokenEntity:
			return refreshTokenEntityFromJson(data as RefreshTokenEntity, json) as T;			case RefreshTokenData:
			return refreshTokenDataFromJson(data as RefreshTokenData, json) as T;			case LoginEntity:
			return loginEntityFromJson(data as LoginEntity, json) as T;			case LoginData:
			return loginDataFromJson(data as LoginData, json) as T;    }
    return data as T;
  }

  static _getToJson<T>(Type type, data) {
		switch (type) {			case SuccessEntity:
			return successEntityToJson(data as SuccessEntity);			case RefreshTokenEntity:
			return refreshTokenEntityToJson(data as RefreshTokenEntity);			case RefreshTokenData:
			return refreshTokenDataToJson(data as RefreshTokenData);			case LoginEntity:
			return loginEntityToJson(data as LoginEntity);			case LoginData:
			return loginDataToJson(data as LoginData);    }
    return data as T;
  }
  //Go back to a single instance by type
  static _fromJsonSingle(String type, json) {
    switch (type) {			case 'SuccessEntity':
			return SuccessEntity().fromJson(json);			case 'RefreshTokenEntity':
			return RefreshTokenEntity().fromJson(json);			case 'RefreshTokenData':
			return RefreshTokenData().fromJson(json);			case 'LoginEntity':
			return LoginEntity().fromJson(json);			case 'LoginData':
			return LoginData().fromJson(json);    }
    return null;
  }

  //empty list is returned by type
  static _getListFromType(String type) {
    switch (type) {			case 'SuccessEntity':
			return List<SuccessEntity>();			case 'RefreshTokenEntity':
			return List<RefreshTokenEntity>();			case 'RefreshTokenData':
			return List<RefreshTokenData>();			case 'LoginEntity':
			return List<LoginEntity>();			case 'LoginData':
			return List<LoginData>();    }
    return null;
  }

  static M fromJsonAsT<M>(json) {
    String type = M.toString();
    if (json is List && type.contains("List<")) {
      String itemType = type.substring(5, type.length - 1);
      List tempList = _getListFromType(itemType);
      json.forEach((itemJson) {
        tempList
            .add(_fromJsonSingle(type.substring(5, type.length - 1), itemJson));
      });
      return tempList as M;
    } else {
      return _fromJsonSingle(M.toString(), json) as M;
    }
  }
}