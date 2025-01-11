//
//
// import 'package:bloc/bloc.dart';
//
// import '../../../../../core/network/remote/remote_dio.dart';
// import '../../../../../core/utils/app_constants/blog_app_constants.dart';
// import '../../../data/models/post_model.dart';
// import 'like_state.dart';
//
// class BlogAppLikeCubit extends Cubit<BlogAppLikeState> {
//   BlogAppLikeCubit() : super(SuccessfullyPutOrDeleteLike());
//
//
//
//
//
//
//
//
//
//   void putOrDeleteLike(int postId)async{
//     try{
//       DioHelper.init();
//       var response=await DioHelper.post(
//           url: baseUrl+postUrl+"${postId}/"+likeUrl,
//           authorization: 'Bearer $token'
//       );
//
//       emit(SuccessfullyPutOrDeleteLike());
//
//     }catch(e){
//       // print(e);
//     }
//   }
//
//
// }
//
//
