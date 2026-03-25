import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lab1/model/task.dart';
import 'package:lab1/model/types.dart';
import 'package:path_provider/path_provider.dart';

class TaskHandler extends ChangeNotifier {
  TaskHandler() {
    _readTasks();
  }

  final List<Task> _tasks = [];

  FilterType _mode = FilterType.all;

  FilterType get mode => _mode;

  void setMode(FilterType mode) {
    _mode = mode;
    notifyListeners();
  }

  List<Task> get activeTasks {
    switch (_mode) {
      case FilterType.all:
        return allTasks;
      case FilterType.done:
        return completedTasks;
      case FilterType.undone:
        return openTasks;
    }
  }

  List<Task> get allTasks => _tasks;

  List<Task> get completedTasks {
    List<Task> completed = [];

    for (final task in _tasks) {
      if (task.completed) {
        completed.add(task);
      }
    }
    return completed;
  }

  List<Task> get openTasks {
    List<Task> open = [];

    for (final task in _tasks) {
      if (!task.completed) {
        open.add(task);
      }
    }
    return open;
  }

  var _taskNbr = 0;

  List<Task> testTasks() {
    if (_tasks.length <= 6) {
      for (int i = 0; i < 3; i++) {
        _tasks.add(Task.fromTitle('Task $_taskNbr'));
        _taskNbr++;
      }
    }
    return _tasks;
  }

  void addTask(String title) {
    final newTask = Task.fromTitle(title);
    _tasks.add(newTask);
    notifyListeners();
    writeTasks();
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
    writeTasks();
  }

  void toggleTask(Task task) {
    task.toggleCompleted();
    notifyListeners();
    writeTasks();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/tasks.json');
  }

  void _readTasks() async {
    try {
      final file = await _localFile;
      // Read the file
      String contents = await file.readAsString();
      List<dynamic> jsonData = jsonDecode(contents);
      _tasks.addAll(jsonData.map((item) => Task.fromJson(item)).toList());
      notifyListeners();
    } catch (e) {
      // If encountering an error, return an empty list
      _tasks.clear();
      notifyListeners();
    }
  }

  Future<File> writeTasks() async {
    final file = await _localFile;
    // Convert tasks to json and write to file
    String json = jsonEncode(_tasks.map((task) => task.toJson()).toList());
    return file.writeAsString(json);
  }
}
