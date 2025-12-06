import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noor/Core/theme/app_colors.dart';
import '../../presentation/manager/adkar_cubit.dart';
import '../../presentation/manager/adkar_state.dart';
import '../../data/models/adkar_detail_model.dart';

class AdkarDetailsPage extends StatelessWidget {
  final int sectionId;
  final String sectionName;

  const AdkarDetailsPage({
    super.key,
    required this.sectionId,
    required this.sectionName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          sectionName,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
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
            return ListView.builder(
              padding: EdgeInsets.all(16.w),
              itemCount: state.details.length,
              itemBuilder: (context, index) {
                return _AdkarItem(detail: state.details[index]);
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

  const _AdkarItem({required this.detail});

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
    }
  }

  @override
  Widget build(BuildContext context) {
    if (count == 0) {
      return const SizedBox.shrink(); // Hide the item when count is 0
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
