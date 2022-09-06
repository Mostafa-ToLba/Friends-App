import 'dart:async';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mostafa1/shared/Bloc_todoApp/bloc.dart';
import 'package:mostafa1/shared/Bloc_todoApp/states.dart';
import 'package:mostafa1/shared/components/components.dart';
import 'package:sqflite/sqflite.dart';

class HomeLayoutWithBloc extends StatelessWidget{
  HomeLayoutWithBloc({Key? key}) : super(key: key);



  var scaffoldkey =GlobalKey<ScaffoldState>();
  var formkary= GlobalKey<FormState>();

  var taskController =TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(InitialState())..createDataBase(),
      child: BlocConsumer<AppCubit,BlocStates>(
        listener: (BuildContext context, state) {
          if (state is InsertToDatabaseState)
            {
              Navigator.pop(context);
            }

        },
        builder: (BuildContext context, Object? state) {
         return Scaffold(
           backgroundColor: Colors.black,
            key: scaffoldkey ,
            appBar: AppBar(
              backgroundColor: Colors.black12,
              title: Text(
                  '${AppCubit.get(context).Titles[AppCubit.get(context).CurrentIndex]}',
                      style:TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w800,
                      ) ,

              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.purple,

                child: Icon(
                  AppCubit.get(context).fabicon,
                  color: Colors.white,
                  size: 27,
                ),
                onPressed: () {
                  if (AppCubit.get(context).isBottomSheetOpen)
          {
          if (formkary.currentState!.validate()) {
            AppCubit.get(context). insertToDatabase(
              title: taskController.text,
              time: timeController.text,
              date: dateController.text,
            ).then((value) {

            });

          //  insertToDatabase(
            // title: taskController.text,
          //    time: timeController.text,
          //    date: dateController.text,
          //  ).then((value) {

          //                });
          //  Navigator.pop(context);
          AppCubit.get(context).isBottomSheetOpen = false;
          AppCubit.get(context).fabicon = Icons.edit;
          //  isBottomSheetOpen=false;
          //  setState(() {
          //  fabicon=Icons.edit;
          // });
          //              }
          }
          }
                    else {
                      // setState(() {
                      AppCubit.get(context).fabicon = Icons.add;
                      scaffoldkey.currentState!.showBottomSheet((context) =>

                          Form(

                            key: formkary,
                            child: Container(
                               color: Colors.black,
                              child: SingleChildScrollView (
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    defultformfield(
                                      textStyle:TextStyle(color: Colors.white) ,
                                      label: 'task title',
                                      prefix: Icons.assignment,
                                      controle: taskController,
                                      validate: (String value) {
                                        if (value.isEmpty) {
                                          return 'text must not be empty';
                                        }
                                        return null;
                                      },

                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    defultformfield(
                                        textStyle:TextStyle(color: Colors.white),
                                        prefix: Icons.watch_later_outlined,
                                        label: 'task time',
                                        controle: timeController,
                                        keyboard: TextInputType.datetime,
                                        ontap: () {
                                          showTimePicker(context: context,
                                              initialTime: TimeOfDay.now()).then((
                                              value) {
                                            print(value!.format(context));
                                            timeController.text =
                                                value.format(context).toString();
                                          });
                                        },
                                        validate: (String value) {
                                          if (value.isEmpty) {
                                            return 'time must not be empty';
                                          }
                                          return null;
                                        }
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    defultformfield(
                                        textStyle:TextStyle(color: Colors.white),
                                        prefix: Icons.calendar_today,
                                        label: 'task date',
                                        controle: dateController,
                                        keyboard: TextInputType.datetime,
                                        ontap: () {
                                          showDatePicker(context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime.parse('2021-10-30'),
                                          ).then((value) {
                                            dateController.text = DateFormat.yMMMd().format(value!);
                                          });
                                        },
                                        validate: (String value) {
                                          if (value.isEmpty) {
                                            return 'date must not be empty';
                                          }
                                          return null;
                                        }
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )).closed.
                      then((value) {
                        AppCubit.get(context).IsButtonSheetopen(
                            isOpen: false, icon: Icons.edit);
                      });
                      AppCubit.get(context).IsButtonSheetopen(
                          isOpen: true, icon: Icons.add);
                      //});
                    }
                  }

            ),
            bottomNavigationBar: BottomNavigationBar(
              enableFeedback: true,
              unselectedItemColor: Colors.white,
              selectedItemColor: Colors.purple,
              backgroundColor: Colors.black12,
              currentIndex:AppCubit.get(context).CurrentIndex ,
              onTap: (index){
                AppCubit.get(context).changeNavBar(index);
              },
              items:
              [
                BottomNavigationBarItem(icon: Icon(
                  Icons.menu,

                ),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(icon: Icon(
                  Icons.assignment_turned_in_outlined,
                ),
                  label: 'Done',

                ),
                BottomNavigationBarItem(icon: Icon(
                  Icons.apps,
                ),
                  label: 'Archived',

                ),

              ],
            ),
            body: ConditionalBuilder(
              condition:(state is! AppLoader),
              builder: (context)=> AppCubit.get(context).Screens[AppCubit.get(context).CurrentIndex],
              fallback: (context)=> Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                  backgroundColor: Colors.grey,
                ),
              ),
            ),

          );
        },

      ),
    );
  }



}




