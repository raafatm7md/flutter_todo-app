import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';
import '../screens/archive_tasks.dart';
import '../screens/done_tasks.dart';
import '../screens/new_tasks.dart';
part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TasksInitial());

  static TasksCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    const NewTasksScreen(),
    const DoneTasksScreen(),
    const ArchivedTasksScreen(),
  ];
  List<String> titles = ['Tasks', 'Done Tasks', 'Archived Tasks'];

  void changeIndex(int index){
    currentIndex = index;
    emit(TasksChangeBottomNavBar());
  }

  late Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archiveTasks = [];

  void createDatabase() {
    openDatabase('todo.db', version: 1,
        onCreate: (database, version) {
          database
              .execute(
              'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
              .then((value) {
            print("Table created");
          }).catchError((e) {
            print(e.toString());
          });
        }, onOpen: (database) {
          getDataFromDatabase(database);
          print("Database opened");
        }).then((value) {
          database = value;
          emit(TasksCreateDataBase());
    });
  }

  insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database.transaction((txn) async {
      await txn
          .rawInsert(
          'INSERT INTO Tasks(title, date, time, status) VALUES("$title", "$date", "$time", "new")')
          .then((value) {
        print("$value inserted successfully");
        emit(TasksInsertDataBase());
        getDataFromDatabase(database);
      }).catchError((e) {
        print(e.toString());
      });
      return null;
    });
  }

  void getDataFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archiveTasks = [];

    emit(TasksGetDataBaseLoading());
    database.rawQuery('SELECT * FROM Tasks').then((value) {
      value.forEach((element) {
        if(element['status'] == 'new'){
          newTasks.add(element);
        } else if (element['status'] == 'done'){
          doneTasks.add(element);
        } else {
          archiveTasks.add(element);
        }
      });
      emit(TasksGetDataBase());
    });
  }

  void updateDate({
    required String status,
    required int id,
}){
    database.rawUpdate('UPDATE Tasks SET status = ? WHERE id = ?',
    [status, id]).then((value) {
      getDataFromDatabase(database);
      emit(TasksUpdateDataBase());
    });
  }

  void deleteDate({
    required int id,
}){
    database.rawDelete('DELETE FROM Tasks WHERE id = ?',
    [id]).then((value) {
      getDataFromDatabase(database);
      emit(TasksDeleteDataBase());
    });
  }

  bool isBottomSheetOpened = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({
    required bool isShow,
    required IconData icon
}){
    isBottomSheetOpened = isShow;
    fabIcon = icon;
    emit(TasksChangeBottomSheetState());
  }
}
