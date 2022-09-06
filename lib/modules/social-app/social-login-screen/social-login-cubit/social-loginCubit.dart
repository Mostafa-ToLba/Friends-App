import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mostafa1/layout/socialapp-layout/socialCubit/socialCubit.dart';
import 'package:mostafa1/modules/social-app/social-login-screen/social-login-cubit/social-loginStates.dart';
import 'package:mostafa1/shared/components/constants.dart';


class SocialLoginCubit extends Cubit<SocialLoginStates>
{
  SocialLoginCubit(SocialLoginStates SocialLoginInitialState) : super(SocialLoginInitialState);


  static SocialLoginCubit get(context)=> BlocProvider.of(context);



  Future SignIN({
    @required String? email,
    @required String? password,context
  })
  async {
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email!, password: password!).then((value)
    {
      emit(SocialLoginSuccessState(value.user!.uid));
      uId = value.user!.uid;
    }).catchError((error)
    {
      emit(SocialLoginErrorState(error.toString()));
      print(error.toString());
    });

  }

  bool UnvisibleBassword=true ;
  IconData Suffix= Icons.visibility_off_rounded ;
  ChangeSuffix () {
    UnvisibleBassword = !UnvisibleBassword;
    UnvisibleBassword ? Suffix= Icons.visibility_off_rounded : Suffix =Icons.remove_red_eye_outlined;
    emit(SocialLoginChangeSuffixState());
     }
     }




