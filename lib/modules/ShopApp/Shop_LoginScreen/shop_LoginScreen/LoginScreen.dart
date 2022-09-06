
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mostafa1/layout/shopAppLayout/ShopLayout/ShopLayout.dart';
import 'package:mostafa1/layout/shopAppLayout/shopLayoutCubit/cubit.dart';
import 'package:mostafa1/modules/ShopApp/Register_Screen/rigester_Screen.dart';
import 'package:mostafa1/modules/ShopApp/Shop_LoginScreen/ShopLoginCubit/ShopCubit.dart';
import 'package:mostafa1/modules/ShopApp/Shop_LoginScreen/ShopLoginCubit/ShopStates.dart';
import 'package:mostafa1/shared/components/components.dart';
import 'package:mostafa1/shared/components/constants.dart';
import 'package:mostafa1/shared/network/local/cashe_helper.dart';


 class ShopLoginScreen extends StatelessWidget {
   ShopLoginScreen({Key? key}) : super(key: key);

  var emailController =TextEditingController();
   var passwordController =TextEditingController();
   var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>ShopLoginCubit(ShopLoginInitialState()),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (BuildContext context, state)
        {
         if(state is ShopLoginSuccessState)
         {
          if(ShopLoginCubit.get(context).userLogin!.status==true)
          {

            CasheHelper.SaveData(key: 'token', value: ShopLoginCubit.get(context).userLogin!.data!.token)!.then((value)
            {
              token= ShopLoginCubit.get(context).userLogin!.data!.token!;
              ShopLayoutCubit.get(context).getProfileData();
              showToast( ShopLoginCubit.get(context).userLogin!.message!, Toaststate.Success);
              NavigateAndFinsh(context, ShopLayoutScreen());
            }
            );

         // showToast( ShopLoginCubit.get(context).userLogin!.message!, Toaststate.Success);

            print(ShopLoginCubit.get(context).userLogin!.message);
             print(ShopLoginCubit.get(context).userLogin!.data!.token);
          }else
            {
              showToast( ShopLoginCubit.get(context).userLogin!.message!, Toaststate.Error);
              print(ShopLoginCubit.get(context).userLogin!.message);
            }
         }
        },
        builder: (BuildContext context, Object? state) {
          return Scaffold(
            appBar: AppBar(),

            body:Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        Text(
                            'LOGIN',
                            style: TextStyle(
                              fontSize: 45,
                              fontWeight: FontWeight.w600,
                            )
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,

                          ),
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        defultformfield(
                          prefix: Icons.email_outlined,
                          validate: (String value)
                          {
                            if(value.isEmpty)
                            {
                              return'Please Enter Your Email Address';
                            }
                          },
                          keyboard: TextInputType.emailAddress,
                          controle: emailController ,
                          label: 'Email Adress',
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        defultformfield(
                          prefix: Icons.lock_outlined,
                          validate: (String value)
                          {
                            if(value.isEmpty)
                            {
                              return'Please Enter Your Password';
                            }
                          },
                          keyboard: TextInputType.visiblePassword,
                          controle: passwordController ,
                          label: 'Password',
                          suffix: ShopLoginCubit.get(context).Suffix,
                          isPassword: ShopLoginCubit.get(context).UnvisibleBassword,
                          suffixPressed: ()
                          {
                            ShopLoginCubit.get(context).ChangeSuffix();
                          },
                        ),
                        SizedBox(height: 30,),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context)=>defultButton(
                            backGround: Colors.blue,
                            width: 400, text:'LOGIN',
                            function: ()
                            {
                              if(formKey.currentState!.validate())
                              ShopLoginCubit.get(context).getUserData(Email: emailController.text, Password: passwordController.text);
                            },
                          ),
                          fallback:(context)=>Center(child: CircularProgressIndicator(
                            color: Colors.blue,
                          )),
                        ),
                        SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),),
                            TextButton(onPressed: ()
                            {
                             NavigateTo(context, RegisterScreen());
                            }, child: Text('REGISTER',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                )),)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },

      ),
    );
  }
}
