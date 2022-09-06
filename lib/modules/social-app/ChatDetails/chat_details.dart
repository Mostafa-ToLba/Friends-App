
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

 class ChatDetailsScreen extends StatefulWidget {
  socialUserModel model ;

    ChatDetailsScreen({ required this.model, Key? key}) : super(key: key);

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}



class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
   @override
  void didChangeDependencies() {
     SocialCubit.get(context).Emit();
    super.didChangeDependencies();
  }
  var now = DateTime.now();

  var messageController = TextEditingController();

   @override
   Widget build(BuildContext context) {

     return Builder(
       builder: (context) {
         SocialCubit.get(context).getMessage(recieverId:widget.model.uId);
         return BlocConsumer<SocialCubit,SocialCubitStates>(
           listener: (BuildContext context, state) {  },
           builder: (BuildContext context, Object? state) {
             return  Scaffold(
               backgroundColor: Colors.black26,
               appBar: AppBar(
                 systemOverlayStyle: SystemUiOverlayStyle(
                   statusBarColor: Colors.black,
                   statusBarIconBrightness: Brightness.light,

                 ),
                 leading: IconButton(icon: Icon(IconBroken.Arrow___Left_2), onPressed: ()
                 {
                   SocialCubit.get(context).chatImage=null;
                   Navigator.pop(context);
                 },color: Colors.white,),
                    backgroundColor: Colors.black,
                 elevation: .5,
                 title: InkWell(
                   onTap: ()
                   {
                     SocialCubit.get(context).getProfilePosts(widget.model.uId);
                     NavigateTo(context, ProfileScreen('',widget.model,widget.model.name,widget.model.image,widget.model.bio!,widget.model.phone!,widget.model.cover!,widget.model.uId!,));
                   },
                   child: Row(
                     children:
                     [
                       CircleAvatar(
                         radius: 20,
                         backgroundImage: NetworkImage('${widget.model.image}'),
                       ),
                       SizedBox(width: 10,),
                       Text('${widget.model.name}',style: TextStyle(fontSize: 18,color: Colors.white),),
                     ],
                   ),
                 ),
                 shadowColor: Colors.white,
               ),
               body: Container(
                 decoration: BoxDecoration(
                   image: DecorationImage(image: NetworkImage('',),
                   fit: BoxFit.cover)
                 ),
                 child: ConditionalBuilder(
                   condition: true,
                   builder: (BuildContext context) {
                     return Padding(
                       padding: const EdgeInsets.all(20.0),
                       child: Column(
                         children: [
                           Expanded(
                             child: ListView.separated(
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
                                 separatorBuilder: (context,index)=>SizedBox(height: 6),
                                 itemCount: SocialCubit.get(context).Messages.length),

                           ),
                           if(state is SocialCubitUploadChatImagesLoadingState)
                             LinearProgressIndicator(color: Colors.white,),
                           SizedBox(height: 20,),
                           Container(
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(15),
                                 color: Colors.transparent,
                                 border: Border.all(color:messageController.text==''?Colors.white24:Colors.blue,)
                             ),
                             child: Row(
                               children: [
                                 IconButton(onPressed: ()
                                 {
                                   SocialCubit.get(context).getChatImage();

                                 }, icon: Icon(IconBroken.Image,color:SocialCubit.get(context).chatImage==null?Colors.white:Colors.blue,)),
                                 Expanded(
                                   child: TextFormField(
                                     maxLines: 10,
                                     minLines: 1,
                                     onChanged: (messageController)
                                     {
                                       SocialCubit.get(context).changeChatSendButton(messageController);
                                     },
                                     style: TextStyle(color: Colors.white),
                                     cursorColor: Colors.blue,
                                     autofocus: false,
                                     controller:messageController,
                                     decoration:
                                     InputDecoration(
                                       hintStyle: TextStyle(color: Colors.grey),
                                       focusColor: Colors.blue,
                                       fillColor: Colors.blue,
                                         contentPadding: EdgeInsets.symmetric(horizontal: 0),
                                         hintText: SocialCubit.get(context).chatImage==null?'Type your message':'Press to send photo',
                                         border:InputBorder.none
                                     ),
                                   ),
                                 ),
                                 MaterialButton(
                                   onPressed: ()
                                   {
                                     if(messageController.text.isNotEmpty||SocialCubit.get(context).chatImage!=null)
                                     {
                                       if(SocialCubit.get(context).chatImage!=null)
                                       {
                                         SocialCubit.get(context).uploadChatImageAndSendMessage(recieverId:widget.model.uId!,text:messageController.text);
                                         SocialCubit.get(context).SendNotificationToSomeOne(content:'sent an image',playerIds:[widget.model.osUserID],heading:SocialCubit.get(context).socialModel!.name );
                                         SocialCubit.get(context).chatImage =null;
                                       }
                                       else
                                       {
                                         SocialCubit.get(context).SendMessage(recieverId:widget.model.uId!,text: messageController.text,chatImage: '');
                                         SocialCubit.get(context).SendNotificationToSomeOne(content:messageController.text,playerIds:[widget.model.osUserID],heading:SocialCubit.get(context).socialModel!.name );
                                         messageController.clear();
                                       }
                                     }

                                   },child: Icon(Icons.send,color:SocialCubit.get(context).changeChatSendButton(messageController.text)==1&&SocialCubit.get(context).chatImage==null?Colors.white:Colors.blue)
                                 )
                               ],
                             ),
                           )
                         ],
                       ),
                     );
                   },
                   fallback:(BuildContext context)=>Center(child: CircularProgressIndicator()),

                 ),
               ),
             );
           },
         );
       }
     );
   }

  Widget IMessage(MessageModel message,context)=>ChatBubble(
    backGroundColor: Colors.blue[900],
    alignment: Alignment.topRight,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 6),
          child: Text(
            '${message.text}',
            style: TextStyle(color:Colors.white,fontFamily: 'Megrim' ,fontSize: 17,fontWeight:FontWeight.w600),),
        ),
        Text(
          '${message.dateOfMessage}',
          style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.grey[300]),)
      ],
    ),
    clipper: ChatBubbleClipper5(type: BubbleType.sendBubble,),
  ) ;

  Widget ImyMessage(MessageModel message,context)=>ChatBubble(
    backGroundColor: Colors.grey[900],
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 6),
          child: Text(
            '${message.text}',
            style: TextStyle(color:Colors.white,fontFamily: 'Megrim' ,fontSize: 17,),),
        ),
        Text(
          '${message.dateOfMessage}',
          style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.grey[500]),),
      ],
    ),
    clipper: ChatBubbleClipper5(type: BubbleType.receiverBubble),
  );

  Widget photoContainer(MessageModel message,context)=>InkWell(
    onTap: ()
    {
      NavigateTo(context, SocialPhotoChatOpen(message.chatImage!));
    },
    child: Container(
      height: 400,
      width: double.infinity,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(borderRadius:BorderRadius.circular(20) ),
      child: Image(image: NetworkImage('${message.chatImage}'),fit: BoxFit.cover,),
    ),
  );
}
