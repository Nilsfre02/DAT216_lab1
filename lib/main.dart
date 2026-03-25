import 'package:flutter/material.dart';
import 'package:lab1/model/task_handler.dart';
import 'package:provider/provider.dart';


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
          ),

          body: const TaskList(),

         ); // Scaffold
      }
}

class TaskList extends StatelessWidget {
   const TaskList({super.key});

   @override
      Widget build(BuildContext context) {
         return ListView(children: [
            ListTile(title: Text('DAT216/TIG091')),
            ListTile(title: Text('Lab1 Todos')),
            ListTile(title: Text('En rad till')),
         ]);
      }
}