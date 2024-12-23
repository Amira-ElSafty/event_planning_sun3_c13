import 'package:flutter/material.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_styles.dart';

class CustomElevatedButton extends StatelessWidget {
  Color? backgroundColor;
  Function onButtonClicked;
  String text;
  TextStyle? textStyle;
  Widget? icon ;

  CustomElevatedButton(
      {this.backgroundColor,
      this.textStyle,
        this.icon,
      required this.onButtonClicked,
      required this.text});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.04, vertical: height * 0.02),
            backgroundColor: backgroundColor ?? AppColors.primaryLight,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(
                color: AppColors.primaryLight,
                width: 2
              )
            )),
        onPressed: () {
          onButtonClicked();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon ?? SizedBox(),
            SizedBox(
              width: width * 0.02,
            ),
            Text(
              text,
              style: textStyle ?? AppStyles.medium20White,
            )
          ],
        ));
  }
}
