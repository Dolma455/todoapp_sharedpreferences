// ignore_for_file: public_member_api_docs, sort_constructors_first
class Fruits {
  final int? id;
  String fruit;
  String description;
  bool isSelected = false;
  Fruits({this.id, required this.fruit, required this.description});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fruit': fruit,
      'description': description
    };
  }

  factory Fruits.fromMap(Map<String, dynamic> map) {
    return Fruits(
      id: map['id'] != null ? map['id'] as int : 0,
      fruit: map['fruit'] as String,
      description: map['description'] as String,
    );
  }

  Fruits copyWith({
    int? id,
    String? fruit,
    String? description,
  }) {
    return Fruits(
      id: id ?? this.id,
      fruit: fruit ?? this.fruit,
      description: description ?? this.description,
    );
  }

  @override
  String toString() {
    return 'Fruits(id: $id, fruit: $fruit, description: $description, isSelected: $isSelected)';
  }
}
