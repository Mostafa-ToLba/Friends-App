
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mostafa1/layout/socialapp-layout/socialCubit/socialCubit.dart';
import 'package:mostafa1/layout/socialapp-layout/socialCubit/socialCubitStates.dart';
import 'package:mostafa1/shared/components/components.dart';
import 'package:mostafa1/shared/styles/IconBroken.dart';

class EditProfileScreen extends StatelessWidget {
   EditProfileScreen({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialCubitStates>(
     listener: (BuildContext context,state){},
      builder: (BuildContext context,state)
      {
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;
        nameController.text=SocialCubit.get(context).socialModel!.name!;
        bioController.text=SocialCubit.get(context).socialModel!.bio!;
        phoneController.text=SocialCubit.get(context).socialModel!.phone!;
        return Scaffold(
          appBar: AppBar(titleSpacing: 3,
            title: Text('Edit Profile',style:Theme.of(context).textTheme.bodyText1,
            ),
            leading: IconButton(onPressed: ()
            {
              Navigator.pop(context);
            }, icon: Icon(IconBroken.Arrow___Left_2,),),
            actions:
            [
              TextButton(onPressed: ()
              {
                SocialCubit.get(context).UpdateUserImages
                  (name: nameController.text,bio: bioController.text,phone: phoneController.text,);

              }, child: Text('Update',style: TextStyle(fontSize: 18),),),
              SizedBox(width: 14,),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children:
                [
                  if(state is SocialCubitUpdateLoadingState)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LinearProgressIndicator(),
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 230,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Align(
                              alignment: AlignmentDirectional.topCenter,
                              child: Stack(
                                alignment: AlignmentDirectional.topStart,
                                children: [
                                  Container(
                                    height: 180,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight:Radius.circular(5) ),
                                        image: DecorationImage(image:coverImage==null?
                                        NetworkImage('${SocialCubit.get(context).socialModel!.cover}',):FileImage(coverImage)as ImageProvider,
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
                                        SocialCubit.get(context).getCoverImage();
                                      }, icon: Icon(IconBroken.Camera),),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                CircleAvatar(
                                  radius: 75,backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                  child: CircleAvatar(
                                    backgroundImage: profileImage==null? NetworkImage
                                      ('${SocialCubit.get(context).socialModel!.image}'):FileImage(profileImage)as ImageProvider,
                                    radius: 70,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.only(end: 12,bottom: 3),
                                  child: CircleAvatar(
                                    radius: 20,
                                    child: IconButton(onPressed: ()
                                    {
                                       SocialCubit.get(context).getProfileImage();
                                    }, icon: Icon(IconBroken.Camera),),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  defultformfield(
                    contentPadding:EdgeInsetsDirectional.all(5),
                    label: 'Name ..',
                    prefix: IconBroken.User,
                    keyboard: TextInputType.name,
                    controle: nameController,
                  ),
                  SizedBox(height: 10,),
                  defultformfield(
                    contentPadding:EdgeInsetsDirectional.all(5),
                    label: 'Bio ..',
                    prefix: IconBroken.Paper,
                    keyboard: TextInputType.text,
                    controle: bioController,
                  ),
                  SizedBox(height: 10,),
                  defultformfield(
                    contentPadding:EdgeInsetsDirectional.all(5),
                    label: 'Phone ..',
                    prefix: IconBroken.Call,
                    keyboard: TextInputType.phone,
                    controle: phoneController,
                  ),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      Expanded(child: OutlinedButton(child: Text('Upload Profile Picture',maxLines: 1,),onPressed: ()
                      {
                        SocialCubit.get(context).uploadProfileImage(name: nameController.text,phone: phoneController.text,bio: bioController.text);
                      },)),
                      SizedBox(width: 8,),
                      Expanded(child: OutlinedButton(child: Text('Upload Cover Picture',maxLines: 1,)
                        ,onPressed: ()
                      {
                        SocialCubit.get(context).uploadCoverImage(name: nameController.text,phone: phoneController.text,bio: bioController.text );
                      },)),
                    ],
                  ),
                  SizedBox(height: 50),
                  if(state is SocialCubitUploadProfilePicLoadingState||state is SocialCubitUploadCoverPicLoadingState)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LinearProgressIndicator(),
                    )
                ],
              ),
            ),

          ),


        );
      },
    );
  }
  
}
