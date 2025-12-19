import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noor/Core/const/app_images.dart';
import 'package:noor/Core/theme/app_colors.dart';
import 'package:noor/Core/widgets/appbar/desktop/custom_app_bar_desktop.dart';
import 'package:noor/Feature/Adkar/presentation/views/desktop/widgets/adkar_section_item_widget.dart';
import '../../manager/adkar_cubit.dart';
import '../../manager/adkar_state.dart';

class AdkarSectionsPage extends StatelessWidget {
  const AdkarSectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarDesktop(title: 'الأذكار'),
      body: BlocBuilder<AdkarCubit, AdkarState>(
        builder: (context, state) {
          if (state.status == AdkarStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          } else if (state.status == AdkarStatus.failure) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          } else if (state.status == AdkarStatus.success) {
            return Row(
              children: [
                // Left Side - Hero Section with Cover Image
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AdkarImages.cover),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),

                // Right Side - Sections List
                Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.grey[50],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'اختر القسم',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'استعرض الأذكار المتاحة',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),

                        // Sections List
                        Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.fromLTRB(40, 0, 40, 40),
                            itemCount: state.sections.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 16),
                            itemBuilder: (context, index) {
                              final section = state.sections[index];
                              return AdkarSectionItemWidget(
                                section: section,
                                index: index,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
