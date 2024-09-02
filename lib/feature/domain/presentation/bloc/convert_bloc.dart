import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:number_to_text_converter/common/core/error/failure.dart';
import 'package:number_to_text_converter/common/core/result/result.dart';
import 'package:number_to_text_converter/common/core/usecase/use_case.dart';
import 'package:number_to_text_converter/feature/domain/usecase/get_group_map.dart';
import 'package:number_to_text_converter/feature/domain/usecase/get_number_map.dart';

part 'convert_event.dart';

part 'convert_state.dart';

part 'convert_bloc.freezed.dart';

@injectable
class ConvertBloc extends Bloc<ConvertEvent, ConvertState> {
  final GetGroupMap getGroupUseCase;
  final GetNumberMap getNumberUseCase;

  ConvertBloc(
    this.getGroupUseCase,
    this.getNumberUseCase,
  ) : super(const ConvertState()) {
    on<ConvertEvent>((event, emit) async {
      switch (event) {
        case _GetGroupMap():
          await _getGroupMap(event, emit);
          break;

        case _GetNumberMap():
          await _getNumberMap(event, emit);
          break;

        case _ConvertToText():
          await _convertToText(event, emit);
          break;
      }
    });

    add(const ConvertEvent.getGroupMap());
    add(const ConvertEvent.getNumberMap());
  }

  Future<void> _getNumberMap(
      _GetNumberMap event, Emitter<ConvertState> emit) async {
    try {
      emit(state.copyWith(status: ConvertStatus.loading));
      final result = await getNumberUseCase.call(const NoParams());

      switch (result) {
        case ResultSuccess<Map<int, String>, Failure>():
          emit(state.copyWith(
              status: ConvertStatus.loaded, numberMap: result.value));
          break;
        case ResultError(:final failure):
          emit(
            state.copyWith(
              status: ConvertStatus.error,
              errorMessage: failure.toString(),
            ),
          );
          break;
      }
    } catch (error) {
      emit(
        state.copyWith(
          status: ConvertStatus.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> _getGroupMap(
      _GetGroupMap event, Emitter<ConvertState> emit) async {
    try {
      emit(state.copyWith(status: ConvertStatus.loading));
      final result = await getGroupUseCase.call(const NoParams());

      switch (result) {
        case ResultSuccess<Map<int, String>, Failure>():
          emit(state.copyWith(
              status: ConvertStatus.loaded, groupMap: result.value));
          break;
        case ResultError(:final failure):
          emit(
            state.copyWith(
              status: ConvertStatus.error,
              errorMessage: failure.toString(),
            ),
          );
          break;
      }
    } catch (error) {
      emit(
        state.copyWith(
          status: ConvertStatus.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> _convertToText(_ConvertToText event, Emitter emit) async {
    try {
      emit(state.copyWith(status: ConvertStatus.loading));
      final numberAsDouble = double.parse(event.userInput);
      final formatter = NumberFormat("#,###");
      String formattedText = formatter.format(numberAsDouble);
      final List<String> groups = formattedText.split(",");

      int groupPosition = groups.length;
      StringBuffer textResult = StringBuffer();

      for (String currentGroup in groups) {
        int value = int.parse(currentGroup);
        if (value == 0) {
          groupPosition--;
          continue;
        }
        if (state.numberMap != null && state.groupMap != null) {
          textResult.write(getExactWords(value, groupPosition));
          groupPosition--;
        }
      }
      debugPrint(textResult.toString());
      emit(state.copyWith(
        status: ConvertStatus.loaded,
        textResult: textResult.toString(),
      ));
    } catch (error) {
      emit(
        state.copyWith(
          status: ConvertStatus.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  String getExactWords(int value, int groupPosition) {
    StringBuffer stringBuffer = StringBuffer();

    int hundredCount = value ~/ 100;
    int remainder = value % 100;

    if (hundredCount > 0) {
      stringBuffer.write("${state.numberMap?[hundredCount]} Hundred ");
    }
    if (remainder > 0) {
      if (!state.numberMap!.containsKey(remainder)) {
        //IF BELOW 20
        if (remainder < 20) {
          stringBuffer.write("${state.numberMap?[remainder - 10]}teen ");
        } else {
          int tenths = remainder ~/ 10;
          int tenthsRemainder = remainder % 10;

          String notFoundTenthsWord = "${state.numberMap?[tenths]}ty";
          //Find default tenths words first like "TWENTY" before moving to number + "ty"
          state.numberMap!.containsKey(tenths * 10)
              ? stringBuffer.write("${state.numberMap?[tenths * 10]}")
              : stringBuffer.write(notFoundTenthsWord);
          if (tenthsRemainder > 0) {
            stringBuffer.write("-${state.numberMap?[tenthsRemainder]} ");
          }
        }
      } else {
        // If exact number key is already present
        stringBuffer.write("${state.numberMap?[remainder]} ");
      }
    }
    stringBuffer.write("${state.groupMap?[groupPosition] ?? ""} ");

    debugPrint(stringBuffer.toString());
    return stringBuffer.toString();
  }
}
