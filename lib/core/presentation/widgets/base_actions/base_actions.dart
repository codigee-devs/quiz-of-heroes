import '../../../base_features/sound_player/sound_player.dart';
import '../../../injection/injection.dart';
import '../../values/values.dart';

/// Should extends all widgets actions
abstract class BaseActions {
  static void onClickButton(Function onClick) {
    onClick();
    getIt<SoundPlayer>().playShort(AppSounds.wavAppBaseTap2);
  }
}
