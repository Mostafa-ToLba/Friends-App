
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mostafa1/layout/socialapp-layout/socialapp-layoutScreen.dart';
import 'package:mostafa1/modules/social-app/social-login-screen/social-LoginScreen.dart';
import 'package:mostafa1/modules/social-app/social-register-screen/social-registerCubit/social-registerCubit.dart';
import 'package:mostafa1/modules/social-app/social-register-screen/social-registerCubit/social-registerStates.dart';
import 'package:mostafa1/shared/components/components.dart';

class SocialRegisterScreen extends StatelessWidget {
    SocialRegisterScreen({Key? key}) : super(key: key);
   var emailController =TextEditingController();
   var passwordController =TextEditingController();
   var phoneController =TextEditingController();
   var userNameController =TextEditingController();
   var formKey = GlobalKey<FormState>();
   @override
   Widget build(BuildContext context) {
     return BlocProvider(
       create: (BuildContext context) =>SocialRegisterCubit(SocialRegisterCubitInitialState()),
       child: BlocConsumer<SocialRegisterCubit,SocialRegisterCubitStates>(
         listener: (BuildContext context, state) {
           if(state is SocialCreateUserSuccessState)
           {

             NavigateAndFinsh(context, SocialLoginScreen());
           }
         },
         builder: (BuildContext context, Object? state) {
           return Scaffold(
             appBar: AppBar(),
             body: Center(
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
                             'REGISTER',
                             style: TextStyle(
                               fontSize: 45,
                               fontWeight: FontWeight.w600,
                             )
                         ),
                         SizedBox(
                           height: 15,
                         ),
                         Text(
                           'register now to communicate with your friends',
                           style: TextStyle(
                             fontSize: 20,
                             color: Colors.grey,
                           ),
                         ),
                         SizedBox(
                           height: 35,
                         ),
                         defultformfield(
                           prefix: Icons.person,
                           validate: (String value)
                           {
                             if(value.isEmpty)
                             {
                               return'Please Enter Your Name';
                             }
                           },
                           keyboard: TextInputType.name,
                           controle: userNameController ,
                           label: 'username',
                         ),

                         SizedBox(
                           height: 14,
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
                           label: 'email Address',
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

                           suffix: SocialRegisterCubit.get(context).Suffix,
                           isPassword: SocialRegisterCubit.get(context).UnvisibleBassword,
                           suffixPressed: ()
                           {
                             SocialRegisterCubit.get(context).ChangeSuffix();
                           },
                           keyboard: TextInputType.visiblePassword,
                           label: 'password',
                           controle: passwordController,

                         ),
                         SizedBox(
                           height: 14,
                         ),
                         defultformfield(

                           keyboard: TextInputType.phone,
                           label: 'phone',
                           controle: phoneController,
                           prefix: Icons.phone,
                           validate: (String value)
                           {
                             if(value.isEmpty)
                             {
                               return'Please Enter Your Phone Number';
                             }
                           },
                         ),
                         SizedBox(height: 30,),
                         ConditionalBuilder(
                           condition: state is! SocialRegisterCubitLoadingState,
                           builder: (BuildContext context)=>
                               defultButton(
                                 height: 50.0,
                                 backGround: Colors.blue,
                                 width: 400, text:'Register',
                                 function: ()
                                 {
                                   if(formKey.currentState!.validate());
                                   SocialRegisterCubit.get(context).UserRegister(
                                       email: emailController.text,
                                       password: passwordController.text,
                                       name: userNameController.text,
                                       phone: phoneController.text);
                                 },
                               ),
                           fallback: (context)=> Center(child: CircularProgressIndicator(color: Colors.blue,backgroundColor: Colors.grey[300],strokeWidth: 10,)),
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
