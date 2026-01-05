import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Ajr/Core/theme/app_colors.dart';
import 'package:Ajr/Feature/Feedback/presentation/manager/feedback_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FeedbackDialogDesktop extends StatefulWidget {
  const FeedbackDialogDesktop({super.key});

  @override
  State<FeedbackDialogDesktop> createState() => _FeedbackDialogDesktopState();
}

class _FeedbackDialogDesktopState extends State<FeedbackDialogDesktop> {
  FeedbackMethod _selectedMethod = FeedbackMethod.anonymous;
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  XFile? _selectedMedia;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickMedia() async {
    // Show dialog for media selection on desktop
    await showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'اختر نوع المرفق',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Amiri',
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _MediaOptionCard(
                      icon: Icons.image_rounded,
                      label: 'صورة',
                      color: AppColors.primary,
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
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _MediaOptionCard(
                      icon: Icons.videocam_rounded,
                      label: 'فيديو',
                      color: AppColors.third,
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit(BuildContext context) {
    // context is passed from the builder
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
                content: Text(
                  state.message ?? "تم الإرسال بنجاح",
                  style: const TextStyle(fontFamily: 'Amiri'),
                ),
                behavior: SnackBarBehavior.floating,
                width: 400,
                backgroundColor: Colors.green,
              ),
            );
          } else if (state.status == FeedbackStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message ?? "حدث خطأ",
                  style: const TextStyle(fontFamily: 'Amiri'),
                ),
                behavior: SnackBarBehavior.floating,
                width: 400,
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          final bool isLoading = state.status == FeedbackStatus.loading;

          return Dialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.feedback_outlined,
                            color: AppColors.primary,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Expanded(
                          child: Text(
                            'الملاحظات والاقتراحات',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Amiri',
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close),
                          tooltip: 'إغلاق',
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Method Selection
                    const Text(
                      'كيف تود إرسال ملاحظاتك؟',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontFamily: 'Amiri',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        _SelectionChipDesktop(
                          label: 'مجهول',
                          icon: Icons.person_off_outlined,
                          isSelected:
                              _selectedMethod == FeedbackMethod.anonymous,
                          onTap: () => setState(
                            () => _selectedMethod = FeedbackMethod.anonymous,
                          ),
                        ),
                        _SelectionChipDesktop(
                          label: 'بريد إلكتروني',
                          icon: Icons.email_outlined,
                          isSelected: _selectedMethod == FeedbackMethod.email,
                          onTap: () => setState(
                            () => _selectedMethod = FeedbackMethod.email,
                          ),
                        ),
                        _SelectionChipDesktop(
                          label: 'واتساب',
                          icon: Icons.chat_bubble_outline,
                          isSelected:
                              _selectedMethod == FeedbackMethod.whatsapp,
                          onTap: () => setState(
                            () => _selectedMethod = FeedbackMethod.whatsapp,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Contact Info (if needed)
                    AnimatedCrossFade(
                      firstChild: const SizedBox(width: double.infinity),
                      secondChild: Column(
                        children: [
                          TextField(
                            controller: _contactController,
                            style: const TextStyle(fontSize: 16),
                            decoration: InputDecoration(
                              labelText: _selectedMethod == FeedbackMethod.email
                                  ? 'البريد الإلكتروني'
                                  : 'رقم الواتساب',
                              hintText: _selectedMethod == FeedbackMethod.email
                                  ? 'example@email.com'
                                  : '+966...',
                              prefixIcon: Icon(
                                _selectedMethod == FeedbackMethod.email
                                    ? Icons.email_outlined
                                    : Icons.phone_outlined,
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                      crossFadeState:
                          _selectedMethod == FeedbackMethod.anonymous
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      duration: const Duration(milliseconds: 300),
                    ),

                    // Description
                    TextField(
                      controller: _descriptionController,
                      maxLines: 5,
                      style: const TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        hintText: 'اكتب ملاحظاتك أو اقتراحك هنا بالتفصيل...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.all(16),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Media Picker
                    InkWell(
                      onTap: _pickMedia,
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.secondary.withOpacity(0.5),
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.secondary.withOpacity(0.05),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_photo_alternate_outlined,
                              color: AppColors.secondary,
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                _selectedMedia == null
                                    ? 'إرفاق صورة أو فيديو (اختياري)'
                                    : 'تم إرفاق: ${_selectedMedia!.name}',
                                style: TextStyle(
                                  color: AppColors.secondary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  fontFamily: 'Amiri',
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (_selectedMedia != null) ...[
                              const SizedBox(width: 8),
                              IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                  size: 20,
                                ),
                                onPressed: () {
                                  setState(() => _selectedMedia = null);
                                },
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Submit Button
                    SizedBox(
                      height: 56,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : () => _submit(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : const Text(
                                'إرسال الملاحظة',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Amiri',
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SelectionChipDesktop extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _SelectionChipDesktop({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_SelectionChipDesktop> createState() => _SelectionChipDesktopState();
}

class _SelectionChipDesktopState extends State<_SelectionChipDesktop> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: widget.isSelected
                ? AppColors.primary
                : (_isHovered ? Colors.grey[200] : Colors.grey[100]),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: widget.isSelected ? AppColors.primary : Colors.grey[300]!,
            ),
            boxShadow: _isHovered && !widget.isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Row(
            children: [
              Icon(
                widget.icon,
                size: 20,
                color: widget.isSelected ? Colors.white : Colors.grey[700],
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: TextStyle(
                  color: widget.isSelected ? Colors.white : Colors.grey[700],
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  fontFamily: 'Amiri',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MediaOptionCard extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _MediaOptionCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  State<_MediaOptionCard> createState() => _MediaOptionCardState();
}

class _MediaOptionCardState extends State<_MediaOptionCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 140,
          transform: Matrix4.identity()..scale(_isHovered ? 1.05 : 1.0),
          decoration: BoxDecoration(
            color: widget.color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: widget.color.withOpacity(0.2),
              width: 1.5,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: widget.color.withOpacity(0.2),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: widget.color.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(widget.icon, color: widget.color, size: 32),
              ),
              const SizedBox(height: 12),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Amiri',
                  color: widget.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
