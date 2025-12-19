import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noor/Core/theme/app_colors.dart';
import 'package:noor/Core/widgets/custom_app_bar.dart';
import 'package:noor/Feature/Adkar/presentation/views/desktop/widgets/adkar_completion_desktop_widget.dart';
import 'package:noor/Feature/Adkar/presentation/views/desktop/widgets/adkar_item_desktop_widget.dart';
import '../../manager/adkar_cubit.dart';
import '../../manager/adkar_state.dart';

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
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<AdkarCubit>().loadSectionDetails(widget.sectionId);
  }

  void _onCompleted() {
    setState(() {
      _completedIndices.add(_currentIndex);
      // Move to next incomplete item
      _moveToNextIncomplete();
    });
  }

  void _moveToNextIncomplete() {
    final state = context.read<AdkarCubit>().state;
    for (int i = _currentIndex + 1; i < state.details.length; i++) {
      if (!_completedIndices.contains(i)) {
        setState(() => _currentIndex = i);
        return;
      }
    }
    // If no next item, try from beginning
    for (int i = 0; i < _currentIndex; i++) {
      if (!_completedIndices.contains(i)) {
        setState(() => _currentIndex = i);
        return;
      }
    }
  }

  void _moveToPrevious() {
    if (_currentIndex > 0) {
      setState(() => _currentIndex--);
    }
  }

  void _moveToNext() {
    final state = context.read<AdkarCubit>().state;
    if (_currentIndex < state.details.length - 1) {
      setState(() => _currentIndex++);
    }
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
              return const AdkarCompletionDesktopWidget();
            }

            final currentDetail = state.details[_currentIndex];
            final isCompleted = _completedIndices.contains(_currentIndex);

            return Container(
              color: Colors.grey[50],
              child: Column(
                children: [
                  // Top Progress Bar
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Progress Text
                        Text(
                          'التقدم: ${_completedIndices.length} / ${state.details.length}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(width: 24),
                        // Progress Bar
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value:
                                  _completedIndices.length /
                                  state.details.length,
                              minHeight: 12,
                              backgroundColor: Colors.grey[200],
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 24),
                        // Percentage
                        Text(
                          '${((_completedIndices.length / state.details.length) * 100).toInt()}%',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Main Content - Current Adkar
                  Expanded(
                    child: Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 900),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 20,
                        ),
                        child: AdkarItemDesktopWidget(
                          detail: currentDetail,
                          isCompleted: isCompleted,
                          onCompleted: _onCompleted,
                          onPrevious: _currentIndex > 0
                              ? _moveToPrevious
                              : null,
                          onNext: _currentIndex < state.details.length - 1
                              ? _moveToNext
                              : null,
                          currentIndex: _currentIndex + 1,
                          totalCount: state.details.length,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
