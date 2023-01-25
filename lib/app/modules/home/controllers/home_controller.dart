import 'dart:async';

import 'package:chat_gpt_02/app/data/app_constants.dart';
import 'package:chat_gpt_02/app/models/answer_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/chat_message.dart';

class HomeController extends GetxController {

  final TextEditingController textController = TextEditingController();
  final RxList<ChatMessage> messages = <ChatMessage>[].obs;

  StreamSubscription? subscription;
  RxBool isTyping = false.obs;

  @override
  void onInit() {

    super.onInit();
  }

  @override
  void onClose() {
    subscription?.cancel();
    super.onClose();
  }

  void sendMessage() {

    if (textController.text.isEmpty) return;
    ChatMessage message = ChatMessage(
      text: textController.text,
      sender: "user",
    );
      messages.insert(0, message);
      isTyping.value = true;
      apiCall(msg:textController.text.trim());
      textController.clear();


  }

  void insertNewData(String response) {
    ChatMessage botMessage = ChatMessage(
      text: response,
      sender: "bot",
    );

      isTyping.value = false;
      messages.insert(0, botMessage);

  }

  Widget buildChatTextEditor() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: textController,
              onSubmitted: (value) => sendMessage(),
              decoration: const InputDecoration.collapsed(
                  hintText: "Ask question here..."),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5, bottom: 5),
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue
            ),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white,),
              onPressed: () {
                sendMessage();
              },
            ),
          ),
        ],
      ),
    );
  }
  Dio dio = Dio();
  void apiCall({required String msg}) async{
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["authorization"] = "Bearer ${AppConstants.apiKey}";

    Map<String, dynamic> data = {
      "model": "text-davinci-003",
      "prompt": msg,
      "temperature": 0,
      "max_tokens": 200
    };

   var response = await dio.post("https://api.openai.com/v1/completions", data: data);
   AnswerModel answerModel = AnswerModel.fromJson(response.data);
    insertNewData(answerModel.choices?.first.text?.trim() ?? "" );
  }

}
