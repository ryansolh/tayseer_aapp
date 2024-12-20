import 'package:flutter/material.dart';
Widget makeInput({required BuildContext context,required double Height,double Width=double.infinity,required Size sizeOfScreen ,
  String ?label, obscureText = false,void Function(String)? onChanged,required TextEditingController? inputController }) {

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(label!, style: TextStyle(
          fontSize: sizeOfScreen.height*0.019,
          fontWeight: FontWeight.w400,
          color:Theme.of(context).colorScheme.secondary
      ),),
      const SizedBox(height: 5,),
      SizedBox(
        height:Height ,
        width:Width ,
        child: TextField(

          cursorColor: Colors.grey.shade400,
          controller: inputController,
          obscureText: obscureText,
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          onChanged:onChanged,

          decoration: InputDecoration(

            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
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
