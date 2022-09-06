
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mostafa1/model/Social-model/social-userModel.dart';
import 'package:mostafa1/modules/social-app/social-register-screen/social-registerCubit/social-registerStates.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterCubitStates>
{
  SocialRegisterCubit(SocialRegisterCubitStates SocialLRegisterInitialState) : super(SocialRegisterCubitInitialState());


  static SocialRegisterCubit get(context)=> BlocProvider.of(context);



 void UserRegister({
    required String email,
    required String password,
    required String phone,
    required String name,

  })
  {
    emit(SocialRegisterCubitLoadingState());
     FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value)
     {
       createUser(email: email,phone: phone,name: name,uId:value.user!.uid );
          print(value.user!.email);
          print(value.user!.uid);

     }).catchError((error)
     {
       emit(SocialRegisterCubitErrorState(error.toString()));
       print(error.toString());
     });

  }


  void createUser({
    required String email,
    required String phone,
    required String name,
    required String uId,
  })
  {
    socialUserModel userModel =socialUserModel(name: name,phone: phone,email: email,uId:uId,
    image:'https://image.freepik.com/free-photo/waist-up-shot-attractive-young-girlfriend-with-dark-straight-hair-soft-healthy-skin_273609-18318.jpg',
      cover: 'https://image.freepik.com/free-photo/full-length-portrait-pleased-amazing-woman-white-shoes-caucasian-girl-wears-casual-clothes-dancing_197531-20496.jpg',
      bio: 'add your bio',
    );

    FirebaseFirestore.instance.collection('users').doc(uId).set(userModel.toMap()).then((value)
    {
      emit(SocialCreateUserSuccessState());

    }).catchError((error)
    {
      emit(SocialCreateUserErrorState(error.toString()));
      print(error.toString());
    });

  }


  bool UnvisibleBassword=true ;
  IconData Suffix= Icons.visibility_off_rounded ;
  ChangeSuffix () {
    UnvisibleBassword = !UnvisibleBassword;
    UnvisibleBassword ? Suffix= Icons.visibility_off_rounded : Suffix =Icons.remove_red_eye_outlined;
    emit(SocialRegisterCubitChangeSuffixState());
  }
}
