
class TodoModel{
  final int userId;
  final int id;
  final String title;
  final bool completed;

  TodoModel(this.userId, this.id, this.title, this.completed);

  factory TodoModel.fromJson(Map<String, dynamic>map){
    return TodoModel(map["userId"], map["id"], map["title"], map["completed"]);
  }
}