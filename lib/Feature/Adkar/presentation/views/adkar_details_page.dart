import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noor/Core/theme/app_colors.dart';
import '../../presentation/manager/adkar_cubit.dart';
import '../../presentation/manager/adkar_state.dart';
import '../../data/models/adkar_detail_model.dart';
import '../../../Home/presentation/views/widgets/bottom_player_widget.dart';

import 'package:noor/Core/widgets/custom_app_bar.dart';

class AdkarDetailsPage extends StatefulWidget {
  final int sectionId;
  final String sectionName;

  const AdkarDetailsPage({
    super.key,
    required this.sectionId,
    required this.sectionName,
  });

  @override
  State<AdkarDetailsPage> createState() => _AdkarDetailsPageState();
}

class _AdkarDetailsPageState extends State<AdkarDetailsPage> {
  final Set<int> _completedIndices = {};

  @override
  void initState() {
    super.initState();
    context.read<AdkarCubit>().loadSectionDetails(widget.sectionId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.sectionName),
      body: BlocBuilder<AdkarCubit, AdkarState>(
        builder: (context, state) {
          if (state.status == AdkarStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          } else if (state.status == AdkarStatus.failure) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          } else if (state.status == AdkarStatus.success) {
            if (state.details.isEmpty) {
              return const Center(
                child: Text('لا توجد أذكار متاحة في هذا القسم'),
              );
            }

            final allFinished =
                _completedIndices.length == state.details.length &&
                state.details.isNotEmpty;

            if (allFinished) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_circle_outline_rounded,
                        size: 80.sp,
                        color: AppColors.primary,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'تم الانتهاء من الأذكار',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Amiri',
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'تقبل الله منا ومنكم صالح الأعمال',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 40.h),
                      const BottomPlayerWidget(),
                    ],
                  ),
                ),
              );
            }

            return ListView.builder(
              padding: EdgeInsets.all(16.w),
              itemCount: state.details.length,
              itemBuilder: (context, index) {
                if (_completedIndices.contains(index)) {
                  return const SizedBox.shrink();
                }
                return _AdkarItem(
                  key: ValueKey(
                    index,
                  ), // Important for state preservation if needed
                  detail: state.details[index],
                  onCompleted: () {
                    setState(() {
                      _completedIndices.add(index);
                    });
                  },
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _AdkarItem extends StatefulWidget {
  final AdkarDetailModel detail;
  final VoidCallback onCompleted;

  const _AdkarItem({
    super.key,
    required this.detail,
    required this.onCompleted,
  });

  @override
  State<_AdkarItem> createState() => _AdkarItemState();
}

class _AdkarItemState extends State<_AdkarItem> {
  late int count;

  @override
  void initState() {
    super.initState();
    count = widget.detail.count;
  }

  void _decrementCount() {
    if (count > 0) {
      setState(() {
        count--;
      });
      if (count == 0) {
        // Small delay to let the user see the "0" or just disappear?
        // User experience: usually instant or short delay.
        // Let's do a tiny delay for better feel or immediate.
        // Immediate is fine as per usual Adkar apps.
        widget.onCompleted();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (count == 0) {
      return const SizedBox.shrink();
    }
    return GestureDetector(
      onTap: _decrementCount,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (widget.detail.reference.isNotEmpty) ...[
              Text(
                widget.detail.reference,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
            ],
            Text(
              widget.detail.content,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 18.sp,
                height: 1.8,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (widget.detail.description.isNotEmpty) ...[
              SizedBox(height: 12.h),
              Text(
                widget.detail.description,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              alignment: Alignment.center,
              child: Text(
                'التكرار: $count',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
