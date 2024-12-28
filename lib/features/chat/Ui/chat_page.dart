import 'package:ai_integration/features/chat/bloc/chat_bloc.dart';
import 'package:ai_integration/features/chat/models/chat_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../prompt/ui/create_prompt_screen.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatBloc chatBloc = ChatBloc();
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ChatBloc,ChatState>(
        bloc: chatBloc,
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    switch(state.runtimeType){
      case ChatSucessState:
        List<ChatMessageModel> messages = (state as ChatSucessState).messages;
        return Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: BoxDecoration(
              image: DecorationImage(
                  opacity: 0.5,
                  image: AssetImage("assets/bgImage1.png"),
                  fit: BoxFit.cover)
          ),
          child: Column(
            children: [
              SizedBox(height: 20,),
              Container(height: 120,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //SizedBox(height: 50,),
                          Text('Aetheria :',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                          Text('The AI Guardian Spirit',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                        ]),
                    GestureDetector(
                        onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePromptScreen())),
                        child: Icon(Icons.image_search,color: Colors.white,size: 35,))
                  ],
                ),
              ),
              Expanded(child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context,index){
                return Container(
                  margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white.withOpacity(0.1),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(messages[index].role == "user" ? "User" : "Aetheria",style: TextStyle(fontSize:16,),),
                          SizedBox(height: 12,),
                          Text(messages[index].parts.first.text,style: TextStyle(fontSize: 20,height: 1.5),)

                        ]));
              })),
               if(chatBloc.generating)
                 Row(
                   children: [
                     Container(
                       height: 100,
                         width: 100,
                         child: Lottie.asset('assets/loading1.json')),
                     SizedBox(width: 10,),
                     Text("Generating Response...",style: TextStyle(fontSize: 20),)
                   ],
                 ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 30,horizontal: 16),
                child: Row(children: [
                  Expanded(child: TextField(
                    controller: textEditingController,
                    style: TextStyle(color: Colors.white,),
                    cursorColor: Colors.white,

                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        fillColor: Colors.transparent,
                        filled: true,
                        hintText: "Ask Anything from Aetheria",
                        hintStyle: TextStyle(
                          color: Colors.white
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(
                                color: Colors.white
                            ))),)),
                  SizedBox(width: 12,),
                  InkWell(
                    onTap: (){
                      if(textEditingController.text.isNotEmpty){
                        String text = textEditingController.text;
                        textEditingController.clear();
                        chatBloc.add(TextGenerateNewTextMessageEvent(inputMessage: text));
                      }
                    },
                    child: CircleAvatar(
                        radius: 25,backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 23,backgroundColor: Theme.of(context).primaryColor,
                          child: Center(child: Icon(Icons.send,color: Colors.white,),),
                        )
                    ),
                  )
                ],),
              ),
            ],
          ),
        );
      default:
        return SizedBox();
    }
  },
),
    );
  }
}
