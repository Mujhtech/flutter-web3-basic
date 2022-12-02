import 'dart:convert';

class Forum {
  String owner;
  String message;
  Forum({
    required this.owner,
    required this.message,
  });

  Forum copyWith({
    String? owner,
    String? message,
  }) {
    return Forum(
      owner: owner ?? this.owner,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'owner': owner,
      'message': message,
    };
  }

  factory Forum.fromMap(List data) {
    return Forum(
      owner: data[2].toString(),
      message: data[3],
    );
  }

  static List<Forum> fromMaps(List data) {
    final List<Forum> forums = [];
    for (final item in data) {
      final castData = item as List;
      final state = Forum.fromMap(castData);
      forums.add(state);
    }
    return forums;
  }

  String toJson() => json.encode(toMap());

  factory Forum.fromJson(String source) => Forum.fromMap(json.decode(source));

  @override
  String toString() => 'Forum(owner: $owner, message: $message)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Forum && other.owner == owner && other.message == message;
  }

  @override
  int get hashCode => owner.hashCode ^ message.hashCode;
}
