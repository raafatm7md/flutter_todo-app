import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/task_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/tasks_cubit.dart';

class NewTasksScreen extends StatelessWidget {
  const NewTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksCubit, TasksState>(
            listener: (context, state) {},
            builder: (context, state) {

              var tasks = TasksCubit.get(context).newTasks;

              return taskBuilder(tasks: tasks);
            },
          );
  }
}
