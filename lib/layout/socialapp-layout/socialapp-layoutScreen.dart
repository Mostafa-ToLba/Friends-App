
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mostafa1/layout/socialapp-layout/socialCubit/socialCubit.dart';
import 'package:mostafa1/layout/socialapp-layout/socialCubit/socialCubitStates.dart';
import 'package:mostafa1/modules/social-app/addPost/add_postScreen.dart';
import 'package:mostafa1/modules/social-app/socialSearchScreen/socialSearch.dart';
import 'package:mostafa1/shared/components/components.dart';
import 'package:mostafa1/shared/styles/IconBroken.dart';

class SocialLayoutScreen extends StatelessWidget {
   const SocialLayoutScreen({Key? key}) : super(key: key);

   @override
   Widget build(BuildContext context) {
     return BlocConsumer<SocialCubit,SocialCubitStates>(
       listener: (BuildContext context, state) {
         if (state is SocialNewPostStateNavPar) {
         NavigateTo(context, AddNewPostScreen());
         }
       },
       builder: (BuildContext context, Object? state) {
         return Scaffold(
           appBar: AppBar(
             title: Text('${SocialCubit.get(context).Titles[SocialCubit.get(context).currentIndex]}',style: TextStyle(color: Colors.blue,fontSize:25 ),),
             actions: [
               IconButton(icon:Icon(IconBroken.Notification),onPressed: (){
                 showToast('No notifications yet', Toaststate.Success, gravity:ToastGravity.TOP_RIGHT );
               },),
               IconButton(icon:Icon(IconBroken.Search),onPressed: ()
               {
                 NavigateTo(context, SocialSearchScreen());
               },),

             ],
           ),
           body: SocialCubit.get(context).Screens[SocialCubit.get(context).currentIndex],

           bottomNavigationBar:
           BottomNavigationBar(

             items:
           [
             BottomNavigationBarItem(icon: Icon(IconBroken.Home,),label: 'Home',),
             BottomNavigationBarItem(icon: Icon(IconBroken.Chat,),label: 'Chats',),
             BottomNavigationBarItem(icon: Icon(IconBroken.Paper_Plus,),label: 'Post',),
             BottomNavigationBarItem(icon: Icon(IconBroken.User,),label: 'Users',),
             BottomNavigationBarItem(icon: Icon(IconBroken.Setting),label: 'Settings',),
           ],
             currentIndex: SocialCubit.get(context).currentIndex,
             onTap:(index)
           {
             SocialCubit.get(context).ChangeBottomNavItem(index,context);
           },
           ),
         );
       },
     );
   }

   Widget warning (context)=>ConditionalBuilder(
     condition:SocialCubit.get(context).socialModel!=null,
     builder: (BuildContext context) {
       return Column(
         children:
         [
           if(FirebaseAuth.instance.currentUser!.emailVerified!=true)
             Container(
               color: Colors.amber[300],
               child: Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 20),
                 child: Row(
                   children:
                   [
                     Icon(Icons.error_outline),
                     SizedBox(width: 10,),
                     Text('please verify your email',maxLines: 1,style: TextStyle(fontSize: 15)),
                     Spacer(),
                     TextButton(onPressed: ()
                     {
                       FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value)
                       {
                         showToast('please check your mail', Toaststate.Success, gravity: ToastGravity.BOTTOM);
                       }).catchError((){});

                     }, child: Text('Send',style: TextStyle(fontSize: 16)),)
                   ],
                 ),
               ),
             ),
         ],
       );
     },
     fallback: (BuildContext context) =>Center(child: CircularProgressIndicator()),
   );
 }
