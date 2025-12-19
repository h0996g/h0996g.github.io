import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noor/Core/const/app_images.dart';
import 'package:noor/Core/theme/app_colors.dart';
import 'package:noor/Feature/Adkar/presentation/views/mobile/widgets/adkar_section_item_widget.dart';
import '../../manager/adkar_cubit.dart';
import '../../manager/adkar_state.dart';

class AdkarSectionsPage extends StatelessWidget {
  const AdkarSectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AdkarCubit, AdkarState>(
        builder: (context, state) {
          if (state.status == AdkarStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          } else if (state.status == AdkarStatus.failure) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          } else if (state.status == AdkarStatus.success) {
            return Column(
              children: [
                // Compact Header with Cover Image
                SizedBox(
                  height: 250.h,

                  width: double.infinity,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Cover Image
                      Image.asset(AdkarImages.cover, fit: BoxFit.cover),
                      // Gradient Overlay
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.3),
                              Colors.black.withOpacity(0.6),
                            ],
                          ),
                        ),
                      ),
                      // Title and Back Button
                      Positioned(
                        top: 16.h,

                        child: Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: EdgeInsets.all(16.w),
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 24.sp,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Grid of Adkar Sections (Non-scrollable)
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.1,
                        crossAxisSpacing: 12.w,
                        mainAxisSpacing: 12.h,
                      ),
                      itemCount: state.sections.length,
                      itemBuilder: (context, index) {
                        final section = state.sections[index];
                        return AdkarSectionItemWidget(
                          section: section,
                          index: index,
                        );
                      },
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
