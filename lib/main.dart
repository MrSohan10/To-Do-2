import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app2/screen/home_page.dart';

void main(){
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: "To Do App",
      home: HomePage(),

    );
  }
}
