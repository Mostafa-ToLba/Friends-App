
import 'package:flutter/cupertino.dart';

class MessageModel{
  String? dateTime ;
  String? SenderId;
  String? RecieverId;
  String? text;
  String? chatImage;
  String? dateOfMessage ;

  MessageModel({this.dateTime,this.SenderId,this.RecieverId,this.text,this.chatImage,this.dateOfMessage});

  MessageModel.fromJson(Map<String,dynamic>json)
  {
    dateTime=json['dateTime'];
    RecieverId=json['RecieverId'];
    SenderId=json['SenderId'];
    text=json['text'];
    chatImage=json['chatImage'];
    dateOfMessage=json['dateOfMessage'];
  }

  Map<String,dynamic>toMap()
  {
    return
      {
      'dateTime':dateTime,
      'RecieverId':RecieverId,
      'SenderId':SenderId,
      'text':text,
      'chatImage':chatImage,
      'dateOfMessage':dateOfMessage,
    };
  }

}
