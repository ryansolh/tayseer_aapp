import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_apps/core/component/my_custom_buttons.dart';
import 'package:http/http.dart' as http;
import 'package:todo_apps/core/component/my_custom_loading.dart';
import 'package:todo_apps/core/my_extention/my_extentions.dart';
import 'package:todo_apps/core/services/blog_services/posts_services.dart';

import '../../../../core/component/my_custom_linear_gradient.dart';
import '../../../../core/services/confirmed_app_message_sevice/snakbar_message_sevice.dart';
import '../../../../core/utils/app_constants/blog_app_constants.dart';
import '../../data/models/post_model.dart';


class PostForm extends StatefulWidget {
  final PostModel? post;
  final String? title;

  PostForm({
    this.post,
    this.title
  });

  @override
  _PostFormState createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _txtControllerBody = TextEditingController();
  bool _loading = false;
  File? _imageFile;
  final _picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null){
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }
  String? getStringImage(File? file) {

    if (file == null) return null ;
    return base64Encode(file.readAsBytesSync());
  }

  Future _createPost() async {
    // final imageRequest=await convertImageToBase64(_imageFile!);
    try{
      showDialog(
          context: context,
          builder: (BuildContext context){
            return Container(
              color: Color(0x00000000),
              child: Center(
                child: MyCustomLoading(),
              ),
            );
          }
      );
      final request = http.MultipartRequest('POST', Uri.parse("$baseUrl$postUrl"));
      request.headers['authorization']='Bearer $token';
      request.fields['content']=_txtControllerBody.text;
      request.files.add(await http.MultipartFile.fromPath('image', _imageFile!.path));
      var response=await request.send();
     if(response.statusCode==200||response.statusCode==201){
       context.pop();
       showCustomSnackbar(title: ".تم نشر المنشور", subTitle: "تم انشاء ونشر المنشور الخاص بك بنجاح.");
       setState(() {
         isSuccessSendPost=true;
       });
       context.pop();
     }

      print("/////////////////");
      print(response.statusCode);
      print("/////////////////");
    }catch(e){
      print(e);
    }

  }

  // edit post
  void _editPost(int postId) async {

  }

  @override
  void initState() {
    if(widget.post != null){
      _txtControllerBody.text = widget.post!.content ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("${widget.title}",
            style: TextStyle(color: Colors.white, fontFamily: 'Tajawal', fontWeight: FontWeight.bold,),),
          leading: Container(),
          actions: [IconButton(onPressed: (){context.pop();}, icon: Icon(Icons.chevron_right_sharp,size: 40,color: Colors.white,))],
          flexibleSpace:
          Container(
            decoration:  BoxDecoration(
              gradient:MyLinearGradient,
            ),
          ),

        ),
        body:_loading ? Center(child: MyCustomLoading(),) :  ListView(
          children: [
            widget.post != null ? SizedBox() :
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: BoxDecoration(
                  image: _imageFile == null ? null : DecorationImage(
                      image: FileImage(_imageFile ?? File('')),
                      fit: BoxFit.cover
                  )
              ),
              child: Center(
                child: IconButton(
                  icon: Icon(Icons.image, size:50, color: Colors.black38),
                  onPressed: (){
                    getImage();
                  },
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: TextFormField(

                  cursorColor: Colors.grey,
                  textDirection: TextDirection.rtl,
                  controller: _txtControllerBody,
                  keyboardType: TextInputType.multiline,
                  maxLines: 9,
                  validator: (val) => val!.isEmpty ? 'Post body is required' : null,
                  decoration: InputDecoration(
                      hintText: "Post body...",
                      border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.grey),)
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30,right: 30,top: 30),
              child: MyButtonWithBackground(
                  context: context,
                  textButton: "نشر",
                  onPressed: (){
                    _createPost();
                  }
              ),
            )
          ],
        ),
      ),
    );
  }
}