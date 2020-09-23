import 'package:flutter_starter_kit/generated/json/base/json_convert_content.dart';
import 'package:flutter_starter_kit/generated/json/base/json_field.dart';

class LoginEntity with JsonConvert<LoginEntity> {
  bool error;
  String message;
  LoginData data;
}

class LoginData with JsonConvert<LoginData> {
  @JSONField(name: "token_type")
  String tokenType;
  @JSONField(name: "expires_in")
  int expiresIn;
  @JSONField(name: "access_token")
  String accessToken;
  @JSONField(name: "refresh_token")
  String refreshToken;
  @JSONField(name: "user_uid")
  String userUid;
}
