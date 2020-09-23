import 'package:flutter_starter_kit/app/models/pojo/response/success_entity.dart';

successEntityFromJson(SuccessEntity data, Map<String, dynamic> json) {
	if (json['error'] != null) {
		data.error = json['error'];
	}
	if (json['message'] != null) {
		data.message = json['message']?.toString();
	}
	if (json['data'] != null) {
		data.data = json['data']?.toString();
	}
	return data;
}

Map<String, dynamic> successEntityToJson(SuccessEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['error'] = entity.error;
	data['message'] = entity.message;
	data['data'] = entity.data;
	return data;
}