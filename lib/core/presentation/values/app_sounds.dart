part of 'values.dart';

abstract class AppSounds {
  static final _path = 'sounds/';

  static final wavAppBaseTap = _getRes('wavAppBaseTap');
  static final wavAppBaseTap2 = _getRes('wavAppBaseTap2');
  static final wavAppMusic = _getRes('wavAppMusic');
  static final wavAppMusic2 = _getRes('wavAppMusic2');
  static final wavAppMusic3 = _getRes('wavAppMusic3');
  static final wavQuizArtefactBomb = _getRes('wavQuizArtefactBomb');
  static final wavQuizArtefactDiamond = _getRes('wavQuizArtefactDiamond');
  static final wavQuizArtefactScroll = _getRes('wavQuizArtefactScroll');
  static final wavQuizLose = _getRes('wavQuizLose');
  static final wavQuizUnveilQuestion = _getRes('wavQuizUnveilQuestion');
  static final wavQuizWin = _getRes('wavQuizWin');
  static final wavQuizWin2 = _getRes('wavQuizWin2');

  static String _getRes(String res) => '$_path$res.wav';

  // static String _getResMp3(String res) => '$_path$res.mp3';
}
