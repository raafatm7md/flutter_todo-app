import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 import 'package:intl/intl.dart';
import '../cubit/tasks_cubit.dart';

class HomeLayout extends StatelessWidget {
  HomeLayout({super.key});

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksCubit()..createDatabase(),
      child: BlocConsumer<TasksCubit, TasksState>(
        listener: (context, state) {
          if (state is TasksInsertDataBase) Navigator.pop(context);
        },
        builder: (context, state) {
          TasksCubit cubit = TasksCubit.get(context);

          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
            ),
            body: state is TasksGetDataBaseLoading
                ? const Center(child: CircularProgressIndicator())
                : cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Tasks"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle_outline), label: "Done"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined), label: "Archive"),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBottomSheetOpened) {
                  if (formKey.currentState!.validate()) {
                    cubit.insertToDatabase(
                        title: titleController.text,
                        time: timeController.text,
                        date: dateController.text);
                  }
                } else {
                  scaffoldKey.currentState
                      ?.showBottomSheet(
                          (context) =>
                          Container(
                            // color: Colors.grey[100],
                            padding: const EdgeInsets.all(20.0),
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    controller: titleController,
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "title must be not empty";
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                        label: Text("Task title"),
                                        prefixIcon: Icon(Icons.title)),
                                  ),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  TextFormField(
                                    controller: timeController,
                                    keyboardType: TextInputType.datetime,
                                    onTap: () {
                                      showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now())
                                          .then((value) {
                                        timeController.text =
                                            value!.format(context).toString();
                                      });
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "time must be not empty";
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                        label: Text("Task time"),
                                        prefixIcon:
                                        Icon(Icons.watch_later_outlined)),
                                  ),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  TextFormField(
                                    controller: dateController,
                                    keyboardType: TextInputType.datetime,
                                    onTap: () {
                                      showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate:
                                          DateTime.parse('2023-12-31'))
                                          .then((value) {
                                        dateController.text =
                                            DateFormat.yMMMd().format(value!);
                                      });
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "date must be not empty";
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                        label: Text("Task date"),
                                        prefixIcon: Icon(Icons.calendar_today)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      elevation: 20.0)
                      .closed
                      .then((value) {
                        cubit.changeBottomSheetState(isShow: false, icon: Icons.edit);
                  });
                  cubit.changeBottomSheetState(isShow: true, icon: Icons.add);
                }
              },
              child: Icon(cubit.fabIcon),
            ),
          );
        },
      ),
    );
  }
}
