
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mostafa1/layout/socialapp-layout/socialCubit/socialCubit.dart';
import 'package:mostafa1/layout/socialapp-layout/socialCubit/socialCubitStates.dart';
import 'package:mostafa1/model/Social-model/social-userModel.dart';
import 'package:mostafa1/modules/social-app/ChatDetails/chat_details.dart';
import 'package:mostafa1/modules/social-app/newchat/newchat.dart';
import 'package:mostafa1/shared/components/components.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialCubitStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).Users.length!=0,
          builder: (BuildContext context) {
            return ListView.separated(
              itemBuilder: (BuildContext context, int index) =>ChatItem(SocialCubit.get(context).Users[index],context),
              separatorBuilder: (BuildContext context, int index)=> Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(height:.5,color: Colors.grey,),
              ),
              itemCount: SocialCubit.get(context).Users.length,
            );
          },
         fallback:(BuildContext context)=>Center(child: CircularProgressIndicator()) ,
        );
      },
    );
  }

  Widget ChatItem(socialUserModel user,context)=>InkWell(
    onTap: ()
    {
      NavigateTo(context, ChatDetailsScreen(model: user));
    },
    child: Padding(
      padding: const EdgeInsets.only(left: 20,top: 20,bottom: 15,right: 20),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage('${user.image}',),
            radius: 25,
          ),
          SizedBox(width: 15,),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text('${user.name}',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    ),
  );
}
