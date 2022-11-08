class System {
  //int id
  final int? id;
  final String name;

  System({this.id, required this.name});

  factory System.fromMap(Map<String, dynamic> json) =>
      System(id: json['id'], name: json['name']);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}
