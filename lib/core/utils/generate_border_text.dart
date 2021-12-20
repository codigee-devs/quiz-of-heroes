part of 'utils.dart';

///
/// This function generates a text border by generating many shadows
/// [Color borderColor] what color the border should be
/// [double borderWidth] border size
/// [int precision] higher precision equals better border, but also worst performance
///


List<Shadow> generateBorderTextByShadows({required Color borderColor, double borderWidth = 2, int precision = 5}){
  Set<Shadow> result = HashSet();
  for (var x = 1; x < borderWidth + precision; x++) {
    for (var y = 1; y < borderWidth + precision; y++) {
      final offsetX = x.toDouble();
      final offsetY = y.toDouble();
      result.add(Shadow(offset: Offset(-borderWidth / offsetX, -borderWidth / offsetY), color: borderColor));
      result.add(Shadow(offset: Offset(-borderWidth / offsetX, borderWidth / offsetY), color: borderColor));
      result.add(Shadow(offset: Offset(borderWidth / offsetX, -borderWidth / offsetY), color: borderColor));
      result.add(Shadow(offset: Offset(borderWidth / offsetX, borderWidth / offsetY), color: borderColor));
    }
  }
  return result.toList();
}
