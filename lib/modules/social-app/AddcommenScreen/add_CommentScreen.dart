
 import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mostafa1/layout/socialapp-layout/socialCubit/socialCubit.dart';
import 'package:mostafa1/layout/socialapp-layout/socialCubit/socialCubitStates.dart';
import 'package:mostafa1/layout/socialapp-layout/socialapp-layoutScreen.dart';
import 'package:mostafa1/model/Social-model/comment_model.dart';
import 'package:mostafa1/modules/social-app/photoCommentOpen/photoOpenComment.dart';
import 'package:mostafa1/shared/components/components.dart';
import 'package:mostafa1/shared/styles/IconBroken.dart';

 class AddCommentScreen extends StatelessWidget {
  var postId;
    AddCommentScreen({this.postId,}) ;
   var commentController =TextEditingController();
    var now= DateTime.now();

   @override
   Widget build(BuildContext context,) {
     return Builder(
       builder: (BuildContext context) {
         SocialCubit.get(context).getcomments(postId);
         return BlocConsumer<SocialCubit,SocialCubitStates>(
           listener: (BuildContext context, state) {  },
           builder: (BuildContext context, Object? state) {

             return Scaffold(
               appBar: AppBar(
                 leading: IconButton(onPressed: (){
                   NavigateAndFinsh(context, SocialLayoutScreen());
                 }, icon: Icon(IconBroken.Arrow___Left_2)),
                 title: Text('Comments',style: TextStyle(color: Colors.blue),),
               ),
               body: ConditionalBuilder(
                 condition: true,
                 builder: (BuildContext context) {
                   return SingleChildScrollView(
                     child: Column(
                       children: [
                         if(SocialCubit.get(context).comments.isEmpty)
                           Column(
                             children:
                             [
                               Text('No comments yet...',style: TextStyle(fontSize: 15),),
                               Icon(Icons.message_outlined,size: 30,),
                             ],
                           ),
                         Column(
                           children: [
                             ListView.separated(
                                 physics: BouncingScrollPhysics(),
                                 shrinkWrap: true,
                                 itemBuilder: (context,index){
                                   var comment = SocialCubit.get(context).comments[index] ;
                                   if(comment.commnetPhoto!='')
                                   {
                                     return photoComment(comment,context);
                                   }
                                   else {
                                     return BuiltCommentItem(comment, context);
                                   }
                                 },
                                 separatorBuilder: (context,index)=>SizedBox(height: 0),
                                 itemCount: SocialCubit.get(context).comments.length),
                         Padding(
                           padding: const EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 20),
                           child: Container(
                             decoration: BoxDecoration(color: Colors.grey[200],borderRadius: BorderRadius.circular(15),),
                             child: Row(
                               children: [
                                 IconButton(onPressed: ()
                                 {
                                   SocialCubit.get(context).getCommentImage();

                                 }, icon: Icon(IconBroken.Camera)),
                                 Expanded(
                                   child: TextFormField(
                                       controller: commentController,
                                       decoration: InputDecoration(
                                         contentPadding: EdgeInsetsDirectional.only(start: 20),
                                         hintText: 'Write a comment... ',
                                         border: InputBorder.none,
                                         hintStyle: TextStyle(),
                                       )),
                                 ),
                                 IconButton(onPressed: ()
                                 {
                                   if(SocialCubit.get(context).commentImage!=null)
                                   {
                                     SocialCubit.get(context).uploadCommentImageAndCreateComment(Text:commentController.text,postId:postId);
                                     SocialCubit.get(context).getCommentUser(postId);
                                     SocialCubit.get(context).SendNotificationToSomeOne
                                       (heading: '${SocialCubit.get(context).socialModel!.name!.toLowerCase()} commented on your post',
                                         content:commentController.text==''?'added an image':commentController.text,playerIds:[SocialCubit.get(context).commenterOsUserID.toString()]);
                                     commentController.clear();
                                     SocialCubit.get(context).commentImage =null;
                                   }else if (SocialCubit.get(context).commentImage==null)
                                   {
                                     SocialCubit.get(context).CreateComment(Text: commentController.text, postId:postId);
                                     SocialCubit.get(context).getCommentUser(postId);
                                     SocialCubit.get(context).SendNotificationToSomeOne
                                       (heading: '${SocialCubit.get(context).socialModel!.name!.toLowerCase()} commented on your post',
                                     content:commentController.text,playerIds:[SocialCubit.get(context).commenterOsUserID.toString()]);
                                     commentController.clear();
                                   }
                                 }, icon: Padding(
                                   padding: const EdgeInsets.only(right: 30),
                                   child: Icon(Icons.arrow_forward_ios_outlined),
                                 ),color: Colors.blue,)
                               ],
                             ),
                           ),
                         ),
                     ],
                         ),
                       ],
                     ),
                   );
                 },
                 fallback: (BuildContext context)=>Center(child: CircularProgressIndicator()),

               ),
             );
           },
         );
       },

     );
   }
   Widget BuiltCommentItem(socialCommentModel comment,context )=> Padding(
     padding: const EdgeInsets.only(left: 15,right: 15,top:5,bottom: 5 ),
     child: Column(
       children: [
         Row(
           children:
           [
             CircleAvatar(
               backgroundImage: NetworkImage('${comment.image}',),
               radius: 25,
             ),
             SizedBox(width: 10,),
             Container(
               child: Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text('${comment.name}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                     Text('${comment.Text}',style: TextStyle(fontSize: 16),),
                   ],
                 ),
               ),
               decoration: BoxDecoration(
                 color: Colors.grey[100],
                 borderRadius: BorderRadius.circular(15)
               ),
             ),
           ],
         ),
         Padding(
           padding: const EdgeInsets.only(right: 70),
           child: Text('${comment.dateTime}'),
         ),
       ],
     ),
   );
   Widget photoComment(comment,context)=>Padding(
     padding: const EdgeInsets.only(left: 15,right: 15,top:5,bottom: 5 ),
     child: Column(
       children: [
         Row(
           children:
           [
             CircleAvatar(
               backgroundImage: NetworkImage('${comment.image}',),
               radius: 25,
             ),
             SizedBox(width: 10,),
             Container(
               child: Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text('${comment.name}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                     Text('${comment.Text}',style: TextStyle(fontSize: 16),),
                   ],
                 ),
               ),
               decoration: BoxDecoration(
                   color: Colors.grey[100],
                   borderRadius: BorderRadius.circular(15)
               ),
             ),
           ],
         ),
       InkWell(
         onTap: ()
         {
           NavigateTo(context, SocialCommentPhotoOpen(comment.commnetPhoto));
         },
         child: Container(
           height: 300,
           width: double.infinity,
           clipBehavior: Clip.antiAliasWithSaveLayer,
           decoration: BoxDecoration(borderRadius:BorderRadius.circular(15) ),
           child: Image(image: NetworkImage('${comment.commnetPhoto}'),fit: BoxFit.cover,),
            ),
       ),
         Padding(
           padding: const EdgeInsets.only(right: 70),
           child: Text('${comment.dateTime}'),
         ),
       ],
     ),
   );
 }
