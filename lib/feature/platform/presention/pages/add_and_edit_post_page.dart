import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_apps/core/component/my_custom_buttons.dart';
import 'package:http/http.dart' as http;

import '../../../../core/network/remote/remote_dio.dart';
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
      final request = http.MultipartRequest('POST', Uri.parse("$baseUrl$postUrl"));
      request.headers['authorization']='Bearer $token';
      request.fields['content']=_txtControllerBody.text;
      request.files.add(await http.MultipartFile.fromPath('image', _imageFile!.path));
      var response=await request.send();
      /*DioHelper.init();
      var response= await DioHelper.post(
          url: "$baseUrl$postUrl",
          authorization: 'Bearer $token',
          data: {
            "content":_txtControllerBody.text,
            "image":base64Image
          }

      );*/
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
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.title}'),
      ),
      body:_loading ? Center(child: CircularProgressIndicator(),) :  ListView(
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
            padding: EdgeInsets.symmetric(horizontal: 8),
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
    );
  }
}