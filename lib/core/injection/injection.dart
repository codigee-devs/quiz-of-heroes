import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

/// Configures dependency injection generator
/// Run build runner every time when adding new dependencies
///
/// Command:
/// flutter pub run build_runner build
/// flutter pub run build_runner build --delete-conflicting-outputs

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
// Invoke at app start
Future<void> configureDependencies() async => $initGetIt(getIt);
