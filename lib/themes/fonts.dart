import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFonts {
  static TextStyle gemunuLibreRegular(
      {required Color color, required double fontsize}) {
    return GoogleFonts.gemunuLibre(
      textStyle: TextStyle(
        color: color,
        fontSize: fontsize,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  static TextStyle interSemiBold(
      {required Color color, required double fontsize}) {
    return GoogleFonts.inter(
      textStyle: TextStyle(
        color: color,
        fontSize: fontsize,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  static TextStyle interMedium(
      {required Color color, required double fontsize}) {
    return GoogleFonts.inter(
      textStyle: TextStyle(
        color: color,
        fontSize: fontsize,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  static TextStyle interRegular(
      {required Color color, required double fontsize}) {
    return GoogleFonts.inter(
      textStyle: TextStyle(
        color: color,
        fontSize: fontsize,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  static TextStyle interLight(
      {required Color color, required double fontsize}) {
    return GoogleFonts.inter(
      textStyle: TextStyle(
        color: color,
        fontSize: fontsize,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  static TextStyle interExtraLight(
      {required Color color, required double fontsize}) {
    return GoogleFonts.inter(
      textStyle: TextStyle(
        color: color,
        fontSize: fontsize,
        fontWeight: FontWeight.w200,
      ),
    );
  }
}
