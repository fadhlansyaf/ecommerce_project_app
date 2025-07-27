import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

enum DataStatus { initial, loading, success, failure }

class DataState<T> extends Equatable with DiagnosticableTreeMixin {
  final DataStatus status;
  final T? data;
  final String? error;

  const DataState._({required this.status, this.data, this.error});

  const DataState.initial() : this._(status: DataStatus.initial);
  const DataState.loading() : this._(status: DataStatus.loading);
  const DataState.success(T data)
      : this._(status: DataStatus.success, data: data);
  const DataState.failure(String error)
      : this._(status: DataStatus.failure, error: error);

  bool get isInitial => status == DataStatus.initial;
  bool get isLoading => status == DataStatus.loading;
  bool get isSuccess => status == DataStatus.success;
  bool get isFailure => status == DataStatus.failure;

  @override
  List<Object?> get props => [status, data, error];

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    switch (status) {
      case DataStatus.initial:
        return 'DataState<$T>: Initial';
      case DataStatus.loading:
        return 'DataState<$T>: Loading';
      case DataStatus.success:
        // print just the runtimeType of data to avoid dumping huge objects
        return 'DataState<$T>: Success(dataType=${data.runtimeType})';
      case DataStatus.failure:
        return 'DataState<$T>: Failure(error=$error)';
    }
  }

  /// Exhaustive handler, like a `when` or `fold` on union types.
  R fold<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function(T data) success,
    required R Function(String error) failure,
  }) {
    switch (status) {
      case DataStatus.initial:
        return initial();
      case DataStatus.loading:
        return loading();
      case DataStatus.success:
        return success(data as T);
      case DataStatus.failure:
        return failure(error!);
    }
  }
}
