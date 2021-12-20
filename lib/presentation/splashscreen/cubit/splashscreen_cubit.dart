import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/app/remote.dart';
import '../../../core/injection/injection.dart';
import '../../../core/logger/logger.dart';
import '../../../data/local_data_source/database/database_client/database_client_factory.dart';

part 'splashscreen_cubit.freezed.dart';
part 'splashscreen_state.dart';

class SplashscreenCubit extends Cubit<SplashscreenState> {
  SplashscreenCubit() : super(SplashscreenState.initial());

  Future<void> initServices() async {
    await _configureLayout();
    _emitStatus(0.25);
    await _configureInitialDependences();
    _emitStatus(0.50);
    await _configureLogAndErrorHandler();
    _emitStatus(0.75);
    await _configureDatabases();
    _emitStatus(1.0);
  }

  Future<void> _configureLayout() async {
    await WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setEnabledSystemUIOverlays([]);
    await SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  // Most importantly, sequence matters
  Future<void> _configureInitialDependences() async {
    await AppLogger.init();
    await RemoteCore.initializeFirebase();
    await RemoteCore.userAuthentication();
    await configureDependencies();
  }

  Future<void> _configureLogAndErrorHandler() async {
    await RemoteCore.configureCrashlytics();
  }

  Future<void> _configureDatabases() async {
    await DatabaseClientFactory.create();
  }

  Future<void> _emitStatus(double value) async => emit(SplashscreenState.loading(value));
}
