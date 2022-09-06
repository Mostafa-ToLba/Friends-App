import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_5.dart';
import 'package:mostafa1/layout/socialapp-layout/socialCubit/socialCubit.dart';
import 'package:mostafa1/layout/socialapp-layout/socialCubit/socialCubitStates.dart';
import 'package:mostafa1/model/Social-model/messageModel.dart';
import 'package:mostafa1/model/Social-model/social-userModel.dart';
import 'package:mostafa1/modules/social-app/PhotoChatOpen/photoChatOpenScreen.dart';
import 'package:mostafa1/modules/social-app/Profile/profileScreen.dart';
import 'package:mostafa1/shared/components/components.dart';
import 'package:mostafa1/shared/styles/IconBroken.dart';

class NewChat extends StatelessWidget {
  socialUserModel model ;
  var now = DateTime.now();
  var messageController = TextEditingController();
  NewChat({ required this.model, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Builder(
        builder: (context) {
          SocialCubit.get(context).getMessage(recieverId:model.uId);
          return BlocConsumer<SocialCubit,SocialCubitStates>(
            listener: (BuildContext context, state) {  },
            builder: (BuildContext context, Object? state) {
              return  Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(

                  title: InkWell(
                    onTap: ()
                    {
                      SocialCubit.get(context).getProfilePosts(model.uId);
                      NavigateTo(context, ProfileScreen('',model,model.name,model.image,model.bio!,model.phone!,model.cover!,model.uId!,));
                    },
                    child: Row(
                      children:
                      [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage('${model.image}'),
                        ),
                        SizedBox(width: 10,),
                        Text('${model.name}',style: TextStyle(fontSize: 20,),),
                      ],
                    ),
                  ),
                ),
                body: StreamBuilder(
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot)
                  {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              reverse: true,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context,index)
                                {
                                  var message =SocialCubit.get(context).Messages[index];
                                  if(SocialCubit.get(context).socialModel!.uId==message.SenderId){
                                    if(message.chatImage!='')
                                      return photoContainer(message,context);
                                    return IMessage(message,context);
                                  }
                                  else {
                                    if (message.chatImage != '')
                                      return photoContainer(message,context);
                                    return ImyMessage(message,context);
                                  }
                                },
                          //      separatorBuilder: (context,index)=>SizedBox(height: 3),
                                itemCount: SocialCubit.get(context).Messages.length),

                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                                border: Border.all(color: Colors.grey[300]!,)
                            ),
                            child: Row(
                              children: [
                                IconButton(onPressed: ()
                                {
                                  SocialCubit.get(context).getChatImage();

                                }, icon: Icon(IconBroken.Image)),
                                Expanded(
                                  child: TextFormField(
                                    controller:messageController,
                                    decoration:
                                    InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                                        hintText: 'Type your message',
                                        border:InputBorder.none
                                    ),
                                  ),
                                ),
                                MaterialButton(
                                  onPressed: ()
                                  {
                                    if(SocialCubit.get(context).chatImage!=null)
                                    {
                                      SocialCubit.get(context).uploadChatImageAndSendMessage(text:messageController.text
                                          ,recieverId:model.uId! );
                                      SocialCubit.get(context).SendNotificationToSomeOne(content:'sent an image',playerIds:[model.osUserID],heading:SocialCubit.get(context).socialModel!.name );
                                      SocialCubit.get(context).chatImage =null;
                                    }
                                    else
                                    {
                                      SocialCubit.get(context).SendMessage(recieverId:model.uId!,text: messageController.text,chatImage: '');
                                      SocialCubit.get(context).SendNotificationToSomeOne(content:messageController.text,playerIds:[model.osUserID],heading:SocialCubit.get(context).socialModel!.name );
                                      messageController.clear();
                                    }

                                  },child: Icon(Icons.send,color: Colors.black,),)
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  stream: SocialCubit.get(context).getStreamMessage(),
                ),
                    /*
                ConditionalBuilder(
                  condition: true,
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context,index)
                                {
                                  var message =SocialCubit.get(context).Messages[index];
                                  if(SocialCubit.get(context).socialModel!.uId==message.SenderId){
                                    if(message.chatImage!='')
                                      return photoContainer(message,context);
                                    return IMessage(message,context);
                                  }
                                  else {
                                    if (message.chatImage != '')
                                      return photoContainer(message,context);
                                    return ImyMessage(message,context);
                                  }
                                },
                                separatorBuilder: (context,index)=>SizedBox(height: 3),
                                itemCount: SocialCubit.get(context).Messages.length),

                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                                border: Border.all(color: Colors.grey[300]!,)
                            ),
                            child: Row(
                              children: [
                                IconButton(onPressed: ()
                                {
                                  SocialCubit.get(context).getChatImage();

                                }, icon: Icon(IconBroken.Image)),
                                Expanded(
                                  child: TextFormField(
                                    controller:messageController,
                                    decoration:
                                    InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                                        hintText: 'Type your message',
                                        border:InputBorder.none
                                    ),
                                  ),
                                ),
                                MaterialButton(
                                  onPressed: ()
                                  {
                                    if(SocialCubit.get(context).chatImage!=null)
                                    {
                                      SocialCubit.get(context).uploadChatImageAndSendMessage(text:messageController.text
                                          ,recieverId:model.uId! );
                                      SocialCubit.get(context).SendNotificationToSomeOne(content:'sent an image',playerIds:[model.osUserID],heading:SocialCubit.get(context).socialModel!.name );
                                      SocialCubit.get(context).chatImage =null;
                                    }
                                    else
                                    {
                                      SocialCubit.get(context).SendMessage(recieverId:model.uId!,text: messageController.text,chatImage: '');
                                      SocialCubit.get(context).SendNotificationToSomeOne(content:messageController.text,playerIds:[model.osUserID],heading:SocialCubit.get(context).socialModel!.name );
                                      messageController.clear();
                                    }

                                  },child: Icon(Icons.send,color: Colors.black,),)
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  fallback:(BuildContext context)=>Center(child: CircularProgressIndicator()),

                ),

                     */
              );
            },
          );
        }
    );
  }
  Widget Message(MessageModel message)=>Align(
    alignment: AlignmentDirectional.topEnd,
    child: Container(
        padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadiusDirectional.only(
            topEnd:Radius.circular(10,),
            topStart: Radius.circular(10,),
            bottomStart: Radius.circular(10,),
          ),
        ),
        child: Text(
          '${message.text}',
          style: TextStyle(color:Colors.white,fontSize: 18,fontWeight:FontWeight.w600,fontFamily: 'Megrim' ),)),
  );
  Widget myMessage(MessageModel message)=>Align(
    alignment: AlignmentDirectional.topStart,
    child: Container(
        padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadiusDirectional.only(topEnd:Radius.circular(10,),
            bottomEnd: Radius.circular(10,),
            topStart: Radius.circular(10,),
          ),
        ),
        child: Text(
          '${message.text}',
          style: TextStyle(fontSize: 18,fontWeight:FontWeight.w600,fontFamily: 'Megrim' ),)),
  );

  Widget IMessage(MessageModel message,context)=>ChatBubble(
    backGroundColor: Colors.green,
    alignment: Alignment.topRight,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 6),
          child: Text(
            '${message.text}',
            style: TextStyle(color:Colors.white,fontFamily: 'Megrim' ,fontSize: 16,fontWeight:FontWeight.w600),),
        ),
        Text(
          '${message.dateOfMessage}',
          style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.grey[300]),)
      ],
    ),
    clipper: ChatBubbleClipper5(type: BubbleType.sendBubble,),
  ) ;
  Widget ImyMessage(MessageModel message,context)=>ChatBubble(
    backGroundColor: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 6),
          child: Text(
            '${message.text}',
            style: TextStyle(color:Colors.black,fontFamily: 'Megrim' ,fontSize: 16,fontWeight:FontWeight.w600),),
        ),
        Text(
          '${message.dateOfMessage}',
          style: Theme.of(context).textTheme.caption,)
      ],
    ),
    clipper: ChatBubbleClipper5(type: BubbleType.receiverBubble),
  );
  Widget photoContainer(MessageModel message,context)=>Expanded(
    child: InkWell(
      onTap: ()
      {
        NavigateTo(context, SocialPhotoChatOpen(message.chatImage!));
      },
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(borderRadius:BorderRadius.circular(15) ),
        child: Image(image: NetworkImage('${message.chatImage}'),),
      ),
    ),
  );


}
