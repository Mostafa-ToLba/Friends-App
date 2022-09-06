
 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:mostafa1/layout/socialapp-layout/socialCubit/socialCubit.dart';
import 'package:mostafa1/layout/socialapp-layout/socialCubit/socialCubitStates.dart';
import 'package:mostafa1/layout/socialapp-layout/socialapp-layoutScreen.dart';
import 'package:mostafa1/model/Social-model/social-userModel.dart';
import 'package:mostafa1/modules/social-app/newsFeed/newsFeed.dart';
import 'package:mostafa1/shared/components/components.dart';
import 'package:mostafa1/shared/styles/IconBroken.dart';

class AddNewPostScreen extends StatelessWidget {
   const AddNewPostScreen({Key? key}) : super(key: key);
   @override
   Widget build(BuildContext context) {
     return BlocConsumer<SocialCubit,SocialCubitStates>(
       listener: (BuildContext context,state){},
       builder:  (BuildContext context,state) {
         var now = DateFormat.yMMMMd().add_Hms().format(DateTime.now());
         var textController =TextEditingController();
         return Scaffold(
           appBar: AppBar(
             leading: IconButton(icon: (Icon(IconBroken.Arrow___Left_2)), onPressed: () {
              // SocialCubit.get(context).getPosts();
               NavigateAndFinsh(context, SocialLayoutScreen());
             },),
             title:Text('Create Post'),
             actions:
             [
               TextButton(onPressed: ()
                  {
                 if(SocialCubit.get(context).postImage!=null)
                   {
                     SocialCubit.get(context).uploadPostImageAndCreatePost(text: textController.text,).then((value)
                     {
                       SocialCubit.get(context).sendToeveryOne();
                       SocialCubit.get(context).postNotificationToEveryOne(heading:'${SocialCubit.get(context).socialModel!.name!.toLowerCase()} added a new post',content:textController.text==''?'posted an image':textController.text,);
                       SocialCubit.get(context).getPosts2().then((value)
                       {
                         NavigateAndFinsh(context, SocialLayoutScreen());
                       });
                     });

                   }else if(SocialCubit.get(context).postImage==null)
                     {
                       SocialCubit.get(context).CreatePost(Text:textController.text,postImage: '',
                       posterName: SocialCubit.get(context).socialModel!.name!,posterImage:SocialCubit.get(context).socialModel!.image! );
                       SocialCubit.get(context).sendToeveryOne();
                       SocialCubit.get(context).postNotificationToEveryOne(heading:'${SocialCubit.get(context).socialModel!.name!.toLowerCase()} added a new post',content:textController.text);
                       SocialCubit.get(context).getPosts2().then((value)
                       {
                         NavigateAndFinsh(context, SocialLayoutScreen());
                       });
                     }
               }, child: Text('Post',style: TextStyle(fontSize: 20),),)
             ],
           ),
           body: SingleChildScrollView(
             child: Padding(
               padding: const EdgeInsets.all(20.0),
               child: Column(
                 children:
                 [
                   if(state is SocialCubitLoadingUploadPostImage)
                   LinearProgressIndicator(),
                   SizedBox(height: 13),
                   Row(
                     children:
                     [
                       CircleAvatar(
                         backgroundImage: NetworkImage('${SocialCubit.get(context).socialModel!.image}',),
                         radius: 25,
                       ),
                       SizedBox(width: 15,),
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Row(
                             children: [
                               Text('${SocialCubit.get(context).socialModel!.name}',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                               SizedBox(width: 3,),
                               Icon(Icons.check_circle,color: Colors.blue,size: 18,),
                             ],
                           ),
                           Text('${DateFormat.yMMMMd().add_Hms().format(DateTime.now())}',style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 13,height: 1.4), ),

                         ],
                       ),
                     ],
                   ),
                   TextFormField( textAlign: TextAlign.start ,maxLines: 10,controller: textController,decoration: InputDecoration(hintText:'What\'s on your mind ${SocialCubit.get(context).socialModel!.name!.toLowerCase()} ?',border: InputBorder.none),),
                   if(SocialCubit.get(context).postImage != null)
                     Stack(
                       alignment: AlignmentDirectional.topEnd,
                       children: [
                         Container(
                           height: 300,
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight:Radius.circular(5) ),
                               image: DecorationImage(image:FileImage(SocialCubit.get(context).postImage!)as ImageProvider,
                                 fit: BoxFit.cover,
                               )
                           ),
                         ),
                         Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 13.0,
                               vertical: 13),
                           child: CircleAvatar(
                             radius: 20,
                             child: IconButton(onPressed: ()
                             {
                                SocialCubit.get(context).removePostImage();
                             }, icon: Icon(Icons.close),),
                           ),
                         ),
                       ],
                     ),
                   SizedBox(height: 30,),
                   Row(
                     children: [
                       Expanded(
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children:
                           [
                             TextButton(onPressed: ()
                             {
                               SocialCubit.get(context).getpostImage();
                             }, child: Row(
                               children:
                               [
                                 Text('Add Photo'),
                                 SizedBox(width: 5,),
                                 Icon(IconBroken.Image),
                               ],
                             ))
                           ],
                         ),
                       ),
                       Expanded(child: TextButton(onPressed: (){}, child: Text('#Tags'))),
                     ],
                   ),
                 ],
               ),
             ),
           ),
         );
       },

     );
   }
 }
