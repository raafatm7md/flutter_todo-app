import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/tasks_cubit.dart';
import '../widgets/task_builder.dart';

class DoneTasksScreen extends StatelessWidget {
  const DoneTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksCubit, TasksState>(
      listener: (context, state) {},
      builder: (context, state) {

        var tasks = TasksCubit.get(context).doneTasks;

        return taskBuilder(tasks: tasks);
      },
    );
  }
}
