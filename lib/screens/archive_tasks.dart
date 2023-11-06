import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/tasks_cubit.dart';
import '../widgets/task_builder.dart';

class ArchivedTasksScreen extends StatelessWidget {
  const ArchivedTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksCubit, TasksState>(
      listener: (context, state) {},
      builder: (context, state) {

        var tasks = TasksCubit.get(context).archiveTasks;

        return taskBuilder(tasks: tasks);
      },
    );
  }
}
