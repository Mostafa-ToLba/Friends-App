
 import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mostafa1/modules/TodoAppScreen/archived_tasks/archived_tasks.dart';
import 'package:mostafa1/modules/TodoAppScreen/done_tasks/done_tasks.dart';
import 'package:mostafa1/modules/TodoAppScreen/new_tasks/new_task.dart';
import 'package:mostafa1/shared/Bloc_todoApp/states.dart';
import 'package:mostafa1/shared/network/local/cashe_helper.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<BlocStates>{
  AppCubit(BlocStates initialState) : super(InitialState());

   static AppCubit get(context) => BlocProvider.of(context);

  int CurrentIndex =0;
  late Database database ;
  List<Map> newtasks =[];
  List<Map> donetasks =[];
  List<Map> archivedtasks =[];

  bool isBottomSheetOpen =false ;
  IconData fabicon =Icons.edit;

  List<Widget>Screens = [
    NewTask(),
    DoneTasks(),
    ArchivedTasks(),
  ];

  void changeNavBar(int index){

    CurrentIndex=index ;
    emit(ButtonNavBarState());
    print(index);
  }
  List<String> Titles =
  [
    'Hello, This Is Your New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void IsButtonSheetopen({
  @required bool? isOpen ,
  @required IconData? icon ,

}){

    isBottomSheetOpen = isOpen! ;
    fabicon = icon! ;
    emit(IsButtonSheetOpen());
  }

 void createDataBase()
   {
    openDatabase('todo.db',version: 1,

     onCreate: (database,version){

       print('database created');
       database.execute('CREATE TABLE Tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)').then((value){
         print('table created');
       }).catchError((error){
         print('error when creating table ${error.toString()}');
       });
     },
     onOpen: (database){
       getDataFromDatabase(database);
       print('database opened');
     },
   ).then((value){
     database = value ;
     emit(CreateDatabaseState());
     return 'no error on creating database' ;
   });
 }

   insertToDatabase (
     {  title,
        date,
        time,
     })
 async {
     await database.transaction((txn) {
     txn.rawInsert('INSERT INTO tasks (title,date,time,status) VALUES ("${title}","${date}","${time}","new")')
         .then((value){
       print('$value inserted successfully');
       emit(InsertToDatabaseState());
       getDataFromDatabase(database);


     }).catchError((error){
       print('error when inserting new raw ${error.toString()}');
     });
     return Future(() => null);
   });
 }

 void getDataFromDatabase(database){

    newtasks =[];
    donetasks =[];
    archivedtasks =[];

    emit(AppLoader());

    database.rawQuery('SELECT * FROM tasks').then((value){
     value.forEach((element) {

       if(element['status']=='new')
         newtasks.add(element);
       else if (element['status']=='done')
         donetasks.add(element);
       else
         archivedtasks.add(element);

     });
     emit(GetDatabaseState());
   });
 }
  void UpdateDatabase({
    String? status ,
    int? id ,
  })
  {
        database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id ]).then((value) {
          getDataFromDatabase(database);
        emit(UpdateDataState());
      });
  }


  void DeleteDatabase({
  @required int? id ,
})
  async{
    await database
        .rawDelete('DELETE FROM tasks WHERE id = ?', [id]);
    emit(DeleteFromDatabaseState());
    getDataFromDatabase(database);
  }


  bool isDark= false;
  void MakeItDark({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(MakeItDarkState());
    } else {
      isDark = !isDark;
      CasheHelper.putBoolean(key:'isDark', value: isDark )!.then((value)
      {
        emit(MakeItDarkState());
      });
    }
  }

  bool textchange = true;
  void ChangeText()
   {
     textchange=!textchange;
     emit(ChangeTextState());
   }


 }

