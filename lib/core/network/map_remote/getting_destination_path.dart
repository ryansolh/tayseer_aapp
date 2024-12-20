import 'package:dio/dio.dart';


class DioHelper_map {
  static late Dio? dio_map;

  static init() {
    dio_map = Dio(
      BaseOptions(
        baseUrl: '',
        receiveDataWhenStatusError: true,
      ),
    );

    dio_map?.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException error, handler) async {
          if (error.response?.statusCode == 401) {
            print('تم تسجيل الخروج من التطبيق');
            /*  ToastManager.showToast('تم تسجيل الخروج من التطبيق ', ToastStates.ERROR);
            CacheHelper.removeData(key: 'token');
            Get.offAll(LoginScreen());*/
          }
          return handler.next(error);
        },
      ),
    );


    dio_map?.interceptors.add(LogInterceptor(
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
    dio_map!.options.headers = {
      'Accept': 'application/json ',
      'Authorization': authorization
    };
    return await dio_map!.get(
      url,
      queryParameters: queryParameters,
    );
  }







}