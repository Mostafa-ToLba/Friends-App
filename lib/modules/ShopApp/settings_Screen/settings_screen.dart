import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:mostafa1/layout/shopAppLayout/shopLayoutCubit/cubit.dart';
import 'package:mostafa1/layout/shopAppLayout/shopLayoutCubit/states.dart';
import 'package:mostafa1/shared/components/components.dart';
import 'package:mostafa1/shared/components/constants.dart';
import 'package:mostafa1/shared/network/local/cashe_helper.dart';
import 'package:mostafa1/shared/network/remote/dioHelper.dart';

class SettingsScreen extends StatelessWidget {
   SettingsScreen({Key? key}) : super(key: key);

  var  emailController =TextEditingController();
  var phoneController =TextEditingController();
  var NameController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        emailController.text=ShopLayoutCubit.get(context).profileData!.data!.email!;
        phoneController.text=ShopLayoutCubit.get(context).profileData!.data!.phone!;
        NameController.text=ShopLayoutCubit.get(context).profileData!.data!.name!;

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                defultformfield(
                  contentPadding: EdgeInsets.all(25),
                  controle: NameController,
                  label: 'Name',
                  keyboard: TextInputType.name ,
                  validate: (String value)
                  {
                    if(value.isEmpty)
                    {
                      return 'Name Must not Be Empty';
                    }
                    return null;
                  },
                  prefix: Icons.person ,
                ),
                SizedBox(height: 25,),
                defultformfield(
                  contentPadding: EdgeInsets.all(25),
                  controle: emailController,
                  label: 'Email',
                  keyboard: TextInputType.emailAddress ,
                  validate: (String value)
                  {
                    if(value.isEmpty)
                    {
                      return 'Email Address Must not Be Empty';
                    }
                    return null;
                  },
                  prefix: Icons.email_outlined ,
                ),
                SizedBox(height: 25,),
                defultformfield(
                  contentPadding: EdgeInsets.all(25),
                  controle: phoneController,
                  label: 'Phone',
                  keyboard: TextInputType.phone ,
                  validate: (String value)
                  {
                    if(value.isEmpty)
                    {
                      return 'Phone Must not Be Empty';
                    }
                    return null;
                  },
                  prefix: Icons.phone ,
                ),
                SizedBox(height: 30,),
                defultButton(backGround: Colors.blue,height: 60.0, width: 400, text: 'LOGOUT', function: ()
                {
                  SignOut(context);

                }),
                SizedBox(height: 20,),
                Row(
                  children:
                  [
                    Text('would you want to update your data?',
                    style: TextStyle(
                      fontSize: 16,
                          fontWeight: FontWeight.w800,
                    ),

                        ),
                    SizedBox(height: 10,),
                    Expanded(
                      child: TextButton(onPressed: ()
                      {
                          ShopLayoutCubit.get(context).UpdateData(Email: emailController.text,phone: phoneController.text,name: NameController.text);
                          print(ShopLayoutCubit.get(context).profileData!.message);
                      }, child: Text('UPDATE',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),),),
                    )
                  ],
                ),
                Text('Please justfy the above textfield and then click update..!',
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 50,),
                if(state is UpdateProfileDataLoadingState)
                  LinearProgressIndicator(
                    color: Colors.blue,
                    backgroundColor: Colors.grey,
                    minHeight: 5.5,
                  ),
              ],
            ),
          ),
        );
      },
    );

  }
}