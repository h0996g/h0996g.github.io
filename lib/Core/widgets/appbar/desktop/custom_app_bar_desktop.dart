import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noor/Core/theme/app_colors.dart';
import 'package:noor/Feature/Settings/presentation/manager/settings_cubit.dart';

class CustomAppBarDesktop extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final bool showSettingsAction;

  const CustomAppBarDesktop({
    super.key,
    required this.title,
    this.showSettingsAction = true,
  });

  @override
  Size get preferredSize => Size.fromHeight(70.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 4,
      toolbarHeight: 80,
      shadowColor: Colors.black.withValues(alpha: 0.1),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary,
              AppColors.primary.withValues(alpha: 0.8),
            ],
          ),
        ),
      ),
      title: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Amiri',
                  ),
                ),
                if (showSettingsAction)
                  Container(
                    padding: const EdgeInsets.all(10),
                    // decoration: BoxDecoration(
                    //   color: Colors.white.withValues(alpha: 0.2),
                    //   borderRadius: BorderRadius.circular(12),
                    // ),
                    child: IconButton(
                      onPressed: () => _showTextSizeDialog(context),
                      icon: const Icon(
                        Icons.text_fields_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                      tooltip: 'تغيير حجم النص',
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),

      centerTitle: true,
      backgroundColor: AppColors.primary,

      iconTheme: const IconThemeData(color: Colors.white, size: 24),
      leading: Navigator.canPop(context)
          ? IconButton(
              icon: const Icon(Icons.arrow_back_rounded),
              onPressed: () => Navigator.pop(context),
              tooltip: 'رجوع',
            )
          : null,
      actions: [],
    );
  }

  void _showTextSizeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.text_fields_rounded,
                      color: AppColors.primary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'حجم النص',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Amiri',
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close_rounded),
                    tooltip: 'إغلاق',
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Slider Control
              BlocBuilder<SettingsCubit, SettingsState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      Slider(
                        value: state.textScaleFactor,
                        min: 0.8,
                        max: 1.5,
                        divisions: 7,
                        label: state.textScaleFactor.toStringAsFixed(1),
                        onChanged: (value) {
                          context.read<SettingsCubit>().updateTextScale(value);
                        },
                      ),

                      // Labels
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'صغير',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Amiri',
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(
                              'افتراضي',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Amiri',
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(
                              'كبير',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Amiri',
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Preview Box
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: const Text(
                          'بسم الله الرحمن الرحيم',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18, fontFamily: 'Amiri'),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
