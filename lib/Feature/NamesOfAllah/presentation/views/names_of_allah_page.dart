import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noor/Core/theme/app_colors.dart';
import '../../data/repo/names_of_allah_repo.dart';
import '../../presentation/manager/names_of_allah_cubit.dart';
import '../../presentation/manager/names_of_allah_state.dart';
import '../../data/models/name_of_allah_model.dart';
import 'name_detail_dialog.dart';

class NamesOfAllahPage extends StatelessWidget {
  const NamesOfAllahPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          NamesOfAllahCubit(NamesOfAllahRepository())..loadNames(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'أسماء الله الحسنى',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: AppColors.primary,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: BlocBuilder<NamesOfAllahCubit, NamesOfAllahState>(
          builder: (context, state) {
            if (state.status == NamesOfAllahStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            } else if (state.status == NamesOfAllahStatus.failure) {
              return Center(child: Text('Error: ${state.errorMessage}'));
            } else if (state.status == NamesOfAllahStatus.success) {
              return GridView.builder(
                padding: EdgeInsets.all(16.w),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 12.h,
                  childAspectRatio: 1.0,
                ),
                itemCount: state.names.length,
                itemBuilder: (context, index) {
                  final name = state.names[index];
                  return _NameCard(nameModel: name);
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _NameCard extends StatelessWidget {
  final NameOfAllahModel nameModel;

  const _NameCard({required this.nameModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => NameDetailDialog(nameModel: nameModel),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(color: AppColors.secondary.withValues(alpha: 0.2)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              nameModel.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
