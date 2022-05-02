import 'package:flutter/material.dart';
class SearchTextFiled extends StatelessWidget {
  TextEditingController controller;
  String hinttext;
   SearchTextFiled({Key? key,required this.controller, required this.hinttext,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return    TextFormField(
      controller: controller,
      cursorColor: Colors.black,
      maxLines: null,
      validator: (val)=>val!.isNotEmpty?null:'',
      style: TextStyle(
          color: Colors.black
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search,color: Colors.grey,size: 20,),
        hintText: hinttext,
        fillColor: Colors.white,
        filled: true,
        border: InputBorder.none,
        enabled: true,
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 2.0),
          borderRadius: BorderRadius.circular(25.0),),
        focusedBorder:OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 2.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }
}
