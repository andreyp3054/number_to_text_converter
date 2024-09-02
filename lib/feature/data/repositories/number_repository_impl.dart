import 'package:injectable/injectable.dart';
import 'package:number_to_text_converter/common/core/error/failure.dart';
import 'package:number_to_text_converter/common/core/result/result.dart';
import 'package:number_to_text_converter/feature/data/data_sources/number_data_source.dart';
import 'package:number_to_text_converter/feature/domain/repositories/number_repository.dart';

@Singleton(as: NumberRepository)
class NumberRepositoryImpl implements NumberRepository {
  final NumberDataSource dataSource;

  NumberRepositoryImpl(this.dataSource);
  @override
  Future<Result<Map<int, String>, Failure>> getNumberMap() async {
    try {
      final result = await dataSource.getNumberMap();
      return Result(result);
    } catch (e) {
      return Result.error(WordNotFoundError());
    }
  }

  @override
  Future<Result<Map<int, String>, Failure>> getGroupMap() async {
    try {
      final result = await dataSource.getGroupMap();
      return Result(result);
    } catch (e) {
      return Result.error(WordNotFoundError());
    }
  }
}
