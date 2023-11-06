import 'package:flutter/material.dart';

ButtonStyle elevatedButtonstyle(){
return ElevatedButton.styleFrom(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  backgroundColor: Colors.deepOrange
);
}

InputDecoration formFieldStyle(label,hind){
  return InputDecoration(
    border: OutlineInputBorder(),
    contentPadding: EdgeInsets.only(left: 8),
    labelText: label,
    hintText: hind
  );
}

TextStyle textStyle (){
  return TextStyle(
     fontSize: 20,
     fontWeight: FontWeight.bold
  );
}