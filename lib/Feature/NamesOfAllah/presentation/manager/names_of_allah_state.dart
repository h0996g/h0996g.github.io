import 'package:equatable/equatable.dart';
import '../../data/models/name_of_allah_model.dart';

enum NamesOfAllahStatus { initial, loading, success, failure }

class NamesOfAllahState extends Equatable {
  final NamesOfAllahStatus status;
  final List<NameOfAllahModel> names;
  final String? errorMessage;

  const NamesOfAllahState({
    this.status = NamesOfAllahStatus.initial,
    this.names = const [],
    this.errorMessage,
  });

  NamesOfAllahState copyWith({
    NamesOfAllahStatus? status,
    List<NameOfAllahModel>? names,
    String? errorMessage,
  }) {
    return NamesOfAllahState(
      status: status ?? this.status,
      names: names ?? this.names,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, names, errorMessage];

  @override
  String toString() {
    return 'NamesOfAllahState(status: $status, names: ${names.length}, errorMessage: $errorMessage)';
  }
}
