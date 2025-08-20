import 'dart:io' if (dart.library.io) 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ProfileHeaderWidget extends StatefulWidget {
  const ProfileHeaderWidget({super.key});

  @override
  State<ProfileHeaderWidget> createState() => _ProfileHeaderWidgetState();
}

class _ProfileHeaderWidgetState extends State<ProfileHeaderWidget> {
  String _profileImageUrl =
      'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80';
  String _userName = 'John Smith';
  String _userEmail = 'john.smith@email.com';
  String _membershipTier = 'Gold Member';
  int _loyaltyPoints = 2450;

  final ImagePicker _picker = ImagePicker();
  bool _isLoadingImage = false;

  Future<bool> _requestPermissions() async {
    if (kIsWeb) return true;

    try {
      if (Platform.isAndroid || Platform.isIOS) {
        final cameraStatus = await Permission.camera.request();
        final storageStatus = await Permission.storage.request();
        return cameraStatus.isGranted && storageStatus.isGranted;
      }
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<void> _showImagePicker() async {
    final hasPermission = await _requestPermissions();
    if (!hasPermission) {
      _showPermissionDeniedDialog();
      return;
    }

    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.surface,
                borderRadius: BorderRadius.vertical(top: Radius.circular(5.w))),
            child: SafeArea(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                  width: 12.w,
                  height: 1.h,
                  decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.outline,
                      borderRadius: BorderRadius.circular(2.w))),
              SizedBox(height: 3.h),
              Text('Change Profile Photo',
                  style: AppTheme.lightTheme.textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.w600)),
              SizedBox(height: 3.h),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                _buildImagePickerOption(
                    icon: 'camera_alt',
                    label: 'Camera',
                    onTap: () => _pickImage(ImageSource.camera)),
                _buildImagePickerOption(
                    icon: 'photo_library',
                    label: 'Gallery',
                    onTap: () => _pickImage(ImageSource.gallery)),
                _buildImagePickerOption(
                    icon: 'delete', label: 'Remove', onTap: _removeImage),
              ]),
              SizedBox(height: 2.h),
            ]))));
  }

  Widget _buildImagePickerOption({
    required String icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 4.w),
            decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.primaryContainer
                    .withAlpha(128),
                borderRadius: BorderRadius.circular(3.w)),
            child: Column(children: [
              CustomIconWidget(
                  iconName: icon,
                  size: 8.w,
                  color: AppTheme.lightTheme.colorScheme.primary),
              SizedBox(height: 1.h),
              Text(label,
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                      fontWeight: FontWeight.w500)),
            ])));
  }

  Future<void> _pickImage(ImageSource source) async {
    Navigator.pop(context);

    setState(() {
      _isLoadingImage = true;
    });

    try {
      final XFile? image = await _picker.pickImage(
          source: source, maxWidth: 512, maxHeight: 512, imageQuality: 80);

      if (image != null) {
        // In a real app, you would upload this to your server
        // For demo purposes, we'll just update the UI
        setState(() {
          _profileImageUrl = image.path;
        });

        HapticFeedback.lightImpact();
        _showSuccessMessage('Profile photo updated successfully');
      }
    } catch (e) {
      _showErrorMessage('Failed to update profile photo');
    } finally {
      setState(() {
        _isLoadingImage = false;
      });
    }
  }

  Future<void> _removeImage() async {
    Navigator.pop(context);

    setState(() {
      _profileImageUrl = '';
    });

    HapticFeedback.lightImpact();
    _showSuccessMessage('Profile photo removed');
  }

  void _showPermissionDeniedDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                title: Text('Permissions Required'),
                content: Text(
                    'Please grant camera and storage permissions to change your profile photo.'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancel')),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        openAppSettings();
                      },
                      child: Text('Settings')),
                ]));
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: AppTheme.lightTheme.colorScheme.tertiary));
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: AppTheme.lightTheme.colorScheme.error));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          AppTheme.lightTheme.colorScheme.primary.withAlpha(26),
          AppTheme.lightTheme.colorScheme.surface,
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Column(children: [
          // Profile Image with Edit Button
          Stack(children: [
            Container(
                width: 30.w,
                height: 30.w,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: AppTheme.lightTheme.colorScheme.primary,
                        width: 3)),
                child: ClipOval(
                    child: _isLoadingImage
                        ? Container(
                            color: AppTheme
                                .lightTheme.colorScheme.primaryContainer,
                            child: Center(
                                child: SizedBox(
                                    width: 8.w,
                                    height: 8.w,
                                    child: CircularProgressIndicator(
                                        color: AppTheme
                                            .lightTheme.colorScheme.primary,
                                        strokeWidth: 2))))
                        : _profileImageUrl.isNotEmpty
                            ? kIsWeb || _profileImageUrl.startsWith('http')
                                ? CustomImageWidget(
                                    imageUrl: _profileImageUrl,
                                    fit: BoxFit.cover,
                                    width: 30.w,
                                    height: 30.w)
                                : Image.file(File(_profileImageUrl),
                                    fit: BoxFit.cover,
                                    width: 30.w,
                                    height: 30.w)
                            : Container(
                                color: AppTheme
                                    .lightTheme.colorScheme.primaryContainer,
                                child: CustomIconWidget(
                                    iconName: 'person',
                                    size: 15.w,
                                    color: AppTheme
                                        .lightTheme.colorScheme.primary)))),
            Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                    onTap: _showImagePicker,
                    child: Container(
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                            color: AppTheme.lightTheme.colorScheme.secondary,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: AppTheme.lightTheme.colorScheme.surface,
                                width: 2)),
                        child: CustomIconWidget(
                            iconName: 'camera_alt',
                            size: 4.w,
                            color:
                                AppTheme.lightTheme.colorScheme.onSecondary)))),
          ]),

          SizedBox(height: 3.h),

          // User Name
          Text(_userName,
              style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.lightTheme.colorScheme.onSurface),
              textAlign: TextAlign.center),

          SizedBox(height: 1.h),

          // Email
          Text(_userEmail,
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant),
              textAlign: TextAlign.center),

          SizedBox(height: 2.h),

          // Membership Tier and Loyalty Points
          Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(3.w)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Status',
                              style: AppTheme.lightTheme.textTheme.bodySmall
                                  ?.copyWith(
                                      color: AppTheme.lightTheme.colorScheme
                                          .onSurfaceVariant)),
                          Text(_membershipTier,
                              style: AppTheme.lightTheme.textTheme.titleSmall
                                  ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme
                                          .lightTheme.colorScheme.primary)),
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('Points',
                              style: AppTheme.lightTheme.textTheme.bodySmall
                                  ?.copyWith(
                                      color: AppTheme.lightTheme.colorScheme
                                          .onSurfaceVariant)),
                          Text(_loyaltyPoints.toString(),
                              style: AppTheme.lightTheme.textTheme.titleSmall
                                  ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme
                                          .lightTheme.colorScheme.primary)),
                        ]),
                  ])),
        ]));
  }
}