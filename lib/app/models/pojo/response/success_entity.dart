import 'package:flutter_starter_kit/generated/json/base/json_convert_content.dart';

class SuccessEntity with JsonConvert<SuccessEntity> {
  bool error;
  String message;
  String data;
}
