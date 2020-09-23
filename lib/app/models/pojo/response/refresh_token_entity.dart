import 'package:flutter_starter_kit/generated/json/base/json_convert_content.dart';
import 'package:flutter_starter_kit/generated/json/base/json_field.dart';

class RefreshTokenEntity with JsonConvert<RefreshTokenEntity> {
  bool error;
  String message;
  RefreshTokenData data;
}

class RefreshTokenData with JsonConvert<RefreshTokenData> {
  @JSONField(name: "token_type")
  String tokenType;
  @JSONField(name: "expires_in")
  int expiresIn;
  @JSONField(name: "access_token")
  String accessToken;
  @JSONField(name: "refresh_token")
  String refreshToken;
}
