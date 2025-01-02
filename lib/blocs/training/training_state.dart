part of 'training_bloc.dart';

class TrainingState extends Equatable {
  final ResultStatus status;
  final List<Categories>? categories;
  final String message;

  const TrainingState({
    this.status = ResultStatus.none,
    this.categories,
    this.message = '',
  });

  TrainingState update({
    ResultStatus? status,
    List<Categories>? categories,
    String? message,
  }) {
    return TrainingState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [status, categories ?? [], message];
}
