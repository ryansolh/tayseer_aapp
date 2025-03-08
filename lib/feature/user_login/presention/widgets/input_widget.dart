import 'package:flutter/material.dart';
import 'package:todo_apps/core/component/my_custom_shadermask.dart';
Widget makeInput({required BuildContext context,required double Height,double Width=double.infinity,required Size sizeOfScreen ,
  required  prefixIcon, String ?label, obscureText = false,void Function(String)? onChanged, TextEditingController? inputController,
 required String hint,  readOnly = false, rtlDirection=false
}) {

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Align(
        alignment: Alignment.bottomRight,
        child: Text(label!, style: TextStyle(
            fontSize: sizeOfScreen.height*0.018,
            fontWeight: FontWeight.w400,
            color:Theme.of(context).colorScheme.secondary
        ),
          textDirection: TextDirection.rtl,
        ),
      ),
      const SizedBox(height: 5,),
      SizedBox(
        height:Height ,
        width:Width ,
        child: TextField(

          readOnly: readOnly,
          textDirection: rtlDirection==true?TextDirection.rtl:TextDirection.ltr,
          cursorColor: Theme.of(context).textTheme.labelSmall!.color,
          controller: inputController??inputController,
          obscureText: obscureText,
          style:Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: MediaQuery.of(context).size.height*0.0180,wordSpacing: 0),
          onChanged:onChanged,

          decoration: InputDecoration(


            hintText: hint,
            hintTextDirection: TextDirection.rtl,
            prefixIcon: MyShaderMask(
              radius: 1.3,
              toolWidget: prefixIcon,
            ),
            //contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400)
            ),
            border: OutlineInputBorder(

                borderSide: BorderSide(color: Colors.grey.shade400)
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary )
            )
          ),


        ),
      ),
      
    ],
  );
}
