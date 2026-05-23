import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_assets.dart';
import 'available_now_section.dart';
import 'movie_category_section.dart';
import 'watch_now_header.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  int _activeHeroIndex = 0;

  final List<String> _heroImages = [
    AppImages.screenshot1,
    AppImages.screenshot2,
    AppImages.screenshot3,
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: Container(
            key: ValueKey(_heroImages[_activeHeroIndex]),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(_heroImages[_activeHeroIndex]),
                fit: BoxFit.cover,
                opacity: 0.35,
              ),
            ),
          ),
        ),
        SafeArea(
          child: SingleChildScrollView(
            padding: REdgeInsets.only(bottom: 16),
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                AvailableNowSection(
                  onPageChanged: (index) {
                    setState(() {
                      _activeHeroIndex = index;
                    });
                  },
                ),
                20.verticalSpace,
                const WatchNowHeader(),
                20.verticalSpace,
                MovieCategorySection(
                  title: 'Action',
                  onSeeMore: () {},
                ),
                20.verticalSpace,
                MovieCategorySection(
                  title: 'Drama',
                  onSeeMore: () {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
