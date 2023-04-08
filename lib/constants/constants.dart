import 'package:flutter/material.dart';

import '../utils/router.dart';

class AppColors {
  static Color darkIndigo = const Color(0xFF101452);
  static Color lightIndigo = const Color(0xFFCED9FB);
  static Color indigo = const Color(0xFF7486D4);
  static Color scaffoldColor = const Color(0xFFF4F7FE);
  static Color redScaffoldColor = const Color(0xFFF3E9E9);
  static Color yellowScaffoldColor = const Color(0xFFF3F2E9);
  static Color mediumIndigo = const Color(0xff4338CA);
}

class AppConst {
  static String doctorUrlImage =
      'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80';
  static String nationalIDImage = 'https://egyptconsulate.co.uk/wp-content/uploads/2021/06/NationalID-1.jpg';
  static String graduationCertificateImage = 'https://www.cairo24.com/Upload/libfiles/65/1/346.jpg';
  static String syndicateIDImage = 'https://img.youm7.com/large/202106070421472147.jpg';
  static String clinicImage =
      'https://images.unsplash.com/photo-1629909613654-28e377c37b09?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Y2xpbmljfGVufDB8fDB8fA%3D%3D&w=1000&q=80';
  static String clinicWorkPermitImage = 'https://www.cairo24.com/Upload/libfiles/54/1/541.jpg';
  static String userAvatarPlaceHolderUrl =
      'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png';
}

extension Height on Widget {
  double get height => MediaQuery.of(MagicRouter.currentContext!).size.height;
}

extension Width on Widget {
  double get width => MediaQuery.of(MagicRouter.currentContext!).size.width;
}

extension StringExtension on String {
  String get capitalize => isNotEmpty ? this[0].toUpperCase() + substring(1) : this;
}
