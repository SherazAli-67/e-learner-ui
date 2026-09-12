import 'package:e_learner/constants/string_const.dart';
import 'package:e_learner/core/app_colors.dart';
import 'package:e_learner/core/app_data.dart';
import 'package:e_learner/core/app_icons.dart';
import 'package:e_learner/core/app_textstyles.dart';
import 'package:e_learner/core/models/course.dart';
import 'package:e_learner/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class CourseDetailScreen extends StatefulWidget {
  final String courseId;

  const CourseDetailScreen({super.key, required this.courseId});

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final course = AppData.courseById(widget.courseId);
    if (course == null) {
      return Scaffold(
        backgroundColor: AppColors.blackColor,
        appBar: AppBar(
          backgroundColor: AppColors.blackColor,
          leading: IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back)),
        ),
        body: Center(child: Text(StringConst.courseNotFound, style: AppTextStyles.headlineMedium,)),
      );
    }
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: _buildHero(course)),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: .symmetric(horizontal: 20),
                    child: Column(
                      spacing: 20,
                      crossAxisAlignment: .start,
                      children: [
                        const SizedBox(height: 4),
                        Text(course.title, style: AppTextStyles.headlineLarge,),
                        Text('${StringConst.offeredBy} ${course.provider}', style: AppTextStyles.bodyMedium,),
                        _buildStatsRow(course),
                        _buildAboutSection(course),
                        _buildLearningsSection(course),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildEnrollBar(),
        ],
      ),
    );
  }

  Widget _buildHero(Course course) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 260,
          child: Image.asset(course.imageAsset, fit: .cover,),
        ),
        Positioned(
          top: MediaQuery.paddingOf(context).top + 8,
          left: 12,
          child: _buildCircleIconButton(icon: Icons.arrow_back, onTap: () => context.pop()),
        ),
        Positioned(
          top: MediaQuery.paddingOf(context).top + 8,
          right: 12,
          child: _buildCircleIconButton(
            onTap: () => setState(() => _isFavorite = !_isFavorite),
            child: SvgPicture.asset(
              AppIcons.icFavorite,
              width: 22,
              height: 22,
              colorFilter: .mode(_isFavorite ? AppColors.primaryColor : AppColors.whiteColor, .srcIn),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCircleIconButton({VoidCallback? onTap, IconData? icon, Widget? child}) {
    return Material(
      color: AppColors.blackColor.withValues(alpha: 0.45),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 44,
          height: 44,
          child: Center(child: child ?? Icon(icon, color: AppColors.whiteColor, size: 22)),
        ),
      ),
    );
  }

  Widget _buildStatsRow(Course course) {
    return Container(
      padding: .symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: .circular(16),
        border: .all(color: AppColors.borderColor),
      ),
      child: Row(
        children: [
          Expanded(child: _buildStatItem(AppIcons.icLessons, '${course.lessons} ${StringConst.lessonsLabel}')),
          Container(width: 1, height: 36, color: AppColors.borderColor),
          Expanded(child: _buildStatItem(AppIcons.icRating, '${course.rating} (${course.ratingCount})')),
          Container(width: 1, height: 36, color: AppColors.borderColor),
          Expanded(child: _buildStatItem(AppIcons.icDuration, course.duration)),
        ],
      ),
    );
  }

  Widget _buildStatItem(String icon, String label) {
    return Column(
      spacing: 8,
      children: [
        SvgPicture.asset(icon, width: 24, height: 24,),
        Text(label, style: AppTextStyles.bodySmall.copyWith(color: AppColors.whiteColor), textAlign: .center,),
      ],
    );
  }

  Widget _buildAboutSection(Course course) {
    return Column(
      spacing: 10,
      crossAxisAlignment: .start,
      children: [
        Text(StringConst.aboutCourse, style: AppTextStyles.titleLarge,),
        Text(course.about, style: AppTextStyles.bodyMedium,),
      ],
    );
  }

  Widget _buildLearningsSection(Course course) {
    return Column(
      spacing: 12,
      crossAxisAlignment: .start,
      children: [
        Text(StringConst.whatYoullLearn, style: AppTextStyles.titleLarge,),
        ...course.learnings.map(_buildLearningItem),
      ],
    );
  }

  Widget _buildLearningItem(String learning) {
    return Row(
      spacing: 12,
      crossAxisAlignment: .start,
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: const BoxDecoration(color: AppColors.primaryColor, shape: .circle),
          child: const Icon(Icons.check, size: 14, color: AppColors.blackColor),
        ),
        Expanded(child: Text(learning, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.whiteColor),)),
      ],
    );
  }

  Widget _buildEnrollBar() {
    return SafeArea(
      top: false,
      child: Container(
        padding: .fromLTRB(20, 12, 20, 12),
        decoration: const BoxDecoration(
          color: AppColors.surfaceColor,
          border: Border(top: BorderSide(color: AppColors.borderColor)),
        ),
        child: PrimaryButton(
          label: StringConst.enrollInCourse,
          variant: .primary,
          onPressed: () {},
        ),
      ),
    );
  }
}
