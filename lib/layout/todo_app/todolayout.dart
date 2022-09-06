import 'dart:async';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mostafa1/modules/TodoAppScreen/archived_tasks/archived_tasks.dart';
import 'package:mostafa1/modules/TodoAppScreen/done_tasks/done_tasks.dart';
import 'package:mostafa1/modules/TodoAppScreen/new_tasks/new_task.dart';
import 'package:mostafa1/shared/components/components.dart';
import 'package:mostafa1/shared/components/constants.dart';
import 'package:sqflite/sqflite.dart';

class HomeLayout extends StatefulWidget {
   HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int CurrentIndex =0;

  List<Widget>Screens = [
    NewTask(),
    DoneTasks(),
    ArchivedTasks(),
  ];
    late Database database ;
   var scaffoldkey =GlobalKey<ScaffoldState>();
   var formkary= GlobalKey<FormState>();
bool isBottomSheetOpen =false ;
  IconData fabicon =Icons.edit;
  var taskController =TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();


@override
  void initState() {
    super.initState();
    createDataBase() ;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey ,
      appBar: AppBar(
        title: Text(
          'Home'
        ),
      ),
      floatingActionButton: FloatingActionButton(

        child: Icon(
          fabicon,
        ),
          onPressed: () {
          if(isBottomSheetOpen)
            {
              if(formkary.currentState!.validate())
                {
                  insertToDatabase(
                    title: taskController.text,
                    time: timeController.text,
                    date: dateController.text,
                  ).then((value) {

                  });
                  Navigator.pop(context);
                  isBottomSheetOpen=false;
                  setState(() {
                    fabicon=Icons.edit;
                  });
                }
            }
          else {

            setState(() {
              fabicon=Icons.add;
              scaffoldkey.currentState!.showBottomSheet((context) => Form(
                key: formkary,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    defultformfield(
                      label: 'task title',
                      prefix: Icons.assignment,
                      controle: taskController ,
                      validate: (String value){
                        if(value.isEmpty)
                          {
                            return'text must not be empty';
                          }
                         return null ;
                      },

                    ),
                    SizedBox(
                      height: 10,
                    ),
                    defultformfield(
                      prefix: Icons.watch_later_outlined,
                      label: 'task time',
                        controle: timeController,
                        keyboard: TextInputType.datetime,
                        ontap: (){
                        showTimePicker(context: context,
                            initialTime: TimeOfDay.now()).then((value){

                              print(value!.format(context));
                              timeController.text=value.format(context).toString();
                        });

                        },
                      validate: (String value){
                        if(value.isEmpty)
                        {
                          return'time must not be empty';
                        }
                        return null ;
                      }
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    defultformfield(
                        prefix: Icons.calendar_today,
                        label: 'task date',
                        controle: dateController,
                        keyboard: TextInputType.datetime,
                        ontap:()
                        {
                           showDatePicker(context: context,
                               initialDate: DateTime.now(),
                               firstDate: DateTime.now(),
                               lastDate: DateTime.parse('2021-10-05'),
                           ).then((value) {
                             dateController.text=DateFormat.yMMMd().format(value!);
                           });
                        },
                        validate: (String value){
                          if(value.isEmpty)
                          {
                            return'date must not be empty';
                          }
                          return null ;
                        }
                    ),
                  ],
                ),
              )).closed.
              then((value)
              {
                isBottomSheetOpen=false;
                setState(() {
                  fabicon=Icons.edit;
                });
              } );
              isBottomSheetOpen=true;
            });
          }
            }


      ),
        bottomNavigationBar: BottomNavigationBar(

          onTap: (index){
            setState(() {
              CurrentIndex= index ;
              //print(index);
            });

          },
          currentIndex: CurrentIndex ,

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
          condition:tasks.length>0,
        builder: (context)=> Screens[CurrentIndex],
        fallback: (context)=> Center(
          child: CircularProgressIndicator(
             color: Colors.blue,
            backgroundColor: Colors.grey,
          ),
        ),
      ),

    );
  }

  void createDataBase()
  async{
     database = await openDatabase('todo.db',version: 1,

    onCreate: (database,version){

      print('database created');
       database.execute('CREATE TABLE Tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)').then((value){
        print('table created');
      }).catchError((error){
        print('error when creating table ${error.toString()}');
      });
      },
      onOpen: (database){
        getDataFromDatabase(database).then((value){
          tasks =value ;
          print(tasks);
        });
        print('database opened');
      },
    );
  }

  Future insertToDatabase (
      {  title,
         date,
         time,
      })
   async {
      return await database.transaction((txn) {
      txn.rawInsert('INSERT INTO tasks (title,date,time,status) VALUES ("${title}","${date}","${time}","new")').then((value){

       print('$value inserted successfully');

      }).catchError((error){
           print('error when inserting new raw ${error.toString()}');
      });
      return Future(() => null);
    });
  }
  
  Future<List<Map>> getDataFromDatabase(database) async{
  
   return await database.rawQuery('SELECT * FROM tasks');
  }
  
}
