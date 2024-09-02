part of 'convert_bloc.dart';

enum ConvertStatus {
  initial,
  loading,
  loaded,
  error,
}

@freezed
class ConvertState with _$ConvertState {
  const factory ConvertState({
    @Default(ConvertStatus.initial) status,
    Map<int, String>? numberMap,
    Map<int, String>? groupMap,
    String? textResult,
    String? errorMessage,
  }) = _ConvertState;
}

