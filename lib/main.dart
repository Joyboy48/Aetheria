import 'package:ai_integration/features/chat/Ui/chat_page.dart';
import 'package:ai_integration/features/prompt/ui/create_prompt_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Orbitron',
        scaffoldBackgroundColor: Colors.grey.shade900
      ),
      home: ChatPage(),
    );
  }
}
