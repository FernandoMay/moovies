import 'package:flutter/cupertino.dart';

const Color primaryColor = Color(0xFFFF6000);
const Color secondaryColor = Color(0xFFFFA559);
const Color bgColor = Color(0xFF454545);
const Color lightColor = Color(0xFFFFE6C7);
const Color dangerColor = Color(0xFFDF2E38);
const Color successColor = Color(0xFF5D9C59);
const Color textColor = Color(0xFFF4EEE0);
const Color greyLightColor = Color(0xFF4F4557);
const LinearGradient primaryGradientColor = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      secondaryColor,
      primaryColor,
    ]);

const tsH3Blue = TextStyle(
  fontFamily: "Texturina",
  fontSize: 20.0,
  fontWeight: FontWeight.w400,
  color: primaryColor,
);

const tsH2Blue = TextStyle(
  fontFamily: "Texturina",
  fontSize: 17.0,
  fontWeight: FontWeight.w500,
  color: primaryColor,
);

const tsH1Blue = TextStyle(
  fontFamily: "Texturina",
  fontSize: 15.0,
  fontWeight: FontWeight.w500,
  color: primaryColor,
);

const tsH4Black = TextStyle(
  fontFamily: "Texturina",
  fontSize: 25.0,
  fontWeight: FontWeight.w400,
  color: textColor,
  shadows: [
    Shadow(
      color: CupertinoColors.black,
      blurRadius: 2.0,
      offset: Offset(1.0, 1.0),
    ),
  ],
);

const tsH3Black = TextStyle(
  fontFamily: "Texturina",
  fontSize: 20.0,
  fontWeight: FontWeight.w400,
  color: textColor,
  shadows: [
    Shadow(
      color: CupertinoColors.black,
      blurRadius: 2.0,
      offset: Offset(1.0, 1.0),
    ),
  ],
);

const tsH2Black = TextStyle(
  fontFamily: "Texturina",
  fontSize: 16.0,
  fontWeight: FontWeight.w400,
  color: textColor,
  shadows: [
    Shadow(
      color: CupertinoColors.black,
      blurRadius: 2.0,
      offset: Offset(1.0, 1.0),
    ),
  ],
);

const tsH1Black = TextStyle(
  fontFamily: "Texturina",
  fontSize: 14.0,
  fontWeight: FontWeight.w400,
  color: textColor,
  shadows: [
    Shadow(
      color: CupertinoColors.black,
      blurRadius: 2.0,
      offset: Offset(1.0, 1.0),
    ),
  ],
);

const tsH2White = TextStyle(
  fontFamily: "Texturina",
  fontSize: 18.0,
  fontWeight: FontWeight.w400,
  color: textColor,
);

const tsH4White = TextStyle(
  fontFamily: "Texturina",
  fontSize: 28.0,
  fontWeight: FontWeight.w400,
  color: textColor,
);
