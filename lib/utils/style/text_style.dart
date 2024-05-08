import '../../imports/index.dart';

class CustomTextStyles {

  TextStyle primary(
      {double? fontSize,
      FontWeight? fontWeight,
      Color? color,
      double? letterSpacing,
      double? height,
      TextDecoration? decoration}) {
    return GoogleFonts.nunito(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
      decoration: decoration,
    );
  }
}
