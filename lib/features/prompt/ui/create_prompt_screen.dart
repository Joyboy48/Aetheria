import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/prompt_bloc.dart';

class CreatePromptScreen extends StatefulWidget {
  const CreatePromptScreen({super.key});

  @override
  State<CreatePromptScreen> createState() => _CreatePromptScreenState();
}

class _CreatePromptScreenState extends State<CreatePromptScreen> {

  final PromptBloc promptBloc = PromptBloc();

  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    promptBloc.add(PromptInitialEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Generate Images 🖼️",),
        centerTitle: true,
      ),
      body: BlocConsumer<PromptBloc, PromptState>(
        bloc: promptBloc,
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    switch(state.runtimeType){
      case PromptGeneratingImageLoadingState:
        return Center(
          child: CircularProgressIndicator(),
        );
      case PromptGeneratingImageErrorState:
        return Center(child: Text('Something went Wrong'),);
      case PromptGeneratingImageSuccessState:
        final succcessState = state as PromptGeneratingImageSuccessState;
        return Container(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: MemoryImage(succcessState.uint8list)),
                ),
              ),),
              Container(
                height: 250,
                padding: EdgeInsets.all(24),
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Enter your prompt",style:TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                    SizedBox(height: 24,),
                    TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 24,),

                    ElevatedButton(onPressed: (){
                      if(controller.text.isNotEmpty){
                        promptBloc.add(PromptEnteredEvent(prompt: controller.text));
                      }
                    }, child: Padding(padding: EdgeInsets.all(20),
                      child: Text("Generate image",style: TextStyle(color: Colors.white,),),))
                  ],
                ),
              )
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
