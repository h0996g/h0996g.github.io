import 'package:equatable/equatable.dart';

enum TasbihStatus { initial, counting, targetReached }

class TasbihState extends Equatable {
  final TasbihStatus status;
  final int count;
  final int target;
  final int selectedDhikrIndex;

  static const List<String> dhikrOptions = [
    'سبحان الله',
    'الحمد لله',
    'لا إله إلا الله',
    'الله أكبر',
    'سبحان الله العظيم\nسبحان الله وبحمده',
  ];

  const TasbihState({
    this.status = TasbihStatus.initial,
    this.count = 0,
    this.target = 33,
    this.selectedDhikrIndex = 0,
  });

  TasbihState copyWith({
    TasbihStatus? status,
    int? count,
    int? target,
    int? selectedDhikrIndex,
  }) {
    return TasbihState(
      status: status ?? this.status,
      count: count ?? this.count,
      target: target ?? this.target,
      selectedDhikrIndex: selectedDhikrIndex ?? this.selectedDhikrIndex,
    );
  }

  String get currentDhikr => dhikrOptions[selectedDhikrIndex];

  @override
  List<Object?> get props => [status, count, target, selectedDhikrIndex];
}
