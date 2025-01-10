import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:todo_apps/feature/platform/data/models/post_model.dart';

import '../../../../../core/network/remote/remote_dio.dart';
import '../../../../../core/utils/app_constants/blog_app_constants.dart';
import 'blog_app_state.dart';

class BlogAppPostCubit extends Cubit<BlogAppPostsState> {
  BlogAppPostCubit() : super(SuccessfullyFetchingPost());


  List<PostModel> parsePosts(List<dynamic> jsonList) {
    return jsonList.map((json) => PostModel.fromJson(json)).toList();
  }



 late List<PostModel> postsData=[];



  void GettingAllPosts()async{
   try{
     DioHelper.init();
     var response=await DioHelper.get(
         url: baseUrl+postUrl,
         authorization: 'Bearer $token'
     );
     postsData = parsePosts(response.data);//PostModel.fromJson(response.data.map) as List<PostModel>;
     print(postsData);
     emit(SuccessfullyFetchingPost());

   }catch(e){
    // print(e);
   }
  }


}