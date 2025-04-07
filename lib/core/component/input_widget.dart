import 'package:flutter/material.dart';
import 'package:todo_apps/core/component/my_custom_shadermask.dart';
Widget makeInput({required BuildContext context,required double Height,double Width=double.infinity,required Size sizeOfScreen ,
  required  prefixIcon, String ?label, obscureText = false,void Function(String)? onChanged, TextEditingController? inputController,
 required String hint,  readOnly = false, rtlDirection=false, String? Function(String?)? validatorFun,prefixText='',isError=false,
  Widget? suffixIcon,
  keyboardTypeNum = false
}) {


  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const SizedBox(height: 5,),
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
      TextFormField(



        readOnly: readOnly,
        textDirection: rtlDirection==true?TextDirection.rtl:TextDirection.ltr,
        cursorColor: Theme.of(context).textTheme.labelSmall!.color,
        controller: inputController??inputController,
        obscureText: obscureText,
        style:Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: MediaQuery.of(context).size.height*0.0180,wordSpacing: 0),
        onChanged:onChanged,
        keyboardType: keyboardTypeNum==true?TextInputType.numberWithOptions() :TextInputType.emailAddress,


        decoration:suffixIcon!=null? InputDecoration(
          prefixText: prefixText,
          hintText: hint,
          hintTextDirection: TextDirection.rtl,
          prefixIcon:isError==true?ShaderMask(
            blendMode: BlendMode.srcATop,

            shaderCallback: (Rect bounds)
            {
              return  RadialGradient(
                center: Alignment.topRight,

                radius: 1.3,
                colors: const <Color>[
                  Color(0xFFCC3A3A), // أزرق داكن
                  Color(0xFFCC3A3A), // أزرق
                  Color(0xFFCC3A3A), // أزرق فاتح
                  Color(0xFFCC3A3A), // أزرق أفتح
                ],

                tileMode: TileMode.mirror,
              ).createShader(bounds);

            },
            child:prefixIcon,


          ): MyShaderMask(
            radius: 1.3,
            toolWidget: prefixIcon,
          ),

          suffixIcon:suffixIcon ,


          //contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400)
          ),
          border: OutlineInputBorder(

              borderSide: BorderSide(color: Colors.grey.shade400)
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF727070) )
          ),




        )
          :InputDecoration(
          prefixText: prefixText,
          hintText: hint,
          hintTextDirection: TextDirection.rtl,
          prefixIcon:isError==true?ShaderMask(
            blendMode: BlendMode.srcATop,

            shaderCallback: (Rect bounds)
            {
              return  RadialGradient(
                center: Alignment.topRight,

                radius: 1.3,
                colors: const <Color>[
                  Color(0xFFCC3A3A), // أزرق داكن
                  Color(0xFFCC3A3A), // أزرق
                  Color(0xFFCC3A3A), // أزرق فاتح
                  Color(0xFFCC3A3A), // أزرق أفتح
                ],

                tileMode: TileMode.mirror,
              ).createShader(bounds);

            },
            child:prefixIcon,


          ): MyShaderMask(
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
              borderSide: BorderSide(color: Color(0xFF727070) )
          ),




        ),



        validator: validatorFun

      ),
      
    ],
  );
}
