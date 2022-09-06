
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mostafa1/layout/socialapp-layout/socialCubit/socialCubit.dart';
import 'package:mostafa1/layout/socialapp-layout/socialCubit/socialCubitStates.dart';
import 'package:mostafa1/modules/social-app/SettingsCoverPicOpen/SettingsCoverOpen.dart';
import 'package:mostafa1/modules/social-app/editProfileScreen/edit_profile_screen.dart';
import 'package:mostafa1/modules/social-app/setttingsProfielPicOpen/SettingProfilePicOpen.dart';
import 'package:mostafa1/modules/social-app/social-login-screen/social-LoginScreen.dart';
import 'package:mostafa1/shared/components/components.dart';
import 'package:mostafa1/shared/styles/IconBroken.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<SocialCubit,SocialCubitStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).socialModel!=null,
          builder:(context)=> Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 230,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: InkWell(
                          onTap: ()
                          {
                            NavigateTo(context,SettingsCoverPicOpen(SocialCubit.get(context).socialModel!.cover));
                          },
                          child: Container(
                            height: 180,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight:Radius.circular(10) ),
                                image: DecorationImage(image: NetworkImage('${SocialCubit.get(context).socialModel!.cover}',),
                                  fit: BoxFit.cover,
                                )
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: ()
                        {
                          NavigateTo(context, ProfilePicOpen(SocialCubit.get(context).socialModel!.image));
                        },
                        child: CircleAvatar(
                          radius: 75,backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage('${SocialCubit.get(context).socialModel!.image}',),
                            radius: 70,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12,),
                Text('${SocialCubit.get(context).socialModel!.name}',
                  style: TextStyle(fontSize: 20),),
                SizedBox(height: 10,),
                Text('${SocialCubit.get(context).socialModel!.bio}',maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.caption,),
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
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(onPressed: ()
                      {
                       SocialCubit.get(context).signOut().then((value)
                       {
                         NavigateAndFinsh(context, SocialLoginScreen());
                         showToast('logged out successfully',Toaststate.Success,gravity:ToastGravity.CENTER);
                       });
                      }, child: Text('Log Out',style: TextStyle(fontSize: 16,),),
                      ),
                    ),
                    SizedBox(width: 10,),
                    OutlinedButton(onPressed: ()
                    {
                      NavigateTo(context, EditProfileScreen());
                    }, child: Icon(IconBroken.Edit),

                    ),
                    SizedBox(width: 5,),
                    OutlinedButton(onPressed: ()
                    {
                      showToast('Will be added soon', Toaststate.Success, gravity:ToastGravity.TOP_RIGHT );
                    }, child: Icon(IconBroken.Image),

                    ),
                  ],
                )
              ],
            ),
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}