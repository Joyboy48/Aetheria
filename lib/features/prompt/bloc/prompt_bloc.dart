import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:ai_integration/features/prompt/repos/prompt_repos.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

part 'prompt_event.dart';
part 'prompt_state.dart';

class PromptBloc extends Bloc<PromptEvent, PromptState> {
  PromptBloc() : super(PromptInitial()) {
    on<PromptEnteredEvent>(promptEnteredEvent);
    on<PromptInitialEvent>(promptInitialEvent);
  }

  FutureOr<void> promptEnteredEvent(
      PromptEnteredEvent event, Emitter<PromptState> emit) async {
    emit(PromptGeneratingImageLoadingState());
     Uint8List? bytes = await PromptRepo.generateImage(event.prompt);
     if(bytes!=null){
       emit(PromptGeneratingImageSuccessState(uint8list: bytes));
     }else{
       emit(PromptGeneratingImageErrorState());
     }

  }

  // FutureOr<void> promptInitialEvent(
  //     PromptInitialEvent event, Emitter<PromptState> emit) async {
  //   Uint8List bytes = await File(
  //       '/Users/astit/OneDrive/Desktop/flutter projects/ai_integration/assets/imageeee.png').readAsBytes();
  //   emit(PromptGeneratingImageSuccessState(uint8list:bytes));
  //
  // }

  FutureOr<void> promptInitialEvent(
      PromptInitialEvent event, Emitter<PromptState> emit) async {
    final ByteData bytes = await rootBundle.load('assets/imageeee.png');
    final Uint8List uint8List = bytes.buffer.asUint8List();
    emit(PromptGeneratingImageSuccessState(uint8list: uint8List));
  }
    

}
