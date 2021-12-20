import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure({String? message}) = _Failure;

  factory Failure.databaseClientFailure({String? message}) => Failure(message: message ?? '');

  const factory Failure.instanceAlreadyExist() = FailureInstanceAlreadyExist;
  const factory Failure.instanceNotExist() = FailureInstanceNotExist;
  const factory Failure.invalidParameter() = FailureInvalidParameter;
  const factory Failure.jsonAssetDecode() = FailureJsonAssetDecode;
  const factory Failure.soundStateNotAcceptedFailure() = FailureSoundStateIsNotAccepted;
  const factory Failure.connectionFailure() = ConnectionFailure;
}
