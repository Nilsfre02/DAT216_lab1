import 'package:flutter/material.dart';
import 'package:lab1/model/task_handler.dart';
import 'package:lab1/pages/add_view.dart';
import 'package:lab1/widgets/status_icon.dart';
import 'package:provider/provider.dart';
import 'package:lab1/model/types.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => TaskHandler(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the app.
  @override
  Widget build(BuildContext context) {
    // Use a MaterialApp as the skeleton
    // for the app.
    return MaterialApp(
      theme: ThemeData(
        // This is the theme of your application.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      // The starting page of the app
      home: const MainView(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Things todo'),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            actions: _actions(context)),
        body: const TaskList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddView(),
              ),
            );
          },
          tooltip: 'Add todo',
          child: const Icon(Icons.add),
        )); // Scaffold
  }
}

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    var taskHandler = context.watch<TaskHandler>();
    var tasks = taskHandler.activeTasks;

    return ListView(children: [
      for (final task in tasks)
        ListTile(
          leading: StatusIcon(task),
          title: Text(task.title),
          onTap: () {
            taskHandler.toggleTask(task);
          },
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              taskHandler.deleteTask(task);
            },
          ),
        )
    ]);
  }
}

List<Widget> _actions(context) {
  return [_filterMenu(context)];
}

Widget _filterMenu(context) {
  var taskHandler = Provider.of<TaskHandler>(context, listen: false);

  return PopupMenuButton<FilterType>(
    initialValue: taskHandler.mode,
    onSelected: (FilterType item) {
      taskHandler.setMode(item);
    },
    itemBuilder: (BuildContext context) => [
      const PopupMenuItem<FilterType>(
          value: FilterType.all, child: Text('All')),
      const PopupMenuItem<FilterType>(
          value: FilterType.done, child: Text('Done')),
      const PopupMenuItem<FilterType>(
          value: FilterType.undone, child: Text('Undone')),
    ],
  );
}
