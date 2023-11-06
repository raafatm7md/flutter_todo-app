import 'package:flutter/material.dart';
import 'package:flutter_app/cubit/tasks_cubit.dart';

Widget buildTaskItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (direction) {
        TasksCubit.get(context).deleteDate(id: model['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              child: Text('${model['time']}'),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${model['date']}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            IconButton(
              onPressed: () {
                TasksCubit.get(context)
                    .updateDate(status: 'done', id: model['id']);
              },
              icon: const Icon(Icons.check_box),
              color: Colors.green,
            ),
            IconButton(
                onPressed: () {
                  TasksCubit.get(context)
                      .updateDate(status: 'archive', id: model['id']);
                },
                icon: const Icon(Icons.archive),
                color: Colors.black45),
          ],
        ),
      ),
    );
