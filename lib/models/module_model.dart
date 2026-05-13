class ModuleModel {
  final String lessonId;
  final String title;
  final String description;
  final String category;
  final String mediaUrl;
  final String difficultyLevel;
  final int estimatedDuration;

  ModuleModel({
    required this.lessonId,
    required this.title,
    required this.description,
    required this.category,
    required this.mediaUrl,
    required this.difficultyLevel,
    required this.estimatedDuration,
  });

  factory ModuleModel.fromFirestore(Map<String, dynamic> data, String id) {
    return ModuleModel(
      lessonId: id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      category: data['category'] ?? '',
      mediaUrl: data['media_url'] ?? '',
      difficultyLevel: data['difficulty_level'] ?? 'easy',
      estimatedDuration: data['estimated_duration'] ?? 5,
    );
  }
}