class Task {
  final String id;
  final String title;
  bool completed;

  // Constructor, where completed defaults to false
  Task({required this.id, required this.title, this.completed = false});

  // Special constructor to create a task from title only
  // Uses current date and time as id.
  Task.fromTitle(String title)
      : this(id: DateTime.now().toString(), title: title);

  // Convert a Task instance to a Map.
  // The map is a json representation of
  // the task object.
  Map<String, dynamic> toJson() => {
        _idKey: id,
        _titleKey: title,
        _completedKey: completed,
      };

  // Convert a Map to a Task instance
  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json[_idKey] as String,
        title: json[_titleKey] as String,
        completed: json[_completedKey] as bool,
      );

  // Toggle the status of the task
  void toggleCompleted() {
    completed = !completed;
  }

  // These constant strings are used to avoid having a lot
  // of strings spread through the code.
  // The '_' in the beginning of the name make them private
  static const _idKey = 'id';
  static const _titleKey = 'title';
  static const _completedKey = 'completed';
}
