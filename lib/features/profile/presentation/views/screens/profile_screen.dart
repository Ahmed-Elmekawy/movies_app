import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/constants/app_constants.dart';
import 'package:movies_app/core/utils/app_localizations_extension.dart';
import 'package:movies_app/core/widgets/language_switcher.dart';
import '../../../../../core/utils/app_routes.dart';
import '../../../../../core/utils/navigation_service.dart';
import '../../../../../core/widgets/auth_loading_content.dart';
import '../../../../../core/widgets/error_view.dart';
import '../../../../auth/presentation/bloc/auth_cubit.dart';
import '../../../../auth/presentation/bloc/auth_state.dart';
import '../../bloc/profile_cubit.dart';
import '../../bloc/profile_state.dart';
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
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return MultiBlocListener(
      listeners: [
        BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is Unauthenticated || state is DeleteAccountSuccess) {
              NavigationService.navigateAndRemoveUntil(
                context,
                AppRoutes.loginScreen,
              );
            }
          },
        ),
        BlocListener<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is AddToHistorySuccess) {
              context.read<AuthCubit>().checkAuthStatus();
            }
          },
        ),
      ],
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is LogoutLoading) {
            return Scaffold(
              body: AuthLoadingContent(loadingMessage: context.l10n.loggingOut),
            );
          }
          if (state is DeleteAccountLoading) {
            return Scaffold(
              body: AuthLoadingContent(
                loadingMessage: context.l10n.deletingAccount,
              ),
            );
          }
          if (state is AuthSuccess) {
            final user = state.userEntity;
            return Scaffold(
              body: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: REdgeInsets.fromLTRB(20, 16, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            context.l10n.profile,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const LanguageSwitcher(),
                        ],
                      ),
                    ),
                    ProfileHeaderSection(
                      avatarPath: AppConstants.getAvatarPath(user.avatar),
                      name: user.name,
                      watchListCount: user.watchList.length,
                      historyCount: user.history.length,
                    ),
                    20.verticalSpace,
                    ProfileActionButtonsSection(
                      onEditProfile: () {
                        NavigationService.navigateTo(
                          context,
                          AppRoutes.editProfile,
                          arguments: {
                            'name': user.name,
                            'phone': user.phone,
                            'avatarKey': user.avatar,
                          },
                        );
                      },
                      onExit: () {
                        context.read<AuthCubit>().logout();
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
                          ? MoviesGridTab(
                              movies: user.watchList.reversed.toList(),
                            )
                          : MoviesGridTab(
                              movies: user.history.reversed.toList(),
                            ),
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is AuthFailure) {
            return Scaffold(
              body: AppErrorView(
                message: state.message,
                onRetry: () => context.read<AuthCubit>().checkAuthStatus(),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
