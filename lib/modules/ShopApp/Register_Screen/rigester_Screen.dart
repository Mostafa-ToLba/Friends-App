
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mostafa1/modules/ShopApp/Register_Screen/Register_cubit/cubit.dart';
import 'package:mostafa1/modules/ShopApp/Register_Screen/Register_cubit/states.dart';
import 'package:mostafa1/shared/components/components.dart';

class RegisterScreen extends StatelessWidget {
    RegisterScreen({Key? key}) : super(key: key);
   var emailController =TextEditingController();
   var passwordController =TextEditingController();
    var phoneController =TextEditingController();
    var userNameController =TextEditingController();
    var formKey = GlobalKey<FormState>();

   @override
   Widget build(BuildContext context) {
     return BlocProvider(
       create: (BuildContext context) =>ShopRegisterCubit(ShopRegisterCubitInitialState()),
       child: BlocConsumer<ShopRegisterCubit,ShopRegisterCubitStates>(
         listener: (BuildContext context, state) {  },
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
                           'register now to browse our hot offers',
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
                           suffix: ShopRegisterCubit.get(context).Suffix,
                           isPassword: ShopRegisterCubit.get(context).UnvisibleBassword,
                           suffixPressed: ()
                           {
                             ShopRegisterCubit.get(context).ChangeSuffix();
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
                           condition: state is! ShopRegisterCubitLoadingState,
                           builder: (BuildContext context)=>
                             defultButton(
                               height: 50.0,
                               backGround: Colors.blue,
                               width: 400, text:'Register',
                               function: ()
                               {
                                 if(formKey.currentState!.validate())
                                 ShopRegisterCubit.get(context).UserRegister(
                                     Email: emailController.text,
                                     Password: passwordController.text,
                                     name: userNameController.text,
                                     phone: phoneController.text);
                                 if(ShopRegisterCubit.get(context).userRegister!.status==true)
                                 {
                                   showToast('${ShopRegisterCubit.get(context).userRegister!.message}', Toaststate.Success,gravity: ToastGravity.CENTER);
                                 }else
                                   {
                                     showToast('${ShopRegisterCubit.get(context).userRegister!.message}', Toaststate.Error,gravity: ToastGravity.CENTER);
                                   }
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