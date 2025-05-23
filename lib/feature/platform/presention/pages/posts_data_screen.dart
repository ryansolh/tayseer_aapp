import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:todo_apps/core/component/my_custom_buttons.dart';
import 'package:todo_apps/core/component/my_custom_image_viewer.dart';
import 'package:todo_apps/core/component/my_custom_loading.dart';
import 'package:todo_apps/core/my_extention/my_extentions.dart';
import 'package:todo_apps/feature/platform/data/editing_post_data.dart';
import 'package:todo_apps/feature/platform/data/models/post_model.dart';
import 'package:todo_apps/feature/platform/presention/management/posts_management/blog_app_cubit.dart';
import 'package:todo_apps/feature/platform/presention/management/posts_management/blog_app_state.dart';

import '../../../../core/component/my_custom_shadermask.dart';
import '../../../../core/network/remote/remote_dio.dart';
import '../../../../core/services/blog_services/posts_services.dart';
import '../../../../core/utils/app_constants/blog_app_constants.dart';
import '../management/main_page_of_platform_management/main_page_of_platform_cubit.dart';
import 'add_and_edit_post_page.dart';


class PostsDataScreen extends StatefulWidget {
  @override
  State<PostsDataScreen> createState() => _PostsDataScreenState();
}

class _PostsDataScreenState extends State<PostsDataScreen> {

final TextEditingController _commentController=TextEditingController();

bool gettingDataOfPost=false;
bool isLoadingForSendComment=false;


List<PostModel> postsData=[];

List<PostModel> parsePosts(List<dynamic> jsonList) {
  return jsonList.map((json) => PostModel.fromJson(json)).toList();
}

Future addingComment(String comment,postId)async{
  try{

    await DioHelper.post(
        url: "$baseUrl$postUrl${postId}/$commentsUrl",
        authorization: 'Bearer $token',
        data: {
          "content":comment
        }
    );
    await gettingAllPosts();
    setState(() {
      isLoadingForSendComment=false;
    });

  }catch(e){
    print(e);
  }


}

void putOrDeleteLike(int postId)async{

  //emit(SuccessfullyFetchingPost());
  try{


    var response=await DioHelper.post(
        url: baseUrl+postUrl+"${postId}/"+likeUrl,
        authorization: 'Bearer $token'
    );
    gettingAllPosts();

  }catch(e){
    // print(e);
  }

}

Future gettingAllPosts()async{
  try{

    var response=await DioHelper.get(
        url: baseUrl+apiUrl+postUrl,
        authorization: 'Bearer $token'
    );
   setState(() {
     postsData = parsePosts(response.data);
     gettingDataOfPost=true;
   });//PostModel.fromJson(response.data.map) as List<PostModel>;
    print(postsData);

    print(response);

  }catch(e){
    print(e);
  }
}
Future deletingPost(int postId)async{
  try{

     await DioHelper.delete(
        url: baseUrl+postUrl+"$postId",
        authorization: 'Bearer $token'
    );
     gettingAllPosts();
  }catch(e){
    print(e);
  }
}


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    gettingAllPosts();
  }
  @override
  Widget build(BuildContext context) {
  if(isSuccessSendPost==true){
    gettingAllPosts();
    setState(() {
      isSuccessSendPost=false;
    });
  }

   double _w= MediaQuery.of(context).size.width;
   double _h=MediaQuery.of(context).size.height;

   return RefreshIndicator(onRefresh: () async{
     await Future.delayed(
         const Duration(seconds: 1)
     );

     gettingAllPosts();
   },
     child: gettingDataOfPost==true?
     Container(
       color: Theme.of(context).colorScheme.background,
       child: Stack(
         children: [
           Padding(
             padding: const EdgeInsets.only(bottom: 50,top: 30),
             child: Container(
               color: Theme.of(context).colorScheme.background,
               child: AnimationLimiter(
                 child: ListView.builder(
                   padding: EdgeInsets.all(_w / 30),
                   physics:
                   const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                   itemCount: postsData.length,
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
                                 if(postsData[index].image!=null)
                                   SizedBox(
                                     height: _w/2,
                                     child:   CustomImageViewer.show(
                                         context: context,
                                         url: "${postsData[index].image}"
                                     ),
                                   ),
                                 if(postsData[index].image!=null)
                                   10.SH,
                                 Row(
                                   //crossAxisAlignment: CrossAxisAlignment.,
                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                   children: [
                                     PopupMenuButton<String>(
                                       shape: RoundedRectangleBorder(
                                           borderRadius: BorderRadius.all(Radius.circular(20))
                                       ),
                                       color: Theme.of(context).colorScheme.background,
                                       // color: Get.isDarkMode ? darkGreyColor : Colors.white,
                                       icon: const Icon(Icons.more_vert,color: Colors.grey,),
                                       padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                                       tooltip: "More",
                                       onSelected: (value)  {
                                         if (value == "تعديل المنشور") {
                                           setState(() {
                                             editingPostData=postsData[index];
                                             isNavigatingForEdittingPost=true;
                                           context.push(PostForm(title: "تعديل المنشور",post: editingPostData,),);
                                           });

                                         }
                                         else if (value == "حذف المنشور") {

                                           deletingPost(postsData[index].id);

                                         }else if (value == "حفظ الصورة") {
                                           setState(() {

                                           });
                                         }
                                       },
                                       itemBuilder: (BuildContext context) {

                                         return [
                                           if(postsData[index].userId==userId)
                                             const PopupMenuItem(
                                               value: "تعديل المنشور",
                                               child: Text("تعديل المنشور"),
                                             ),
                                           if(postsData[index].userId==userId)
                                             const PopupMenuItem(
                                               value: "حذف المنشور",
                                               child: Text("حذف المنشور"),
                                             ),
                                           const PopupMenuItem(
                                             value: "حفظ الصورة",
                                             child: Text("حفظ الصورة"),
                                           ),

                                         ];
                                       },
                                     ),
                                     Column(
                                       children: [
                                         IconButton(
                                             onPressed: ()async{


                                               void showCommentbottomSheet(){
                                                 showModalBottomSheet(

                                                   context: context,
                                                   builder: (BuildContext context) {
                                                     return StatefulBuilder(
                                                       builder: (BuildContext context, StateSetter setState) {
                                                         return Stack(
                                                           children: [
                                                             Padding(
                                                               padding: EdgeInsets.only(bottom: 1),
                                                               child: Container(

                                                                 color: Theme.of(context).colorScheme.background,
                                                                 height: MediaQuery.of(context).size.height-100,
                                                                 width: double.infinity,
                                                                 child: postsData[index].comments.isEmpty?Center(
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
                                                                       child: Padding(
                                                                         padding: EdgeInsets.only(bottom: 100),
                                                                         child: AnimationLimiter(
                                                                           child: ListView.builder(
                                                                             //padding: EdgeInsets.all(_w / 30),
                                                                             physics:
                                                                             const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                                                             itemCount: postsData[index].comments.length,
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

                                                                                               Text("${postsData[index].comments[indexOfComment].user.name}"),//${postsData[index].comments[indexOfComment].us}
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
                                                                                               postsData[index].comments[indexOfComment].content,
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
                                                                     ),
                                                                   ],
                                                                 ),
                                                               ),
                                                             ),
                                                             Positioned(
                                                                 bottom: 10,
                                                                 right: 0,
                                                                 left: 7,
                                                                 child: Column(
                                                                   children: [
                                                                     if(isLoadingForSendComment)
                                                                       const LinearProgressIndicator( color: Colors.blue,
                                                                         isShaderMask: true,
                                                                       ),
                                                                     Row(
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
                                                                               onPressed: () async{
                                                                                 setState((){
                                                                                   isLoadingForSendComment=true;
                                                                                 });
                                                                                 await addingComment(_commentController.text, postsData[index].id);
                                                                                 context.pop();
                                                                                 setState((){
                                                                                   _commentController.clear();
                                                                                 });
                                                                                 showCommentbottomSheet();

                                                                               },
                                                                             ),
                                                                             radius: 1.5
                                                                         )
                                                                       ],
                                                                     ),
                                                                   ],
                                                                 )
                                                             )
                                                           ],
                                                         );
                                                       },
                                                     );
                                                   },
                                                 );

                                               }
                                               showCommentbottomSheet();

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
                                               //////////اضافة  او ازالة لايك موقتا ليكون سريع في عمل لايك او ازالتة في الواجهه
                                               bool likeExists = postsData[index].likes.any((like) => like.userId == userId);
                                               if (likeExists) {
                                                 setState(() {
                                                   postsData[index].likes.removeWhere((like) => like.userId == userId);
                                                 });
                                               } else {
                                                 setState(() {
                                                   Like like= Like(
                                                       id: 2000,
                                                       userId: userId,
                                                       postId:postsData[index].id ,
                                                       createdAt: "2025-01-16T20:13:21.000000Z",
                                                       updatedAt: "2025-01-16T20:13:21.000000Z"
                                                   );
                                                   postsData[index].likes.add(like);
                                                 });
                                               }
                                               ///////////////////////////////////////////////

                                               putOrDeleteLike(postsData[index].id);

                                             },
                                             icon: postsData[index].likes.any((like) => like.userId == userId)?
                                             const Icon(Icons.favorite,color: Colors.red,)
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
           Container(
             color: Theme.of(context).colorScheme.background,
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: SizedBox(
                 height: 40,
                 child: Row(
                   children: [

                     Expanded(
                       child: MaterialButton(
                         minWidth: double.infinity,
                         height: 50,
                         onPressed: (){
                           context.push(PostForm(title: "إضافة منشور",));
                         },
                         shape: RoundedRectangleBorder(
                             side:  BorderSide(color:  Colors.grey),
                             borderRadius: BorderRadius.circular(50)),
                         child: Align(
                           alignment: Alignment.centerRight,
                           child: Text(
                             ". . .   فيما تفكر؟ ",
                             style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16,color: Colors.grey),
                           ),
                         )
                       ),
                     ),

                     MyShaderMask(
                         toolWidget:  IconButton(
                             onPressed: (){

                             },
                             icon: Icon(Icons.account_circle ,size: _h*0.035,)
                         ),
                         radius: 1.3
                     ),
                   ],
                 ),
               ),
             ),
           ),

         ],
       ),
     ):Container(
       color: Theme.of(context).colorScheme.background,
       child: Center(child: MyCustomLoading()),
     ),
   );
  }
}

























