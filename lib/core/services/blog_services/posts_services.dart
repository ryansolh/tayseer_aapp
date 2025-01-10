/*

import 'package:todo_apps/feature/platform/data/models/post_model.dart';


import '../../network/remote/remote_dio.dart';
import '../../utils/app_constants/blog_app_constants.dart';

Future <dynamic> PostAuth()async{
  DioHelper.init();
  var response=await DioHelper.get(
      url: baseUrl+postUrl,

    authorization: 'Bearer $token'
  );
  //CacheHelper().saveData(key: 'token',value: response.data['token']);
  print(response.data);

  return response.data;
}*/
