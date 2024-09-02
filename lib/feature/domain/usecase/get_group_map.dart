import 'package:injectable/injectable.dart';
import 'package:number_to_text_converter/common/core/error/failure.dart';
import 'package:number_to_text_converter/common/core/result/result.dart';
import 'package:number_to_text_converter/common/core/usecase/use_case.dart';
import 'package:number_to_text_converter/feature/domain/repositories/number_repository.dart';

@injectable
class GetGroupMap implements Usecase<Map<int, String>, NoParams>{
  final NumberRepository repository;

  GetGroupMap(this.repository);

  @override
  Future<Result<Map<int, String>, Failure>> call(NoParams params) {
   return repository.getGroupMap();
  }

}