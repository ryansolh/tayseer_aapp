import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:todo_apps/core/component/my_custom_image_viewer.dart';
import 'package:todo_apps/core/my_extention/my_extentions.dart';
import 'package:todo_apps/feature/platform/data/models/post_model.dart';
import 'package:todo_apps/feature/platform/presention/management/posts_management/blog_app_cubit.dart';
import 'package:todo_apps/feature/platform/presention/management/posts_management/blog_app_state.dart';

import '../../../../core/component/my_custom_shadermask.dart';
import '../../../../core/network/remote/remote_dio.dart';
import '../../../../core/services/blog_services/posts_services.dart';
import '../../../../core/utils/app_constants/blog_app_constants.dart';
import '../management/like_management/like_cubit.dart';
import '../management/like_management/like_state.dart';


class PostsPage extends StatefulWidget {
  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
final TextEditingController _commentController=TextEditingController();

List<Comment> parseComments(List<dynamic> jsonList) {
  return jsonList.map((json) => Comment.fromJson(json)).toList();
}

List<PostModel> postsData=[];

List<Comment> commentsData=[];

void addComment(String comment,postId)async{
  DioHelper.init();
  var response=await DioHelper.post(
      url: "$baseUrl$postUrl${postId}/$commentsUrl",
      authorization: 'Bearer $token',
    data: {
        "content":comment
    }
  );
  if(response.statusCode==200){
    setState(() {
      commentsData = parseComments(response.data);
    });
  }

}

  bool gettingDataOfPost=false;

bool gettingDataOfComment=false;

  @override
  Widget build(BuildContext context) {
if(gettingDataOfPost==false){
  gettingDataOfPost=true;
  BlocProvider.of<BlogAppPostCubit>(context).GettingAllPosts();
}

   double _w= MediaQuery.of(context).size.width;
   double _h=MediaQuery.of(context).size.height;

   return BlocConsumer<BlogAppPostCubit,BlogAppPostsState>(
     builder: (context,state){

       if(state is SuccessfullyFetchingPost){
         postsData= BlocProvider.of<BlogAppPostCubit>(context).postsData;
       }

       return RefreshIndicator(onRefresh: () async{
         await Future.delayed(
           const Duration(seconds: 1)
         );
         BlocProvider.of<BlogAppPostCubit>(context).GettingAllPosts();


       },
       child: state is SuccessfullyFetchingPost?
       Scaffold(
         body: Stack(
           children: [
             Padding(
               padding: const EdgeInsets.only(bottom: 50),
               child: Container(
                 color: Theme.of(context).colorScheme.background,
                 child: AnimationLimiter(
                   child: ListView.builder(
                     padding: EdgeInsets.all(_w / 30),
                     physics:
                     const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                     itemCount:state is SuccessfullyFetchingPost? postsData.length:20,
                     itemBuilder: (BuildContext context, int index) {
                       return AnimationConfiguration.staggeredList(
                         position: index,
                         delay: const Duration(milliseconds: 100),
                         child: SlideAnimation(
                           duration: const Duration(milliseconds: 2500),
                           curve: Curves.fastLinearToSlowEaseIn,
                           verticalOffset: -250,
                           child: ScaleAnimation(
                             duration: const Duration(milliseconds: 1500),
                             curve: Curves.fastLinearToSlowEaseIn,
                             child: Container(
                               padding: const EdgeInsets.all(8),
                               margin: EdgeInsets.only(bottom: _w / 25),

                               decoration: BoxDecoration(
                                 color: Colors.white,
                                 borderRadius: const BorderRadius.all(Radius.circular(10)),
                                 boxShadow: [
                                   BoxShadow(
                                     color: Colors.black.withOpacity(0.1),
                                     blurRadius: 40,
                                     spreadRadius: 10,
                                   ),
                                 ],
                               ),
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.end,
                                 children: [
                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.end,
                                     children: [
                                       Text("${postsData[index].user.name}"),
                                       // 5.SW,
                                       CircleAvatar(
                                         backgroundColor: Theme.of(context).colorScheme.background,
                                         child:const Icon(Icons.account_circle_outlined,color:Colors.grey ,) ,
                                       ),


                                     ],
                                   ),
                                   Text(
                                     "${postsData[index].content}",
                                     style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                         color: Colors.grey,
                                         fontSize: _h*0.019
                                     ),
                                     textDirection: TextDirection.rtl,
                                     textAlign: TextAlign.justify,
                                   ),
                                   10.SH,
                                   SizedBox(
                                     height: _w/2,
                                     child:   CustomImageViewer.show(
                                         context: context,
                                         url: "https://th.bing.com/th/id/R.d8ebb637bde9e2920c1a914c921c0710?rik=jztSavTaBuAXVQ&pid=ImgRaw&r=0"
                                     ),
                                   ),
                                   10.SH,
                                   Row(
                                     //crossAxisAlignment: CrossAxisAlignment.,
                                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                                     children: [
                                       IconButton(
                                           onPressed: (){

                                           },
                                           icon: const Icon(Icons.more_vert,color: CupertinoColors.inactiveGray,)
                                       ),
                                       Column(
                                         children: [
                                           IconButton(
                                               onPressed: ()async{

                                                 DioHelper.init();
                                                 var response=await DioHelper.get(
                                                     url: "$baseUrl$postUrl${postsData[index].id}/$commentsUrl",
                                                     authorization: 'Bearer $token'
                                                 );
                                                 commentsData = parseComments(response.data);



                                                 showModalBottomSheet(
                                                     shape: const RoundedRectangleBorder(borderRadius:BorderRadius.only(topLeft: Radius.circular(20),topRight:Radius.circular(20) ) ),
                                                     context: context,
                                                     builder: (context){



                                                       return Stack(
                                                         children: [
                                                           Container(

                                                             color: Theme.of(context).colorScheme.background,
                                                             height: MediaQuery.of(context).size.height-100,
                                                             width: double.infinity,
                                                             child: commentsData.isEmpty?Center(
                                                               child: Column(
                                                                 children: [
                                                                   10.SH,

                                                                   SizedBox(
                                                                     height: _h*0.03,
                                                                     child: const Center(
                                                                       child: Text('التعليقات'),
                                                                     ),
                                                                   ),
                                                                   100.SH,
                                                                   Text('!لا يوجد تعليقات',style: Theme.of(context).textTheme.labelSmall!.copyWith(color: Colors.grey),),
                                                                 ],
                                                               ),
                                                             ):Column(
                                                               children: [
                                                                 10.SH,

                                                                 SizedBox(
                                                                   height: _h*0.03,
                                                                   child: const Center(
                                                                     child: Text('التعليقات'),
                                                                   ),
                                                                 ),
                                                                 Expanded(
                                                                   child: AnimationLimiter(
                                                                     child: ListView.builder(
                                                                       //padding: EdgeInsets.all(_w / 30),
                                                                       physics:
                                                                       const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                                                       itemCount: commentsData.length,
                                                                       itemBuilder: (BuildContext context, int indexOfComment) {
                                                                         return AnimationConfiguration.staggeredList(
                                                                           position: index,
                                                                           delay: const Duration(milliseconds: 100),
                                                                           child: SlideAnimation(
                                                                             duration: const Duration(milliseconds: 2500),
                                                                             curve: Curves.fastLinearToSlowEaseIn,
                                                                             child: FadeInAnimation(
                                                                               curve: Curves.fastLinearToSlowEaseIn,
                                                                               duration: const Duration(milliseconds: 2500),
                                                                               child: Container(
                                                                                 margin: const EdgeInsets.only(bottom: 1),
                                                                                 decoration: BoxDecoration(
                                                                                   color: Colors.white,
                                                                                   boxShadow: [
                                                                                     BoxShadow(
                                                                                       color: Colors.grey.withOpacity(0.1),
                                                                                       blurRadius: 40,
                                                                                       spreadRadius: 10,
                                                                                     ),
                                                                                   ],
                                                                                 ),
                                                                                 child: Column(
                                                                                   crossAxisAlignment: CrossAxisAlignment.end,
                                                                                   children: [

                                                                                     Row(
                                                                                       mainAxisAlignment: MainAxisAlignment.end,
                                                                                       children: [

                                                                                         Text("${commentsData[indexOfComment].user.name}"),//${postsData[index].comments[indexOfComment].us}
                                                                                         // 5.SW,
                                                                                         CircleAvatar(
                                                                                           backgroundColor: Theme.of(context).colorScheme.background,
                                                                                           child:const Icon(Icons.account_circle_outlined,color:Colors.grey ,) ,
                                                                                         ),


                                                                                       ],
                                                                                     ),
                                                                                     Padding(
                                                                                       padding: const EdgeInsets.only(right: 30),
                                                                                       child: Text(
                                                                                         commentsData[indexOfComment].content,
                                                                                         style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                                                                             color: Colors.grey,
                                                                                             fontSize: _h*0.015
                                                                                         ),
                                                                                         textDirection: TextDirection.rtl,
                                                                                         textAlign: TextAlign.justify,
                                                                                       ),
                                                                                     ),
                                                                                     5.SH

                                                                                   ],
                                                                                 ),
                                                                               ),
                                                                             ),
                                                                           ),
                                                                         );
                                                                       },
                                                                     ),
                                                                   ),
                                                                 ),
                                                               ],
                                                             ),
                                                           ),
                                                           Positioned(
                                                               bottom: 10,
                                                               right: 0,
                                                               left: 7,
                                                               child: Row(
                                                                 children: [
                                                                   Expanded(
                                                                     flex: 15,
                                                                     child: TextFormField(

                                                                       controller: _commentController,

                                                                       //textDirection: TextDirection.rtl,
                                                                       textAlign: TextAlign.right,
                                                                       decoration: InputDecoration(
                                                                         filled: true,
                                                                         fillColor: Theme.of(context).colorScheme.secondary.withAlpha(24),
                                                                         border: OutlineInputBorder(
                                                                           borderRadius: BorderRadius.circular(25),
                                                                           borderSide: BorderSide.none,
                                                                         ),
                                                                         hintText: "...قم بكتابة تعليقك",
                                                                         contentPadding: const EdgeInsets.symmetric(
                                                                             horizontal: 20, vertical: 15),
                                                                       ),
                                                                       validator: (value) {
                                                                         //_scrollToBottom();
                                                                         if(value!.isEmpty ){
                                                                           return 'يجب تعبئة الحقل';
                                                                         }

                                                                       },
                                                                     ),
                                                                   ),
                                                                   const Spacer(),
                                                                   MyShaderMask(
                                                                       toolWidget: IconButton(
                                                                         padding: const EdgeInsets.all(15),
                                                                         iconSize: 30,
                                                                         splashRadius: 25,
                                                                         //color: MyTheme.primaryColor,
                                                                         icon: const Icon(Icons.send, color: Colors.black),
                                                                         onPressed: () {
                                                                           addComment(_commentController.text, postsData[index].id);
                                                                         },
                                                                       ),
                                                                       radius: 1.5
                                                                   )
                                                                 ],
                                                               )
                                                           )
                                                         ],
                                                       );
                                                     }
                                                 );


                                               },
                                               icon: const Icon(Icons.comment_outlined,color: CupertinoColors.inactiveGray,)
                                           ),
                                           3.SH,
                                           Text(
                                             "${postsData[index].comments.length}",
                                             style: Theme.of(context).textTheme.labelSmall!.copyWith(fontSize:_h*0.015),
                                           )
                                         ],
                                       ),
                             Column(
                               children: [

                                 IconButton(
                                     onPressed: (){

                                       setState(() {
                                         BlocProvider.of<BlogAppPostCubit>(context).putOrDeleteLike(postsData[index].id);
                                       });
                                     },
                                     icon: state is SuccessfullyFetchingPost?
                               postsData[index].likes.any((like) => like.userId == userId)? const Icon(Icons.favorite,color: Colors.red,)
                             :const Icon(Icons.favorite_border,color: CupertinoColors.inactiveGray,):
                                     postsData[index].likes.any((like) => like.userId == userId)? const Icon(Icons.favorite,color: Colors.red,)
                                         :const Icon(Icons.favorite_border,color: CupertinoColors.inactiveGray,)
                                 ),
                                 3.SH,
                                 Text(
                                   "${postsData[index].likes.length}",
                                   style: Theme.of(context).textTheme.labelSmall!.copyWith(fontSize:_h*0.015),
                                 )
                               ],
                             ),


                                     ],
                                   )
                                 ],
                               ),
                             ),
                           ),
                         ),
                       );
                     },
                   ),
                 ),
               ),
             ),

           ],
         ),
       ):Container(
         color: Theme.of(context).colorScheme.background,
         child: const Center(child: CircularProgressIndicator(color: Colors.blue,)),
       ),
          );
     },listener: (context,state){

   },
   );
  }
}

























