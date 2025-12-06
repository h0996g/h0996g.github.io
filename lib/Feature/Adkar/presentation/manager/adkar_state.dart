import 'package:equatable/equatable.dart';
import '../../data/models/adkar_section_model.dart';
import '../../data/models/adkar_detail_model.dart';

enum AdkarStatus { initial, loading, success, failure }

class AdkarState extends Equatable {
  final AdkarStatus status;
  final List<AdkarSectionModel> sections;
  final List<AdkarDetailModel> details;
  final String? errorMessage;

  const AdkarState({
    this.status = AdkarStatus.initial,
    this.sections = const [],
    this.details = const [],
    this.errorMessage,
  });

  AdkarState copyWith({
    AdkarStatus? status,
    List<AdkarSectionModel>? sections,
    List<AdkarDetailModel>? details,
    String? errorMessage,
  }) {
    return AdkarState(
      status: status ?? this.status,
      sections: sections ?? this.sections,
      details: details ?? this.details,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, sections, details, errorMessage];
}
