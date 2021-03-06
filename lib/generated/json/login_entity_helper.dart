import 'package:flutter_starter_kit/app/models/pojo/response/login_entity.dart';

loginEntityFromJson(LoginEntity data, Map<String, dynamic> json) {
	if (json['error'] != null) {
		data.error = json['error'];
	}
	if (json['message'] != null) {
		data.message = json['message']?.toString();
	}
	if (json['data'] != null) {
		data.data = new LoginData().fromJson(json['data']);
	}
	return data;
}

Map<String, dynamic> loginEntityToJson(LoginEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['error'] = entity.error;
	data['message'] = entity.message;
	if (entity.data != null) {
		data['data'] = entity.data.toJson();
	}
	return data;
}

loginDataFromJson(LoginData data, Map<String, dynamic> json) {
	if (json['token_type'] != null) {
		data.tokenType = json['token_type']?.toString();
	}
	if (json['expires_in'] != null) {
		data.expiresIn = json['expires_in']?.toInt();
	}
	if (json['access_token'] != null) {
		data.accessToken = json['access_token']?.toString();
	}
	if (json['refresh_token'] != null) {
		data.refreshToken = json['refresh_token']?.toString();
	}
	if (json['user_uid'] != null) {
		data.userUid = json['user_uid']?.toString();
	}
	return data;
}

Map<String, dynamic> loginDataToJson(LoginData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['token_type'] = entity.tokenType;
	data['expires_in'] = entity.expiresIn;
	data['access_token'] = entity.accessToken;
	data['refresh_token'] = entity.refreshToken;
	data['user_uid'] = entity.userUid;
	return data;
}