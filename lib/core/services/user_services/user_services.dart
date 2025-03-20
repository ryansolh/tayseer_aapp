//
// import 'package:todo_apps/core/utils/app_constants/blog_app_constants.dart';
//
// import '../../../cache/cache_helper.dart';
// import '../../network/remote/remote_dio.dart';
//
// Future <dynamic> SignUpAuth(String name,String email,String pass)async{
//   DioHelper.init();
//   var response=await DioHelper.post(
//       url: baseUrl+signUpUrl,
//     data: {
//       "name":name,
//       "email":email,
//       "password":pass,
//       "password_confirmation":pass
//     }
//   );
//   //CacheHelper().saveData(key: 'token',value: response.data['token']);
//   print('////////////////////////////');
//
//   print(response.statusCode);
//   return response;
// }
//
//
//
// Future <dynamic> LoginAuth( email,String pass)async{
//   DioHelper.init();
//   var response=await DioHelper.post(
//       url: baseUrl+loginUrl,
//       data: {
//         "email":email,
//         "password":pass,
//       }
//   );
//   //CacheHelper().saveData(key: 'token',value: response.data['token']);
//   print(response.statusCode);
//   return response;
// }