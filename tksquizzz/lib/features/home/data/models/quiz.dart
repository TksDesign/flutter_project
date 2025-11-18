class Quiz {
  final int id;
  final String title;
  final String description;
  final String difficulty;
  final String category;
  final String imageUrl;
  final int durationMinutes;
  final bool isActive;
  final DateTime createdAt;

  const Quiz({
    required this.id,
    required this.title,
    required this.description,
    required this.difficulty,
    required this.category,
    required this.imageUrl,
    required this.durationMinutes,
    required this.isActive,
    required this.createdAt,
  });
  // CopyWith manuel
  Quiz copyWith({
    int? id,
    String? title,
    String? description,
    String? difficulty,
    String? category,
    String? imageUrl,
    int? durationMinutes,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return Quiz(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        difficulty: difficulty ?? this.difficulty,
        category: category ?? this.category,
        imageUrl: imageUrl ?? this.imageUrl,
        durationMinutes: durationMinutes ?? this.durationMinutes,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt);
  }
// comprendre le type de rtour superbase 

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      difficulty: json['difficulty'] as String,
      category: json['category'] as String,
      imageUrl: json['image_url'] as String,
      durationMinutes: json['duration_minutes'] as int,
      isActive: json['is_active'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
// convertir les quiz en map pour envoie 
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'difficulty': difficulty,
      'category': category,
      'imageUrl': imageUrl,
      'durationMinutes': durationMinutes,
      'isActive': isActive,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Quiz(id: $id, title: $title, difficulty: $difficulty)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Quiz && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
