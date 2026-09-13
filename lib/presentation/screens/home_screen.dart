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

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  CourseStatus _selectedStatus = .inProgress;
  String _query = '';
  late final AnimationController _controller;

  List<Course> get _filteredCourses {
    final byStatus = AppData.coursesByStatus(_selectedStatus);
    if (_query.trim().isEmpty) return byStatus;
    final q = _query.trim().toLowerCase();
    return byStatus.where((c) => c.title.toLowerCase().contains(q) || c.provider.toLowerCase().contains(q)).toList();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (MediaQuery.disableAnimationsOf(context)) {
        _controller.value = 1;
        return;
      }
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
              _buildEntrance(begin: 0, end: 0.25, child: _buildHeader()),
              _buildEntrance(begin: 0.1, end: 0.35, slide: 16, child: _buildSearchField()),
              Expanded(
                child: ListView(
                  children: [
                    _buildEntrance(begin: 0.2, end: 0.5, slide: 20, child: _buildPromoBanner()),
                    const SizedBox(height: 20),
                    _buildEntrance(begin: 0.35, end: 0.6, slide: 12, child: _buildStatusTabs()),
                    const SizedBox(height: 16),
                    _buildEntrance(begin: 0.45, end: 0.85, slide: 16, child: _buildCourseList()),
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
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutCubic,
              padding: .symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: selected ? AppColors.primaryColor : AppColors.cardColor,
                borderRadius: .circular(24),
                border: selected ? null : .all(color: AppColors.borderColor),
              ),
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutCubic,
                style: selected
                    ? AppTextStyles.labelMedium.copyWith(color: AppColors.blackColor, fontWeight: .w700)
                    : AppTextStyles.labelMedium.copyWith(color: AppColors.secondaryTextColor),
                child: Text(tab.$2),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCourseList() {
    final courses = _filteredCourses;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 280),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween(begin: const Offset(0, 0.06), end: Offset.zero).animate(animation),
          child: child,
        ),
      ),
      child: Column(
        key: ValueKey('${_selectedStatus.name}_$_query'),
        spacing: 12,
        children: courses.map(_buildCourseCard).toList(),
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
              Hero(
                tag: 'course-image-${course.id}',
                child: ClipRRect(
                  borderRadius: .circular(14),
                  child: Image.asset(course.imageAsset, width: 88, height: 88, fit: .cover,),
                ),
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

  Widget _buildEntrance({
    required double begin,
    required double end,
    required Widget child,
    double slide = 0,
  }) {
    final curved = CurvedAnimation(
      parent: _controller,
      curve: Interval(begin, end, curve: Curves.easeOutCubic),
    );
    return AnimatedBuilder(
      animation: curved,
      builder: (_, child) {
        final t = curved.value;
        return Opacity(
          opacity: t,
          child: Transform.translate(offset: Offset(0, slide * (1 - t)), child: child),
        );
      },
      child: child,
    );
  }
}
