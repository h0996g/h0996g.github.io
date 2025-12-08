part of 'feedback_cubit.dart';

enum FeedbackStatus { initial, loading, success, error }

enum FeedbackMethod { email, whatsapp, anonymous }

class FeedbackState extends Equatable {
  final FeedbackStatus status;
  final String? message;

  const FeedbackState({this.status = FeedbackStatus.initial, this.message});

  FeedbackState copyWith({FeedbackStatus? status, String? message}) {
    return FeedbackState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, message];
}
