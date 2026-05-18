import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/navigation_service.dart';
import '../../../../../core/widgets/custom_warning_dialog.dart';
import '../widgets/avatar_picker_bottom_sheet.dart';
import '../widgets/edit_profile_avatar_section.dart';
import '../widgets/edit_profile_form_section.dart';
import '../widgets/edit_profile_actions_section.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late String _selectedAvatar;
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
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      _nameController.text = args?['name'] ?? '';
      _phoneController.text = args?['phone'] ?? '01200000000';
      _selectedAvatar = args?['avatar'] ?? AppImages.avatar1;
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
      currentAvatar: _selectedAvatar,
    );
    if (picked != null && mounted) {
      setState(() => _selectedAvatar = picked);
    }
  }

  void _onUpdate() {
    if (_formKey.currentState?.validate() ?? false) {
      NavigationService.goBack(
        context,
        result: {
          'name': _nameController.text.trim(),
          'phone': _phoneController.text.trim(),
          'avatar': _selectedAvatar,
        },
      );
    }
  }

  void _onDeleteAccount() {
    CustomWarningDialog.show(
      context,
      title: 'Delete Account',
      description:
          'Are you sure you want to permanently delete your account?\nThis action cannot be undone.',
      actionText: 'Delete',
      actionColor: Theme.of(context).colorScheme.error,
      icon: Icons.delete_forever_rounded,
      onActionPressed: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

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
          'Edit Profile',
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
                      avatarPath: _selectedAvatar,
                      onTap: _pickAvatar,
                    ),
                    EditProfileFormSection(
                      formKey: _formKey,
                      nameController: _nameController,
                      phoneController: _phoneController,
                    ),
                  ],
                ),
              ),
            ),
            EditProfileActionsSection(
              onDelete: _onDeleteAccount,
              onUpdate: _onUpdate,
            ),
          ],
        ),
      ),
    );
  }
}
