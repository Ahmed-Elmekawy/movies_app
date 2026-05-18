import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_routes.dart';
import '../../../../../core/utils/navigation_service.dart';
import '../widgets/movies_grid_tab.dart';
import '../widgets/profile_tab_bar.dart';
import '../widgets/profile_header_section.dart';
import '../widgets/profile_action_buttons_section.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _name = 'John Safwat';
  String _avatarPath = AppImages.avatar1;
  int _selectedTab = 0;
  final int _watchListCount = 12;
  final int _historyCount = 10;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ProfileHeaderSection(
              avatarPath: _avatarPath,
              name: _name,
              watchListCount: _watchListCount,
              historyCount: _historyCount,
            ),

            20.verticalSpace,
            ProfileActionButtonsSection(
              onEditProfile: () async {
                final result = await NavigationService.navigateTo(
                  context,
                  AppRoutes.editProfile,
                  arguments: {'name': _name, 'avatar': _avatarPath},
                );
                if (result != null &&
                    result is Map<String, dynamic> &&
                    mounted) {
                  setState(() {
                    _name = result['name'] ?? _name;
                    _avatarPath = result['avatar'] ?? _avatarPath;
                  });
                }
              },
              onExit: () {
                // TODO: sign out
              },
            ),
            20.verticalSpace,
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 20),
              child: ProfileTabBar(
                selectedIndex: _selectedTab,
                onTabChanged: (i) => setState(() => _selectedTab = i),
              ),
            ),
            Container(
              height: 1,
              color: colorScheme.onSurface.withValues(alpha: 0.08),
            ),
            Expanded(
              child: _selectedTab == 0
                  ? const MoviesGridTab(isEmpty: true)
                  : const MoviesGridTab(isEmpty: false),
            ),
          ],
        ),
      ),
    );
  }
}
