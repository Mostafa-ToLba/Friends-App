
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mostafa1/layout/socialapp-layout/socialCubit/socialCubit.dart';
import 'package:mostafa1/layout/socialapp-layout/socialCubit/socialCubitStates.dart';
import 'package:mostafa1/model/Social-model/social-userModel.dart';
import 'package:mostafa1/model/Social-model/social_postModel.dart';
import 'package:mostafa1/modules/social-app/ChatDetails/chat_details.dart';
import 'package:mostafa1/modules/social-app/CoverPicOpen/CoverPicOpen.dart';
import 'package:mostafa1/modules/social-app/ProfilePicOpen/profilePicOpen.dart';
import 'package:mostafa1/modules/social-app/photoOpen/photoOpenScreen.dart';
import 'package:mostafa1/shared/components/components.dart';
import 'package:mostafa1/shared/styles/IconBroken.dart';


class ProfileScreen extends StatelessWidget {
  String? name;
  String? image;
  String posterbio;
  String posterPhone;
  String? posterCover;
  String uId;

  socialUserModel chatFromPostt;

  var postId;


    ProfileScreen(this.postId,this.chatFromPostt ,String? this.name, String? this.image, String this.posterbio, String this.posterPhone, String this.posterCover, String this.uId ,  {Key? key}) : super(key: key);

   @override
   Widget build(BuildContext context,) {
     return BlocConsumer<SocialCubit,SocialCubitStates>(
       listener: (context, state){},
       builder: (context,state){
         return Scaffold(
           appBar: AppBar(
             leading:  IconButton(onPressed: () {
               SocialCubit.get(context).chatFromPost=null;
               Navigator.pop(context);
             }, icon: Icon(IconBroken.Arrow___Left_2),),
           ),
           body: BlocConsumer<SocialCubit,SocialCubitStates>(
             listener: (BuildContext context, state) {  },
             builder: (BuildContext context, Object? state) {

               return SingleChildScrollView(
                 child: Padding(
                   padding: const EdgeInsets.all(5.0),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       Container(
                         height: 240,
                         child: Stack(
                           alignment: AlignmentDirectional.bottomCenter,
                           children: [
                             Align(
                               alignment: AlignmentDirectional.topCenter,
                               child: InkWell(
                                 onTap: ()
                                 {
                                   NavigateTo(context, CoverPicOpen(posterCover!));
                                 },
                                 child: Container(
                                   height: 180,
                                   decoration: BoxDecoration(
                                       borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight:Radius.circular(10) ),
                                       image: DecorationImage(image: NetworkImage('${posterCover}',),
                                         fit: BoxFit.cover,
                                       )
                                   ),
                                 ),
                               ),
                             ),
                             InkWell(
                               onTap: ()
                               {
                                 NavigateTo(context, ProfilePicOpen(image));
                               },
                               child: CircleAvatar(
                                 radius: 75,backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                 child: CircleAvatar(
                                   backgroundImage: NetworkImage('${image}',),
                                   radius: 70,
                                 ),
                               ),
                             ),
                           ],
                         ),
                       ),
                       SizedBox(height: 12,),
                       Text('${name}',
                         style: TextStyle(fontSize: 20),),
                       SizedBox(height: 10,),
                       Text('${posterbio}',maxLines: 4,
                         overflow: TextOverflow.ellipsis,
                         style: Theme.of(context).textTheme.caption,),
                       SizedBox(height: 5,),
                       Text('@${posterPhone}',style: Theme.of(context).textTheme.caption,),
                       SizedBox(height: 20,),
                       Row(
                         children:
                         [
                           Expanded(
                             child: InkWell(
                               child: Column(
                                 children:
                                 [
                                   Text('100',style: Theme.of(context).textTheme.bodyText1),
                                   SizedBox(height: 5,),
                                   Text('Posts',style: Theme.of(context).textTheme.caption,),

                                 ],
                               ),
                               onTap: (){},
                             ),
                           ),
                           Expanded(
                             child: InkWell(
                               child: Column(
                                 children:
                                 [
                                   Text('15',style: Theme.of(context).textTheme.bodyText1),
                                   SizedBox(height: 5,),
                                   Text('photes',style: Theme.of(context).textTheme.caption,),

                                 ],
                               ),
                               onTap: (){},
                             ),
                           ),
                           Expanded(
                             child: InkWell(
                               child: Column(
                                 children:
                                 [
                                   Text('234',style: Theme.of(context).textTheme.bodyText1),
                                   SizedBox(height: 5,),
                                   Text('followers',style: Theme.of(context).textTheme.caption,),

                                 ],
                               ),
                               onTap: (){},
                             ),
                           ),
                           Expanded(
                             child: InkWell(
                               child: Column(
                                 children:
                                 [
                                   Text('100',style: Theme.of(context).textTheme.bodyText1),
                                   SizedBox(height: 5,),
                                   Text('following',style: Theme.of(context).textTheme.caption,),

                                 ],
                               ),
                               onTap: (){},
                             ),
                           ),

                         ],
                       ),
                       SizedBox(height: 20,),
                       Container(
                         width: 230,
                         height: 40,
                         child: OutlinedButton(onPressed: ()
                         {

                           NavigateTo(context, ChatDetailsScreen(model: chatFromPostt));

                         }, child: Row(
                           children: [
                             Icon(IconBroken.Message,size: 23,color: Colors.blue,),
                             SizedBox(width: 5,),
                             Text('Send Message',style: TextStyle(fontSize: 17,color: Colors.blue),),
                           ],
                         ),),
                       ),
                       SizedBox(height: 15,),
                       Container(width: double.infinity,height: 1,color: Colors.grey[300],),
                       SizedBox(height: 10,),
                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 15),
                         child: Container(
                             width: double.infinity,
                             child: Text('Posts',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
                       ),
                       SizedBox(height: 5,),
                       ConditionalBuilder(
                         condition: true,
                         builder: (BuildContext context)=>ListView.separated(
                             physics: NeverScrollableScrollPhysics(),
                             shrinkWrap: true,
                             itemBuilder: (context,index)=>buldprofilepost(context,SocialCubit.get(context).profilrPosts[index],),
                             separatorBuilder: (context,index)=>SizedBox(height: 0,),
                             itemCount: SocialCubit.get(context).profilrPosts.length),
                         fallback: (context)=>Center(child: CircularProgressIndicator()),

                       ),
                     ],
                   ),

                 ),
               );
             },
           ),

         );
       },
     );
   }
   Widget buldprofilepost(context, socialPostModel profilrPost,  )=> Card(
     elevation: 6,
     margin: EdgeInsets.all(6),
     clipBehavior: Clip.antiAliasWithSaveLayer,
     child: Padding(
       padding: const EdgeInsets.all(10.0),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Row(
             children: [
               InkWell(
                 child: CircleAvatar(
                   backgroundImage: NetworkImage('${profilrPost.posterImage}',),
                   radius: 25,
                 ),
                 onTap: ()
                 {

                 },
               ),
               SizedBox(width: 15,),
               Expanded(
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Row(
                       children: [
                         InkWell
                           (
                           child: Text('${profilrPost.posterName}',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                           onTap: ()
                           {

                           },
                         ),
                         SizedBox(width: 3,),
                         Icon(Icons.check_circle,color: Colors.blue,size: 18,),
                       ],
                     ),
                     Text('${profilrPost.dateTime}',style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 13,height: 1.4), ),

                   ],
                 ),
               ),
               SizedBox(width: 25),
               /*
              IconButton(onPressed: ()
              {
                if(post.uId==SocialCubit.get(context).socialModel!.uId)
                SocialCubit.get(context).removePost(postsId);
                else
                  print('This is Not Your Post');
              }, icon: Icon(Icons.more_horiz))
               */

             ],
           ),
           SizedBox(height: 13,),
           Container(height: 1,color: Colors.grey[300],),
           SizedBox(height: 13,),
          // if(post.Text!='')
             Padding(
               padding: const EdgeInsets.only(right: 10),
               child: Text('${profilrPost.Text}',
                 style: TextStyle(fontSize: 16,height: 1.2,),
               ),
             ),
           if(profilrPost.postImage!='')
             Padding(
               padding: const EdgeInsets.only(top: 10),
               child: InkWell(
                 onTap: ()
                 {
                   NavigateTo(context, SocialPhotoOpen(profilrPost.postImage!));
                 },
                 /*
              child: Container(
           //     width: double.infinity,
           //     height: 500,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(image: NetworkImage('${post.postImage}'),
           //           fit: BoxFit.cover,
                    )
                ),
              ),
               */
                 child: Container(

                     child: Image(image: NetworkImage('${profilrPost.postImage}'),)
                 ),
               ),
             ),
           Padding(
             padding: const EdgeInsets.symmetric(
               vertical: 5.0,
             ),
             child: Row(
               children: [
                 Expanded(
                   child: InkWell(
                     child: Padding(
                       padding: const EdgeInsets.symmetric(
                         vertical: 5.0,
                       ),
                       child: Row(
                         children: [
                           /*
                           Icon(
                             IconBroken.Heart,
                             size: 22.0,
                             color: Colors.red,
                           ),
                            */
                           Text(
                               ''
                           ),
                           SizedBox(
                             width: 5.0,
                           ),
                           /*
                          Text(
                            '${SocialCubit.get(context).Likes[index]}',
                            style: Theme.of(context).textTheme.caption,
                          ),

                           */
                         ],
                       ),
                     ),
                   ),
                 ),
                 Expanded(
                   child: InkWell(
                     child: Padding(
                       padding: const EdgeInsets.symmetric(
                         vertical: 5.0,
                       ),
                       /*
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.end,
                         children: [
                           Icon(
                             IconBroken.Chat,
                             size: 22.0,
                             color: Colors.amber,
                           ),
                           SizedBox(
                             width: 5.0,
                           ),
                           Text(
                             'comment',
                             style: Theme.of(context).textTheme.caption,
                           ),
                         ],
                       ),

                        */
                     ),
                     onTap: () {

                     },
                   ),
                 ),
               ],
             ),
           ),
           Container(
             height: 1,color: Colors.grey[350],
           ),
           SizedBox(height: 10,),
           Row(
             children: [
               Expanded(
                 child: InkWell(
                   onTap: ()
                   {
              //       NavigateTo(context, AddCommentScreen(postId: postsId.toString(), ));
                   },
                   child: Row(
                     children: [
                       CircleAvatar(
                         backgroundImage: NetworkImage('${profilrPost.posterImage}',),
                         radius: 25,
                       ),
                       SizedBox(width: 15,),
                       Text('write a comment ...'),
                     ],
                   ),
                 ),
               ),
               /*
               InkWell(
                 onTap: ()
                 {
            //       SocialCubit.get(context).postLike(postsId);

                 },
                 child: Row(
                   children: [
                     Icon(
                       IconBroken.Heart,
                       size: 22.0,
                       color: Colors.red,
                     ),
                     SizedBox(
                       width: 5.0,
                     ),
                     Text(
                       'Like',
                       style: Theme.of(context).textTheme.caption,
                     ),
                   ],
                 ),
               ),
                */
             ],
           ),
         ],
       ),
     ),

   );
 }
