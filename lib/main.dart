
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mostafa1/layout/shopAppLayout/shopLayoutCubit/cubit.dart';
import 'package:mostafa1/layout/shopAppLayout/shopLayoutCubit/states.dart';
import 'package:mostafa1/layout/socialapp-layout/socialCubit/socialCubit.dart';
import 'package:mostafa1/layout/socialapp-layout/socialCubit/socialCubitStates.dart';
import 'package:mostafa1/layout/socialapp-layout/socialapp-layoutScreen.dart';
import 'package:mostafa1/layout/todo_app/todoLayoutWithBloc.dart';
import 'package:mostafa1/modules/ShopApp/Shop_LoginScreen/shop_LoginScreen/LoginScreen.dart';
import 'package:mostafa1/modules/TodoAppScreen/new_tasks/new_task.dart';
import 'package:mostafa1/modules/social-app/social-login-screen/social-LoginScreen.dart';
import 'package:mostafa1/shared/Bloc_todoApp/bloc.dart';
import 'package:mostafa1/shared/Bloc_todoApp/states.dart';
import 'package:mostafa1/shared/bloc_newsApp/newsAppBloc.dart';
import 'package:mostafa1/shared/bloc_newsApp/newsAppStates.dart';
import 'package:mostafa1/shared/bloc_observer/bloc_observer.dart';
import 'package:mostafa1/shared/components/constants.dart';
import 'package:mostafa1/shared/network/local/cashe_helper.dart';
import 'package:mostafa1/shared/network/remote/dioHelper.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'layout/newsApp_layout/newsapp_layout.dart';
//fad9d5fa-748e-4117-ac79-ed08757b275e
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  DioHelper.Init();

  await CasheHelper.init();

   dynamic dark = CasheHelper.getData(key:'isDark');
  // dynamic onBoarding = CasheHelper.getData(key:'onBoarding');
  Widget widget ;
   //token = CasheHelper.getData(key:'token');
   //print(token);
   uId = CasheHelper.getData(key: 'uId');
  //socialApp
  if(uId!= null)
  {
    widget = SocialLayoutScreen();
  }else
    widget = SocialLoginScreen();

  //shopApp
 // if (onBoarding !=null)
 // {
  //  if(token!=null)
  //  widget = ShopLayoutScreen();
  //  else
   //   widget =ShopLoginScreen();

 // }else widget = OnboardingScreen();

  //cloudMesssaging
  OneSignal.shared.init('fad9d5fa-748e-4117-ac79-ed08757b275e', iOSSettings: {
    OSiOSSettings.autoPrompt: false,
    OSiOSSettings.inAppLaunchUrl: false
  });
  OneSignal.shared
      .setInFocusDisplayType(OSNotificationDisplayType.notification);
  await OneSignal.shared
      .promptUserForPushNotificationPermission(fallbackToSettings: true);
  //

  runApp(MyApp(dark: dark,startingWidget: widget));
}
 class MyApp extends StatelessWidget {
   bool dark;
   final Widget startingWidget;
     MyApp({required this.dark,required this.startingWidget});

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>NewsCubit(IinitialState())..getBusiness(),),
        BlocProvider(create: (context)=> AppCubit(InitialState())..MakeItDark(
    fromShared: dark),
         ),
        BlocProvider(create: (context)=> ShopLayoutCubit(ShopLayoutInitialState())..getHomeData()..getCategories()..getFavorites()..getProfileData(),
    ),
        BlocProvider(
         create: (context)=> SocialCubit(SocialCubitInitialState())..getNotify()..getPosts2()..sendToeveryOne()..getUserDate(uId))
      ],
        child: BlocConsumer<AppCubit,BlocStates>(
          listener: (BuildContext context, state) {  },
          builder: (BuildContext context, Object state)
          {
            return MaterialApp(
              title: 'TodoApp',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(

                progressIndicatorTheme:ProgressIndicatorThemeData(
                  color: Colors.blue,
                ) ,
                textTheme: TextTheme(
                  bodyText1: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  subtitle1: TextStyle(
                    color: Colors.black,
                  ),
                ),
                primarySwatch: Colors.blue,

                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.blue,
                  elevation: 0.0,
                ),
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: AppBarTheme(
                  color: Colors.white,
                  elevation: 0.0,
                  iconTheme: IconThemeData(
                    color: Colors.black,
                  ),
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark,

                  ),
                ),
              ) ,
              darkTheme: ThemeData(

                progressIndicatorTheme:ProgressIndicatorThemeData(
                  color: Colors.purple,
                ) ,
                textTheme: TextTheme(
                  bodyText1: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  subtitle1: TextStyle(
                    color: Colors.white,
                  ),
                ),
                primarySwatch: Colors.purple,
                scaffoldBackgroundColor: HexColor('0D0D0D'),
                appBarTheme: AppBarTheme(
                  actionsIconTheme: IconThemeData(
                    color: Colors.white,
                  ),
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),

                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: HexColor('0D0D0D'),
                    statusBarIconBrightness: Brightness.light,
                  ),
                  backgroundColor: HexColor('0D0D0D'),
                  elevation: 0.0,
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.purple,
                  backgroundColor: HexColor('0D0D0D'),
                  unselectedItemColor: Colors.grey,
                ),
              ),
              themeMode: AppCubit.get(context).isDark ? ThemeMode.light : ThemeMode.dark ,
              home: NewsAppLayout(),
            );
          },
        ),
      );
  }
}
