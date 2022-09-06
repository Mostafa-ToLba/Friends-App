import 'package:flutter/material.dart';
import 'package:mostafa1/modules/ShopApp/OnBoarding_Screen/Onboarding.dart';
import 'package:mostafa1/shared/components/components.dart';
import 'package:mostafa1/shared/network/local/cashe_helper.dart';

List<Map> tasks =[];

 SignOut(context)=>
  {
    CasheHelper.removeData(key: 'token').then((value)
    {
      print( '${token}before removed');
      print('token is removed');

        NavigateAndFinsh(context, OnboardingScreen());
    }
    ),
  };

String token = '';
String uId = '';

