import 'package:e_learner/core/app_icons.dart';
import 'package:e_learner/core/models/course.dart';

class AppData {
  static const courses = <Course>[
    Course(
      id: '1',
      title: 'Fundamentals of UX Design (Google)',
      provider: 'Google',
      imageAsset: AppIcons.uiuxCourseImg,
      lessons: 9,
      rating: 4.8,
      ratingCount: '3.6k+',
      duration: '2 Weeks',
      about: 'Learn the fundamentals of user experience design from Google experts. Build a strong foundation in UX research, wireframing, and usability testing.',
      learnings: [
        'Understand core UX design principles',
        'Create wireframes and user flows',
        'Run basic usability tests',
        'Apply design thinking to real projects',
      ],
      status: .inProgress,
      progress: 0.45,
    ),
    Course(
      id: '2',
      title: 'Finding projects as a Graphic Designer',
      provider: 'Google',
      imageAsset: AppIcons.graphicDesignerCourseImg,
      lessons: 9,
      rating: 4.7,
      ratingCount: '3.6k+',
      duration: '2 Weeks',
      about: 'Discover how to land graphic design projects and grow your freelance career. Learn portfolio tips, client outreach, and pricing strategies.',
      learnings: [
        'Build a standout design portfolio',
        'Find and pitch to clients',
        'Price your design services',
        'Manage client relationships',
      ],
      status: .enrolled,
      progress: 0,
    ),
    Course(
      id: '3',
      title: 'UI Design Essentials',
      provider: 'MIT',
      imageAsset: AppIcons.uiuxCourseImg,
      lessons: 12,
      rating: 4.6,
      ratingCount: '2.1k+',
      duration: '3 Weeks',
      about: 'Master the essentials of modern UI design including layout, typography, color systems, and interactive components.',
      learnings: [
        'Design consistent UI systems',
        'Apply typography and color theory',
        'Build reusable components',
        'Prototype interactive interfaces',
      ],
      status: .inProgress,
      progress: 0.7,
    ),
    Course(
      id: '4',
      title: 'Visual Design for Digital Products',
      provider: 'Google',
      imageAsset: AppIcons.graphicDesignerCourseImg,
      lessons: 8,
      rating: 4.9,
      ratingCount: '5.2k+',
      duration: '2 Weeks',
      about: 'Explore visual design techniques for digital products. Focus on hierarchy, spacing, and creating polished interfaces.',
      learnings: [
        'Create strong visual hierarchy',
        'Use spacing and grids effectively',
        'Design for accessibility',
        'Ship polished product visuals',
      ],
      status: .completed,
      progress: 1,
    ),
  ];

  static Course? courseById(String id) {
    for (final course in courses) {
      if (course.id == id) return course;
    }
    return null;
  }

  static List<Course> coursesByStatus(CourseStatus status) =>
      courses.where((course) => course.status == status).toList();
}
