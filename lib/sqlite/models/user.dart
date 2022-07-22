const String tableUsers = 'users';

const List<String> userColumns = ['id', 'full_name', 'created_time'];

class User {
  final int? id;
  final String fullName;
  final DateTime createdTime;

  User({this.id, required this.fullName, required this.createdTime});

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        fullName = json['full_name'],
        createdTime = DateTime.parse(json['created_time'] as String);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'full_name': fullName,
      'created_time': createdTime.toIso8601String(),
    };
  }
}
