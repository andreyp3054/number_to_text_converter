part of 'convert_bloc.dart';

@freezed
class ConvertEvent with _$ConvertEvent {
  const factory ConvertEvent.getNumberMap() = _GetNumberMap;
  const factory ConvertEvent.getGroupMap() = _GetGroupMap;
  const factory ConvertEvent.convertToText(String userInput) = _ConvertToText;
}
