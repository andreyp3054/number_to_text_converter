import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:number_to_text_converter/common/core/error/failure.dart';
import 'package:number_to_text_converter/common/core/result/result.dart';

part 'use_case.freezed.dart';

abstract class Usecase<Type, Params> {
  Future<Result<Type, Failure>> call(Params params);
}

class NoReturn {
  static final NoReturn _singleton = NoReturn._internal();

  // returns the same instance thru factory
  factory NoReturn() {
    return _singleton;
  }

  NoReturn._internal();
}

@freezed
class NoParams with _$NoParams {
  const factory NoParams() = _NoParams;
}
