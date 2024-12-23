import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_styles.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
      primaryColor: AppColors.primaryLight,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.primaryLight,
          shape: StadiumBorder(
              side: BorderSide(color: AppColors.whiteColor, width: 4))
          // RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(50),
          //   side: BorderSide(
          //     color: AppColors.whiteColor,
          //     width: 4
          //   )
          // )
          ),
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
          color: AppColors.blackColor
        )
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          showUnselectedLabels: true,
          selectedLabelStyle: AppStyles.bold12White,
          unselectedLabelStyle: AppStyles.bold12White,
          elevation: 0));

  static final ThemeData darkTheme = ThemeData(
      primaryColor: AppColors.primaryDark,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.primaryDark,
          shape: StadiumBorder(
              side: BorderSide(color: AppColors.whiteColor, width: 4))),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          showUnselectedLabels: true,
          selectedLabelStyle: AppStyles.bold12White,
          unselectedLabelStyle: AppStyles.bold12White,
          elevation: 0),
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
            color: AppColors.primaryLight
        )
    ),
  );
}
