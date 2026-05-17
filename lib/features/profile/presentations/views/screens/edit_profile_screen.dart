import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/navigation_service.dart';
import '../../../../../core/widgets/custom_warning_dialog.dart';
import '../widgets/avatar_picker_bottom_sheet.dart';
import '../widgets/edit_profile_avatar_section.dart';
import '../widgets/edit_profile_form_section.dart';
import '../widgets/edit_profile_actions_section.dart';

class EditProfileScreen extends StatefulWidget {
  final String initialName;
  final String initialAvatar;
  final String initialPhone;

  const EditProfileScreen({
    super.key,
    required this.initialName,
    required this.initialAvatar,
    this.initialPhone = '01200000000',
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late String _selectedAvatar;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _phoneController = TextEditingController(text: widget.initialPhone);
    _selectedAvatar = widget.initialAvatar;
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
      actionColor: AppColors.red,
      icon: Icons.delete_forever_rounded,
      onActionPressed: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryVariant,
      appBar: AppBar(
        backgroundColor: AppColors.primaryVariant,
        elevation: 0,
        leading: IconButton(
          onPressed: () => NavigationService.goBack(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.primary,
          ),
        ),
        title: Text(
          'Pick Avatar',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // ── Scrollable Form ────────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: REdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    40.verticalSpace,
                    // ── Avatar ───────────────────────────────────────────
                    EditProfileAvatarSection(
                      avatarPath: _selectedAvatar,
                      onTap: _pickAvatar,
                    ),
                    // ── Form ─────────────────────────────────────────────
                    EditProfileFormSection(
                      formKey: _formKey,
                      nameController: _nameController,
                      phoneController: _phoneController,
                    ),
                  ],
                ),
              ),
            ),

            // ── Bottom Buttons ─────────────────────────────────────────────
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
