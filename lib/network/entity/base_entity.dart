import 'entity_factory.dart';

class HttpConstant {
  static const String responseCode = 'responseCode';
  static const String responseMsg = 'responseMsg';
  static const String success = 'success';

  static const String result = 'result';

  static const String data = 'data';
  static const String message = 'message';
  static const String code = 'code';
}

class BaseEntity<T> {
  int? code;
  String? message = "";
  T? data;
  String? responseCode;

  String? responseMsg;
  bool? success;
  T? result;

  List<T> listData = [];

  BaseEntity(this.code, this.message, this.data, {this.responseCode});

  BaseEntity.fromJson(Map<String, dynamic>? json) {
    if (json!.containsKey(HttpConstant.responseCode)) {
      responseCode = json[HttpConstant.responseCode];
      responseMsg = json[HttpConstant.responseMsg];
    }
    if (json.containsKey(HttpConstant.code)) {
      code = json[HttpConstant.code];
      message = json[HttpConstant.message];
      success = json[HttpConstant.success];
    }
    if (json.containsKey(HttpConstant.data)) {
      if (json[HttpConstant.data] is List) {
        (json[HttpConstant.data] as List).forEach((item) {
          listData.add(_generateOBJ<T>(item)!);
        });
      } else {
        data = _generateOBJ(json[HttpConstant.data]);
      }
    } else if (json.containsKey(HttpConstant.result)) {
      if (json[HttpConstant.result] is List) {
        (json[HttpConstant.result] as List).forEach((item) {
          listData.add(_generateOBJ<T>(item)!);
        });
      } else {
        data = _generateOBJ(json[HttpConstant.result]);
      }
    } else {
      data = _generateOBJ(json);
    }
  }

  S? _generateOBJ<S>(json) {
    if (S.toString() == 'String') {
      return json.toString() as S;
    } else if (T.toString() == 'Map<dynamic, dynamic>') {
      if (json != null) {
        return json as S;
      }
      return null;
    } else {
      return EntityFactory.generateOBJ(json);
    }
  }
}
