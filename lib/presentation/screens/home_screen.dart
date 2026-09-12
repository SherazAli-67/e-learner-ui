import 'package:e_learner/constants/string_const.dart';
import 'package:e_learner/core/app_colors.dart';
import 'package:e_learner/core/app_data.dart';
import 'package:e_learner/core/app_icons.dart';
import 'package:e_learner/core/app_textstyles.dart';
import 'package:e_learner/core/models/course.dart';
import 'package:e_learner/presentation/widgets/primary_button.dart';
import 'package:e_learner/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CourseStatus _selectedStatus = .inProgress;
  String _query = '';

  List<Course> get _filteredCourses {
    final byStatus = AppData.coursesByStatus(_selectedStatus);
    if (_query.trim().isEmpty) return byStatus;
    final q = _query.trim().toLowerCase();
    return byStatus.where((c) => c.title.toLowerCase().contains(q) || c.provider.toLowerCase().contains(q)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SafeArea(
        child: Padding(
          padding: .symmetric(horizontal: 20),
          child: Column(
            spacing: 20,
            children: [
              const SizedBox(height: 4),
              _buildHeader(),
              _buildSearchField(),
              Expanded(
                child: ListView(
                  children: [
                    _buildPromoBanner(),
                    const SizedBox(height: 20),
                    _buildStatusTabs(),
                    const SizedBox(height: 16),
                    ..._filteredCourses.map((course) => Padding(
                          padding: .only(bottom: 12),
                          child: _buildCourseCard(course),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        SvgPicture.asset(AppIcons.logoWithText, height: 32,),
        const Spacer(),
        SvgPicture.asset(AppIcons.icFavorite, width: 28, height: 28,),
        const SizedBox(width: 12),
        SvgPicture.asset(AppIcons.icNotification, width: 28, height: 28,),
      ],
    );
  }

  Widget _buildSearchField() {
    return TextField(
      onChanged: (value) => setState(() => _query = value),
      style: AppTextStyles.bodyLarge,
      decoration: InputDecoration(
        hintText: StringConst.searchHint,
        hintStyle: AppTextStyles.bodyMedium,
        prefixIcon: const Icon(Icons.search, color: AppColors.secondaryTextColor),
        filled: true,
        fillColor: AppColors.searchFieldColor,
        contentPadding: .symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(borderRadius: .circular(16), borderSide: .none),
        enabledBorder: OutlineInputBorder(borderRadius: .circular(16), borderSide: .none),
        focusedBorder: OutlineInputBorder(
          borderRadius: .circular(16),
          borderSide: const BorderSide(color: AppColors.primaryColor),
        ),
      ),
    );
  }

  Widget _buildPromoBanner() {
    return Container(
      width: double.infinity,
      padding: .all(20),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: .circular(20),
        border: .all(color: AppColors.borderColor),
      ),
      child: Column(
        spacing: 16,
        crossAxisAlignment: .start,
        children: [
          Row(
            spacing: 12,
            crossAxisAlignment: .start,
            children: [
              Expanded(child: Text(StringConst.promoTitle, style: AppTextStyles.titleMedium,)),
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: .circular(16)),
                child: const Icon(Icons.star_rounded, color: AppColors.blackColor, size: 32),
              ),
            ],
          ),
          PrimaryButton(
            label: StringConst.getStarted,
            variant: .primary,
            height: 44,
            width: 140,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildStatusTabs() {
    final tabs = <(CourseStatus, String)>[
      (.enrolled, StringConst.enrolledCourses),
      (.inProgress, '${StringConst.inProgress} (${AppData.coursesByStatus(.inProgress).length})'),
      (.completed, StringConst.completed),
    ];
    return SingleChildScrollView(
      scrollDirection: .horizontal,
      child: Row(
        spacing: 8,
        children: tabs.map((tab) {
          final selected = _selectedStatus == tab.$1;
          return GestureDetector(
            onTap: () => setState(() => _selectedStatus = tab.$1),
            child: Container(
              padding: .symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: selected ? AppColors.primaryColor : AppColors.cardColor,
                borderRadius: .circular(24),
                border: selected ? null : .all(color: AppColors.borderColor),
              ),
              child: Text(
                tab.$2,
                style: selected
                    ? AppTextStyles.labelMedium.copyWith(color: AppColors.blackColor, fontWeight: .w700)
                    : AppTextStyles.labelMedium.copyWith(color: AppColors.secondaryTextColor),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCourseCard(Course course) {
    return Container(
      padding: .all(12),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: .circular(20),
        border: .all(color: AppColors.borderColor),
      ),
      child: Column(
        spacing: 12,
        crossAxisAlignment: .start,
        children: [
          Row(
            spacing: 12,
            crossAxisAlignment: .start,
            children: [
              ClipRRect(
                borderRadius: .circular(14),
                child: Image.asset(course.imageAsset, width: 88, height: 88, fit: .cover,),
              ),
              Expanded(
                child: Column(
                  spacing: 6,
                  crossAxisAlignment: .start,
                  children: [
                    Text(course.title, style: AppTextStyles.titleMedium, maxLines: 2, overflow: .ellipsis,),
                    Text('${StringConst.offeredBy} ${course.provider}', style: AppTextStyles.bodySmall,),
                    if (course.status == .inProgress) _buildProgressBar(course.progress),
                  ],
                ),
              ),
            ],
          ),
          PrimaryButton(
            label: StringConst.viewDetails,
            variant: .outlined,
            height: 44,
            onPressed: () => context.push('${NamedRoutes.course.routeName}/${course.id}'),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar(double progress) {
    return Column(
      spacing: 4,
      crossAxisAlignment: .start,
      children: [
        ClipRRect(
          borderRadius: .circular(4),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 6,
            backgroundColor: AppColors.borderColor,
            color: AppColors.mintColor,
          ),
        ),
        Text('${(progress * 100).round()}%', style: AppTextStyles.bodySmall,),
      ],
    );
  }
}
