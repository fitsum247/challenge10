import 'package:flutter/material.dart';

import 'RoundedCard.dart';
class CustomText extends StatelessWidget {
  TextEditingController controller;
  String hinttext;

  CustomText({Key? key, required this.controller, required this.hinttext,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return    Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
          controller: controller,
          cursorColor: Colors.black,
          maxLines: null,
          validator: (val)=>val!.isNotEmpty?null:'',
          style: TextStyle(
              color: Colors.black
          ),
          decoration: InputDecoration(
            hintText: hinttext,
            fillColor: Colors.white,
            filled: true,
            border: InputBorder.none,
            focusedBorder:OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 2.0),
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
        ),
    );
  }
}
