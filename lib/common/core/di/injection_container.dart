import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection_container.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  preferRelativeImports: true,
  initializerName: "init",
  asExtension: true,
)
FutureOr<void> configureDependencies({String? environment}) =>
    getIt.init(environment: environment);
