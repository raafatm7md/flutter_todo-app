part of 'tasks_cubit.dart';

@immutable
abstract class TasksState {}

class TasksInitial extends TasksState {}

class TasksChangeBottomNavBar extends TasksState {}

class TasksCreateDataBase extends TasksState {}

class TasksGetDataBaseLoading extends TasksState {}

class TasksGetDataBase extends TasksState {}

class TasksInsertDataBase extends TasksState {}

class TasksUpdateDataBase extends TasksState {}

class TasksDeleteDataBase extends TasksState {}

class TasksChangeBottomSheetState extends TasksState {}
