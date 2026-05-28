import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/constants/app_constants.dart';
import 'package:movies_app/core/utils/app_localizations_extension.dart';
import 'package:movies_app/core/utils/ui_utils.dart';
import '../../../../../core/di/injection_container.dart';
import '../../../../../core/utils/app_routes.dart';
import '../../../../../core/utils/navigation_service.dart';
import '../../../../../core/widgets/auth_loading_content.dart';
import '../../../../../core/widgets/custom_warning_dialog.dart';
import '../../../../auth/presentation/bloc/auth_cubit.dart';
import '../../../../auth/presentation/bloc/auth_state.dart';
import '../../../presentation/bloc/profile_cubit.dart';
import '../../../presentation/bloc/profile_state.dart';
import '../widgets/avatar_picker_bottom_sheet.dart';
import '../widgets/edit_profile_avatar_section.dart';
import '../widgets/edit_profile_form_section.dart';
import '../widgets/edit_profile_actions_section.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProfileCubit>(),
      child: const _EditProfileScreenBody(),
    );
  }
}

class _EditProfileScreenBody extends StatefulWidget {
  const _EditProfileScreenBody();

  @override
  State<_EditProfileScreenBody> createState() => _EditProfileScreenBodyState();
}

class _EditProfileScreenBodyState extends State<_EditProfileScreenBody> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late String _selectedAvatarKey;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      _nameController.text = args?['name'] ?? '';
      _phoneController.text = args?['phone'] ?? '';
      _selectedAvatarKey = args?['avatarKey'] ?? 'avatar1';
      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickAvatar() async {
    final picked = await AvatarPickerBottomSheet.show(
      context,
      currentAvatarKey: _selectedAvatarKey,
    );
    if (picked != null && mounted) {
      setState(() => _selectedAvatarKey = picked);
    }
  }

  void _onUpdate(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<ProfileCubit>().updateProfile(
        name: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
        avatar: _selectedAvatarKey,
      );
    }
  }

  void _onDeleteAccount(BuildContext context) {
    final passwordController = TextEditingController();
    final l10n = context.l10n;
    CustomWarningDialog.show(
      context,
      title: l10n.deleteAccount,
      description: l10n.deleteAccountConfirm,
      actionText: l10n.delete,
      actionColor: Theme.of(context).colorScheme.error,
      icon: Icons.delete_forever_rounded,
      content: Padding(
        padding: REdgeInsets.only(top: 16),
        child: TextField(
          controller: passwordController,
          obscureText: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: l10n.enterYourPassword,
            prefixIcon: const Icon(Icons.lock_outline),
          ),
        ),
      ),
      onActionPressed: () {
        if (passwordController.text.isNotEmpty) {
          context.read<AuthCubit>().deleteAccount(passwordController.text);
        }
      },
    );
  }

  void _onResetPassword() {
    NavigationService.navigateTo(context, AppRoutes.resetPassword);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = context.l10n;

    return MultiBlocListener(
      listeners: [
        BlocListener<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is UpdateProfileSuccess) {
              context.read<AuthCubit>().checkAuthStatus();
              UIUtils.showToast(l10n.profileUpdatedSuccessfully);
              NavigationService.goBack(context);
            } else if (state is UpdateProfileFailure) {
              UIUtils.showToast(state.message, isError: true);
            }
          },
        ),
        BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              UIUtils.showToast(state.message, isError: true);
            } else if (state is Unauthenticated ||
                state is DeleteAccountSuccess) {
              NavigationService.navigateAndRemoveUntil(
                context,
                AppRoutes.loginScreen,
              );
            }
          },
        ),
      ],
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, authState) {
          if (authState is LogoutLoading) {
            return Scaffold(
              body: AuthLoadingContent(loadingMessage: l10n.loggingOut),
            );
          }
          if (authState is DeleteAccountLoading) {
            return Scaffold(
              body: AuthLoadingContent(loadingMessage: l10n.deletingAccount),
            );
          }
          return BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, profileState) {
              return Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: () => NavigationService.goBack(context),
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: colorScheme.primary,
                    ),
                  ),
                  title: Text(
                    l10n.editProfile,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: colorScheme.primary,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
                body: SafeArea(
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          padding: REdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              40.verticalSpace,
                              EditProfileAvatarSection(
                                avatarPath: AppConstants.getAvatarPath(
                                  _selectedAvatarKey,
                                ),
                                onTap: _pickAvatar,
                              ),
                              EditProfileFormSection(
                                formKey: _formKey,
                                nameController: _nameController,
                                phoneController: _phoneController,
                                onResetPassword: _onResetPassword,
                              ),
                            ],
                          ),
                        ),
                      ),
                      EditProfileActionsSection(
                        onDelete: () => _onDeleteAccount(context),
                        onUpdate: (profileState is UpdateProfileLoading ||
                                authState is AuthLoading)
                            ? null
                            : () => _onUpdate(context),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
