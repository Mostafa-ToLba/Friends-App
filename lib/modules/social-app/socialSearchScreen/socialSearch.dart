import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mostafa1/layout/socialapp-layout/socialCubit/socialCubit.dart';
import 'package:mostafa1/layout/socialapp-layout/socialCubit/socialCubitStates.dart';
import 'package:mostafa1/model/Social-model/social-userModel.dart';
import 'package:mostafa1/modules/social-app/ChatDetails/chat_details.dart';
import 'package:mostafa1/modules/social-app/Profile/profileScreen.dart';
import 'package:mostafa1/shared/components/components.dart';
import 'package:mostafa1/shared/styles/IconBroken.dart';

class SocialSearchScreen extends StatelessWidget {
   SocialSearchScreen({Key? key}) : super(key: key);
  var searchController =TextEditingController();




  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialCubitStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          appBar: AppBar(),
          body:Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),),
                  child: Row(
                    children: [
                      Expanded(
                        child: defultformfield(
                          label: 'Search for friends',
                          controle: searchController,
                        ),
                      ),
                      Container(
                        height: 60,
                        decoration: BoxDecoration(shape: BoxShape.rectangle,color: Colors.blue,borderRadius: BorderRadius.circular(4)),
                          child: IconButton(onPressed: ()
                          {
                            SocialCubit.get(context).search(searchController.text);

                          }, icon: Icon(IconBroken.Search,color: Colors.white,)))
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  height: 1,
                  color: Colors.blue,
                ),
                SizedBox(height: 50,),
                ConditionalBuilder(
                  condition: SocialCubit.get(context).searchModel!=null,
                  builder: (BuildContext context)
                  {
                         if(state is socialSearchLoadingState)
                           return Brograss();
                         else
                  return  SearchItem(context,SocialCubit.get(context).searchModel!);
                  },
                  fallback:(BuildContext context)=> Center(child: CircularProgressIndicator()),
                )

              ],
            ),
          ),
        );
      },
    );
  }
}
 Widget SearchItem(context, socialUserModel searchModel)=>InkWell(
  onTap: ()
  {

    String? name;
    socialUserModel? o;
    String? phone;
    String? bio;
    String? image;
    String? cover;
    String? uid;
    String? e;
    NavigateTo(context, ProfileScreen('',searchModel,searchModel.name,searchModel.image,searchModel.bio!,searchModel.phone!,searchModel.cover!,searchModel.uId!,));
  },
  child: Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      CircleAvatar(
        backgroundImage: NetworkImage('${searchModel.image}',),
        radius: 25,
      ),
      SizedBox(width: 15,),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${searchModel.name}',style: TextStyle(fontSize: 15),),
          Text('${searchModel.bio}',style: Theme.of(context).textTheme.caption),
        ],
      ),
    ],
  ),
);
 Widget Brograss ()=>Center(child: CircularProgressIndicator());
