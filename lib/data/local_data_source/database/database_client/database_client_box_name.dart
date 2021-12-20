import 'database_client_box_name_factory.dart';

abstract class DatabaseClientBoxName {
  static const _artefacts = 'artefacts';
  static const _general = 'general';
  static const _instanceId = 'instanceId';
  static const _userGeneralInstance = 'userGeneralInstance';
  static const _userInstance = 'userInstance';
  static const _userSetting = 'userSetting';
  static const _userGainedStory = 'userGainedStory';

  static String artefacts() => DatabaseClientBoxNameFactory.build(type: _artefacts);
  static String general() => DatabaseClientBoxNameFactory.build(type: _general);
  static String instanceId() => DatabaseClientBoxNameFactory.build(type: _instanceId);
  static String userGeneralInstance() => DatabaseClientBoxNameFactory.build(type: _userGeneralInstance);
  static String userInstance() => DatabaseClientBoxNameFactory.build(type: _userInstance);
  static String userSetting() => DatabaseClientBoxNameFactory.build(type: _userSetting);
  static String userGainedStory() => DatabaseClientBoxNameFactory.build(type: _userGainedStory);
}
