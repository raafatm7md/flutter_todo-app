import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/task_item.dart';

Widget taskBuilder({required List<Map> tasks}) => tasks.isEmpty
    ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu,
              size: 100,
              color: Colors.grey,
            ),
            Text(
              'No Tasks Yet, Please Add Some Tasks',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            )
          ],
        ),
      )
    : ListView.separated(
        itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
        separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsetsDirectional.only(start: 20),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
            ),
        itemCount: tasks.length);
