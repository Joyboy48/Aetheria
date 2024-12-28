import 'dart:developer';
//import 'dart:js_interop';

import 'package:ai_integration/constants.dart';
import 'package:ai_integration/features/chat/models/chat_model.dart';
import 'package:dio/dio.dart';

class Chatrepo{

  static Future<String> chatTextGenerationRepo(List<ChatMessageModel> previousMessage) async{
    try{
      Dio dio = Dio();

      final response = await dio.post("https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-pro:generateContent?key=${gemini_api_key}",
          data: {
            "contents": previousMessage.map((e)=>e.toMap()).toList(),
            "generationConfig": {
              "temperature": 1,
              "topK": 40,
              "topP": 0.95,
              "maxOutputTokens": 8192,
              "responseMimeType": "text/plain"
            }
          }
      );
      if(response.statusCode !>= 200 && response.statusCode !< 300){
        return response.data['candidates'].first['content']['parts'].first['text'];
      }else {
        // Return an error message or an empty string if the request fails
        return "Error: ${response.statusCode} - ${response.statusMessage}";
      }
    }catch(e){
      log(e.toString());
      return "Error: ${e.toString()}";
    }
  }

}