import 'package:number_to_text_converter/common/core/error/failure.dart';
import 'package:number_to_text_converter/common/core/result/result.dart';

abstract class NumberRepository {
  Future<Result<Map<int, String>, Failure>> getNumberMap();

  Future<Result<Map<int, String>, Failure>> getGroupMap();
}
