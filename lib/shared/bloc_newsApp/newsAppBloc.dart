
  import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mostafa1/modules/NewsApp/business_screen/business.dart';
import 'package:mostafa1/modules/NewsApp/science_screen/scienceScreen.dart';
import 'package:mostafa1/modules/NewsApp/settings_screen/settingsScreen.dart';
import 'package:mostafa1/modules/NewsApp/sports_screen/sportsScreen.dart';
import 'package:mostafa1/shared/bloc_newsApp/newsAppStates.dart';
import 'package:mostafa1/shared/network/remote/dioHelper.dart';

class NewsCubit extends Cubit<NewsCubitStates> {
  NewsCubit(initialState) : super(initialState);

  static NewsCubit get(context) => BlocProvider.of(context);

   List<Widget>Screens =[
     technologyScreen(),
     SportsScreen(),
     entertainmentScreen(),
     SettingsScreen(),
   ];

  int currentIndex= 0;
  List<BottomNavigationBarItem> BottomNavIcons = [
    BottomNavigationBarItem(
      label: 'technology',
      icon: Icon(
        Icons.laptop_chromebook,
      ),
    ),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.sports_tennis,
        ),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.sports_esports_outlined,
        ),
      label: 'Entertainment',
    ),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.settings,
        ),
      label: 'Settings',
    ),
  ];

   void changeNavBar(index)
   {
     currentIndex=index;
     emit(ChangeNavBarState());
     if(index==1)
       getSports();
     if(index==2)
       getScience();
   }

   List<dynamic>technology=[];
   void getBusiness() {
     if (technology.length == 0) {
       emit(TechnologyLoadingState());
       DioHelper.GetData(
           url: 'v2/top-headlines',
           query: {
             'country': 'eg',
             'category': 'technology',
             'apiKey': '0c5fac955caa4f16821d8befb01ffe76',
           }
       ).then((value) {
         technology = value.data['articles'];
         //print(value.data.toString());
         emit(GetTechnologySuccessState());
       }).catchError((error) {
         print(error.toString());
         emit(GetTechnologyErrorState(error));
       });
     }else
       {
     }
   }

  List<dynamic>Sports=[];
  void getSports()
  {
    emit(SportsLoadingState());

    if(Sports.length==0)
    {
      DioHelper.GetData(
          url: 'v2/top-headlines',
          query: {
            'country': 'eg',
            'category': 'sports',
            'apiKey': '0c5fac955caa4f16821d8befb01ffe76',
          }
      ).then((value) {
        Sports=value.data['articles'];
        //print(value.data.toString());
        emit(GetSportsSuccessState());

      }).catchError((error) {
        print(error.toString());
        emit(GetSportsErrorState(error));
      });
    }else
      {
        emit(GetSportsSuccessState());
      }

  }

  List<dynamic>entertainment=[];
  void getScience()
  {
    if(entertainment.length==0)
    {
      emit(EntertainmentLoadingState());
      DioHelper.GetData(
          url: 'v2/top-headlines',
          query: {
            'country': 'eg',
            'category': 'entertainment',
            'apiKey': '0c5fac955caa4f16821d8befb01ffe76',
          }
      ).then((value) {
        entertainment=value.data['articles'];
        //print(value.data.toString());
        emit(GetEntertainmentSuccessState());

      }).catchError((error) {
        print(error.toString());
        emit(GetEntertainmentErrorState(error));
      });
    }else
    {
      emit(GetEntertainmentSuccessState());
    }

  }


  List<dynamic>Search=[];
   getSearch(String value)
  {
      emit(SearchLoadingState());
    DioHelper.GetData(
        url: 'v2/everything',
        query: {
          'q': '$value',
          'apiKey': '0c5fac955caa4f16821d8befb01ffe76',
        }
    ).then((value) {
      Search=value.data['articles'];
      emit(GetSearchSuccessState());

    }).catchError((error) {
      print(error.toString());
      emit(GetSearchErrorState(error));
    });

    }

  }

