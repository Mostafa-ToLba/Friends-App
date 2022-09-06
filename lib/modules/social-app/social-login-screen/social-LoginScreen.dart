
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mostafa1/layout/socialapp-layout/socialCubit/socialCubit.dart';
import 'package:mostafa1/layout/socialapp-layout/socialapp-layoutScreen.dart';
import 'package:mostafa1/modules/social-app/social-login-screen/social-login-cubit/social-loginCubit.dart';
import 'package:mostafa1/modules/social-app/social-login-screen/social-login-cubit/social-loginStates.dart';
import 'package:mostafa1/modules/social-app/social-register-screen/social-registerScreen.dart';
import 'package:mostafa1/shared/components/components.dart';
import 'package:mostafa1/shared/network/local/cashe_helper.dart';

class SocialLoginScreen extends StatelessWidget {
    SocialLoginScreen({Key? key}) : super(key: key);

   var emailController =TextEditingController();
   var passwordController =TextEditingController();
   var formKey = GlobalKey<FormState>();

   @override
   Widget build(BuildContext context) {
     return BlocProvider(
       create: (BuildContext context)=>SocialLoginCubit(SocialLoginInitialState()),
         child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
           listener: (BuildContext context,state){
             if(state is SocialLoginErrorState)
             {
               showToast(state.error, Toaststate.Error, gravity:ToastGravity.BOTTOM );
             }
             if(state is SocialLoginSuccessState)
             {
               CasheHelper.SaveData(key: 'uId', value:state.uId )!.then((value)
               {
                 SocialCubit.get(context).getUserDate(state.uId);
                 NavigateAndFinsh(context, SocialLayoutScreen());
               });
             }
           },
           builder:(BuildContext context,state){
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
                             'login now to communicate with your friends',
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
                             controle: emailController,
                             label: 'Email Address',
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
                             suffix: SocialLoginCubit.get(context).Suffix,
                             isPassword: SocialLoginCubit.get(context).UnvisibleBassword,
                             suffixPressed: ()
                             {
                               SocialLoginCubit.get(context).ChangeSuffix();
                             },
                           ),
                           SizedBox(height: 30,),
                           ConditionalBuilder(
                             condition: state is! SocialLoginLoadingState,
                             builder: (context)=>defultButton(
                               backGround: Colors.blue,
                               width: 400, text:'LOGIN',
                               function: ()
                               {
                                 if(formKey.currentState!.validate())
                                 {
                                   SocialLoginCubit.get(context).SignIN(email: emailController.text, password: passwordController.text,);
                                   SocialCubit.get(context).getAllUsers();
                                   SocialCubit.get(context). getNotify();
                                 }
                                 SocialCubit.get(context). getNotify();
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
                                 NavigateTo(context, SocialRegisterScreen());
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
           } ,
         ),
     );
   }
 }
