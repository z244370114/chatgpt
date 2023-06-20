import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import '../utils/log_util.dart';
import 'entity/base_entity.dart';
import 'interceptor/error_handle.dart';
import 'interceptor/interceptor.dart';

class LoginVailedEvnet {
  final String msg;

  LoginVailedEvnet(this.msg);
}

const String tokenCacheKey = "login_token";

class DioUtils {
  static final DioUtils _singleton = DioUtils._internal();

  static DioUtils get instance => DioUtils();

  static bool _isProduct = true;

  static String _apiBaseUrl = "https://api.openai.com";

  static String? _customHost;

  static bool _proxy = false;

  static String? _proxyip;

  static String? _token;

  static String? get token => _token;

  static set token(String? value) {
    if (_token != value) {
      _token = value;
      // SharedPreferences.getInstance().then((prefs) {
      //   _token == null
      //       ? prefs.remove(tokenCacheKey)
      //       : prefs.setString(tokenCacheKey, _token!);
      // });
    }
  }

  static init(
      {required String baseurl,
      bool isProduct = false,
      String? customhost,
      bool proxy = false,
      String? proxyip}) async {
    _apiBaseUrl = baseurl;
    _isProduct = isProduct;
    _customHost = customhost;
    _proxy = proxy;
    _proxyip = proxyip;
  }

  factory DioUtils() {
    return _singleton;
  }

  static late Dio _dio;

  Dio getDio() {
    return _dio;
  }

  DioUtils._internal() {
    var options = BaseOptions(
      baseUrl: _apiBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
      contentType: ContentType.json.value,
      responseType: ResponseType.plain,
      validateStatus: (status) {
        // 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
        return true;
      },
    );
    _dio = Dio(options);
    if (_proxy && _proxyip != null && _proxyip!.isNotEmpty) {
      ///设置代理用来调试应用

      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.findProxy = (_) {
          return 'PROXY $_proxyip';
        };

        ///抓Https包设置
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      };
    }
    //统一请求头拦截器
    _dio.interceptors.add(AuthInterceptor());

    /// 打印Log(生产模式去除)
    if (!_isProduct) {
      _dio.interceptors.add(LoggingInterceptor());
    }
  }

  // 数据返回格式统一，统一处理异常
  Future<BaseEntity<T>> _request<T>(String method, String url,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      String? baseUrl,
      CancelToken? cancelToken,
      Options? options}) async {
    if (baseUrl != null && baseUrl.isNotEmpty && baseUrl.startsWith("http")) {
      _dio.options.baseUrl = baseUrl;
    } else {
      // bool isProduction = _isProduct && _apiBaseUrl == "";
      // if (!isProduction && _customHost != null && _customHost!.isNotEmpty) {
      //   //测试环境允许更换host
      //   _dio.options.baseUrl = _customHost!;
      // } else {
      //   _dio.options.baseUrl = _apiBaseUrl;
      // }
    }

    Response response = await _dio.request(url,
        data: data,
        queryParameters: queryParameters,
        options: _checkOptions(method, options),
        cancelToken: cancelToken);
    try {
      Map<String, dynamic> _map = parseData(response.data.toString());
      _map[HttpConstant.responseCode] = response.statusCode.toString();
      _map[HttpConstant.responseMsg] = response.statusMessage ?? "";

      return BaseEntity.fromJson(_map);
    } catch (e) {
      print(e);
      if (e is TypeError) {
        print(e.stackTrace);
      }
      return BaseEntity(ExceptionHandle.parse_error, '数据解析错误', null);
    }
  }

  Options _checkOptions(method, options) {
    if (options == null) {
      options = new Options();
    }
    options.method = method;
    return options;
  }

  Future requestNetwork<T>(Method method, String url,
      {Function(T? t)? onSuccess,
      Function(List<T> list)? onSuccessList,
      Function(int code, String msg)? onError,
      String? baseUrl,
      dynamic params,
      Map<String, dynamic>? queryParameters,
      CancelToken? cancelToken,
      Options? options,
      bool isList = false}) {
    String m = _getMethod(method);
    return _request<T>(m, url,
            data: params,
            queryParameters: queryParameters,
            options: options,
            baseUrl: baseUrl,
            cancelToken: cancelToken)
        .then((BaseEntity<T>? result) {
      if (result == null) {
        _onError(9001, "数据为空", onError);
      } else if (result.responseCode != null && result.responseCode == "200") {
        if (isList) {
          if (onSuccessList != null) {
            onSuccessList(result.listData);
          }
        } else {
          if (onSuccess != null) {
            onSuccess(result.data);
          }
        }
      } else {
        _onError(int.parse(result.responseCode ?? "0"), result.message ?? "",
            onError);
      }
    }, onError: (e, _) {
      _cancelLogPrint(e, url);
      if (e is DioError) {
        CancelToken.isCancel(e);
      }

      NetError error = ExceptionHandle.handleException(e);
      _onError(error.code, error.msg, onError);
    });
  }

  // Future<BaseEntity> download(
  //   String urlPath,
  //   savePath, {
  //   ProgressCallback? onReceiveProgress,
  //   Map<String, dynamic>? queryParameters,
  //   data,
  // }) async {
  //   final filePath = await getApplicationDocumentsDirectory();
  //   var file = Directory(filePath.path + "/" + savePath);
  //   try {
  //     bool exists = await file.exists();
  //     if (!exists) {
  //       await file.create();
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  //   Response response = await _dio.download(urlPath, savePath,
  //       onReceiveProgress: onReceiveProgress, queryParameters: queryParameters);
  //   try {
  //     Map<String, dynamic> _map = parseData(response.data.toString());
  //     _map[HttpConstant.responseCode] = response.statusCode.toString();
  //     _map[HttpConstant.responseMsg] = response.statusMessage ?? "";
  //
  //     return BaseEntity.fromJson(_map);
  //   } catch (e) {
  //     print(e);
  //     if (e is TypeError) {
  //       print(e.stackTrace);
  //     }
  //     return BaseEntity(ExceptionHandle.parse_error, '数据解析错误', null);
  //   }
  // }

  _cancelLogPrint(e, String url) {
    if (e is DioError && CancelToken.isCancel(e)) {
      Log.e('取消请求接口： $url');
    }
  }

  _onError(int? code, String msg, Function(int code, String mag)? onError) {
    if (code == null) {
      code = ExceptionHandle.unknown_error;
      msg = '未知异常';
    }
    Log.e('接口请求异常： code: $code, mag: $msg');
  }

  String _getMethod(Method method) {
    String m;
    switch (method) {
      case Method.get:
        m = 'GET';
        break;
      case Method.post:
        m = 'POST';
        break;
      case Method.put:
        m = 'PUT';
        break;
      case Method.patch:
        m = 'PATCH';
        break;
      case Method.delete:
        m = 'DELETE';
        break;
      case Method.head:
        m = 'HEAD';
        break;
    }
    return m;
  }
}

Map<String, dynamic> parseData(String data) {
  Map<String, dynamic> result = {};
  try {
    result = json.decode(data);
  } catch (e) {
    print(e);
  }
  return result;
}

enum Method { get, post, put, patch, delete, head }
