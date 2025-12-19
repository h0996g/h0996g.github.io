import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noor/Core/theme/app_colors.dart';
import 'package:noor/Feature/Adkar/presentation/views/mobile/widgets/adkar_completion_widget.dart';
import 'package:noor/Feature/Adkar/presentation/views/mobile/widgets/adkar_item_widget.dart';
import '../../manager/adkar_cubit.dart';
import '../../manager/adkar_state.dart';
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
              return const AdkarCompletionWidget();
            }

            return ListView.builder(
              padding: EdgeInsets.all(16.w),
              itemCount: state.details.length,
              itemBuilder: (context, index) {
                if (_completedIndices.contains(index)) {
                  return const SizedBox.shrink();
                }
                return AdkarItemWidget(
                  key: ValueKey(index),
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
