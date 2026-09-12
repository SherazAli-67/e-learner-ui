enum CourseStatus {
  enrolled,
  inProgress,
  completed,
}

class Course {
  final String id;
  final String title;
  final String provider;
  final String imageAsset;
  final int lessons;
  final double rating;
  final String ratingCount;
  final String duration;
  final String about;
  final List<String> learnings;
  final CourseStatus status;
  final double progress;

  const Course({
    required this.id,
    required this.title,
    required this.provider,
    required this.imageAsset,
    required this.lessons,
    required this.rating,
    required this.ratingCount,
    required this.duration,
    required this.about,
    required this.learnings,
    required this.status,
    this.progress = 0,
  });
}
