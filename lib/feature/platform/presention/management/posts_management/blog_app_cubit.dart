import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_apps/feature/platform/data/models/post_model.dart';


import 'blog_app_state.dart';

class BlogAppPostCubit extends Cubit<BlogAppPostsState> {
  BlogAppPostCubit() : super(SuccessfullyFetchingPost());


  List<PostModel> parsePosts(List<dynamic> jsonList) {
    return jsonList.map((json) => PostModel.fromJson(json)).toList();
  }

/*


 late List<PostModel> postsData=[];

Icon? likeIcon;






*/



}