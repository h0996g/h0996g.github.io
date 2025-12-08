import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noor/Core/theme/app_colors.dart';
import 'package:noor/Feature/Feedback/presentation/manager/feedback_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FeedbackBottomSheet extends StatefulWidget {
  const FeedbackBottomSheet({super.key});

  @override
  State<FeedbackBottomSheet> createState() => _FeedbackBottomSheetState();
}

class _FeedbackBottomSheetState extends State<FeedbackBottomSheet> {
  FeedbackMethod _selectedMethod =
      FeedbackMethod.anonymous; // Default to anonymous
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  XFile? _selectedMedia;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickMedia() async {
    // Show dialog to pick Image or Video
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Image'),
              onTap: () async {
                Navigator.pop(context);
                final XFile? image = await _picker.pickImage(
                  source: ImageSource.gallery,
                );
                if (image != null) {
                  setState(() => _selectedMedia = image);
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.videocam),
              title: const Text('Video'),
              onTap: () async {
                Navigator.pop(context);
                final XFile? video = await _picker.pickVideo(
                  source: ImageSource.gallery,
                );
                if (video != null) {
                  setState(() => _selectedMedia = video);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _submit(BuildContext context) async {
    final String text = _descriptionController.text;
    final String contact = _contactController.text;

    context.read<FeedbackCubit>().submitFeedback(
      text: text,
      method: _selectedMethod,
      contactInfo: contact,
      attachment: _selectedMedia,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeedbackCubit(Supabase.instance.client),
      child: BlocConsumer<FeedbackCubit, FeedbackState>(
        listener: (context, state) {
          if (state.status == FeedbackStatus.success) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message ?? "Success"),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state.status == FeedbackStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message ?? "Error"),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          final bool isLoading = state.status == FeedbackStatus.loading;

          return Container(
            padding: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
              top: 20.h,
              bottom:
                  MediaQuery.of(context).viewInsets.bottom +
                  20.h, // Keyboard handling
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Feedback',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.h),

                  // Method Selection
                  Text(
                    'How would you like to send feedback?',
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 10.h),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _SelectionChip(
                          label: 'Anonymous',
                          icon: Icons.person_off_outlined,
                          isSelected:
                              _selectedMethod == FeedbackMethod.anonymous,
                          onTap: () => setState(
                            () => _selectedMethod = FeedbackMethod.anonymous,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        _SelectionChip(
                          label: 'Email',
                          icon: Icons.email_outlined,
                          isSelected: _selectedMethod == FeedbackMethod.email,
                          onTap: () => setState(
                            () => _selectedMethod = FeedbackMethod.email,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        _SelectionChip(
                          label: 'WhatsApp',
                          icon: Icons.chat_bubble_outline,
                          isSelected:
                              _selectedMethod == FeedbackMethod.whatsapp,
                          onTap: () => setState(
                            () => _selectedMethod = FeedbackMethod.whatsapp,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Contact Info Field (if not anonymous)
                  if (_selectedMethod != FeedbackMethod.anonymous) ...[
                    TextField(
                      controller: _contactController,
                      keyboardType: _selectedMethod == FeedbackMethod.email
                          ? TextInputType.emailAddress
                          : TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: _selectedMethod == FeedbackMethod.email
                            ? 'Enter your email address'
                            : 'Enter your WhatsApp number',
                        prefixIcon: Icon(
                          _selectedMethod == FeedbackMethod.email
                              ? Icons.email
                              : Icons.phone,
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(
                            color: AppColors.primary,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                    ),
                    SizedBox(height: 16.h),
                  ],

                  // Description Content
                  TextField(
                    controller: _descriptionController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Tell us what you think...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(color: AppColors.primary),
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Media Picker (Always available now, or could restrict for Email/WA if needed)
                  GestureDetector(
                    onTap: _pickMedia,
                    child: Container(
                      height: 60.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.secondary,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                        color: AppColors.secondary.withValues(alpha: 0.1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_photo_alternate_outlined,
                            color: AppColors.third,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            _selectedMedia == null
                                ? 'Attach Image or Video'
                                : 'Media Selected',
                            style: TextStyle(
                              color: AppColors.third,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (_selectedMedia != null) ...[
                            SizedBox(width: 8.w),
                            Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 20.sp,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  if (_selectedMedia != null)
                    Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              _selectedMedia!.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.red),
                            onPressed: () =>
                                setState(() => _selectedMedia = null),
                          ),
                        ],
                      ),
                    ),

                  SizedBox(height: 24.h),

                  // Submit Button
                  ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () => _submit(
                            context,
                          ), // Fixed: wrapped in closure and passed context
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 0,
                    ),
                    child: isLoading
                        ? SizedBox(
                            width: 20.h,
                            height: 20.h,
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'Send Feedback',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SelectionChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _SelectionChip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.grey[100],
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey[300]!,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18.sp,
              color: isSelected ? Colors.white : Colors.grey[600],
            ),
            SizedBox(width: 8.w),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[600],
                fontWeight: FontWeight.w600,
                fontSize: 13.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
