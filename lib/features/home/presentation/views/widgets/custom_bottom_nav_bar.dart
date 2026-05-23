import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/utils/app_assets.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomTheme = theme.bottomNavigationBarTheme;

    return Padding(
      padding: REdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          items: [
            BottomNavigationBarItem(
              icon: _NavBarIcon(
                path: AppImages.homeIcon,
                color: bottomTheme.unselectedItemColor,
              ),
              activeIcon: _NavBarIcon(
                path: AppImages.homeIcon,
                color: bottomTheme.selectedItemColor,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: _NavBarIcon(
                path: AppImages.searchIcon,
                color: bottomTheme.unselectedItemColor,
              ),
              activeIcon: _NavBarIcon(
                path: AppImages.searchIcon,
                color: bottomTheme.selectedItemColor,
              ),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: _NavBarIcon(
                path: AppImages.exploreIcon,
                color: bottomTheme.unselectedItemColor,
              ),
              activeIcon: _NavBarIcon(
                path: AppImages.exploreIcon,
                color: bottomTheme.selectedItemColor,
              ),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: _NavBarIcon(
                path: AppImages.profileIcon,
                color: bottomTheme.unselectedItemColor,
              ),
              activeIcon: _NavBarIcon(
                path: AppImages.profileIcon,
                color: bottomTheme.selectedItemColor,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

class _NavBarIcon extends StatelessWidget {
  final String path;
  final Color? color;

  const _NavBarIcon({required this.path, this.color});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      height: 24.sp,
      width: 24.sp,
      color: color,
      fit: BoxFit.contain,
    );
  }
}
