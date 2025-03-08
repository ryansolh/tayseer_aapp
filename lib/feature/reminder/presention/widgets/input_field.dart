import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyInputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  const MyInputField({
    super.key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Text(
            title,
            style: Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: MediaQuery.of(context).size.height*0.0190,wordSpacing: 0,),
          ),
        ),
        Container(
          height: 52,
          margin: const EdgeInsets.only(top: 5.0, bottom: 10.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize:MainAxisSize.max ,
            children: [


              widget ??
                 Container(

                   child: widget,
                 ),

              Expanded(
                child: TextFormField(
                  cursorColor: Colors.grey,
                  textDirection: TextDirection.rtl,
                  readOnly: widget != null ? true : false,
                  autofocus: false,
                  controller: controller,
                  style:Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: MediaQuery.of(context).size.height*0.0180,wordSpacing: 0),
                  decoration: InputDecoration(
                    hintTextDirection: TextDirection.rtl,
                    hintText: hint,
                    // hintStyle: subTitleStyle,
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10.0),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
