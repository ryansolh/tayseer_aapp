import 'package:dio/dio.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../../../feature/user_login/presention/pages/login_screen.dart';
import '../../utils/app_constants/blog_app_constants.dart';


class DioHelper {
  static late Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        receiveDataWhenStatusError: true,
        baseUrl: baseUrl+apiUrl,

      ),
    );

    dio?.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException error, handler) async {
          if (error.response?.statusCode == 401) {
            print('تم تسجيل الخروج من التطبيق');
           // CacheHelper.removeData(key: 'token');
           // Get.offAll(SignUp());
          /*  ToastManager.showToast('تم تسجيل الخروج من التطبيق ', ToastStates.ERROR);
            CacheHelper.removeData(key: 'token');
            Get.offAll(LoginScreen());*/
          }
          return handler.next(error);
        },
      ),
    );


    dio?.interceptors.add(LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true));
  }


  static Future<Response<dynamic>> get({
    required String url,
    Map<String, dynamic>? queryParameters,
    String? authorization,
  }) async {
    dio!.options.headers = {
      'Accept': 'application/json ',
      'Authorization': authorization
    };
    return await dio!.get(
      url,
      queryParameters: queryParameters,
    );
  }


  static Future<Response<dynamic>> post({
    required String url,
    Object? data,
    Map<String, dynamic>? queryParameters,
    String? authorization,
  }) async {
    dio!.options.headers = {
      'Accept': 'application/json',
      'Authorization': authorization,
    };
    return await dio!.post(
      url,
      data: data,
      queryParameters: queryParameters,
    );
  }

  
  static Future<Response<dynamic>> put({
    required String url,
    Object? data,
    Map<String, dynamic>? queryParameters,
    String? authorization,
  }) async {
    dio!.options.headers = {
      'Accept': 'application/json',
      'Authorization': authorization
      // 'Content-Type' : 'application/json',
    };
    return await dio!.put(
      url,
      data: data,
      queryParameters: queryParameters,
    );
  }

  static Future<Response<dynamic>> delete({
    required String url,
    Object? data,
    Map<String, dynamic>? queryParameters,
    String? authorization,
  }) async {
    dio!.options.headers = {
      'Accept': 'application/json',
      'Authorization': authorization,
    };
    return await dio!.delete(
      url,
      data: data,
      queryParameters: queryParameters,
    );
  }
}