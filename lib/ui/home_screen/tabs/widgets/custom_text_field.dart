import '../../../../utils/app_colors.dart';
import '../../../../utils/app_styles.dart';
import 'package:flutter/material.dart';

typedef MyValidator = String? Function(String?)? ;

class CustomTextField extends StatelessWidget {
  Color? borderColor ;
  String? hintText ;
  String? labelText ;
  TextStyle? hintStyle ;
  TextStyle? labelStyle ;
  Widget? prefixIcon ;
  Widget? suffixIcon ;
  bool obscureText ;
  int? maxLines ;
  MyValidator validator ;
  TextEditingController? controller ;

  CustomTextField({this.borderColor,this.hintText,this.labelText,
  this.hintStyle,this.labelStyle,this.suffixIcon,this.maxLines,
    this.controller,
    this.prefixIcon, this.obscureText = false,this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      obscureText: obscureText,
      obscuringCharacter: '*',
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        labelText: labelText ,
        hintStyle: hintStyle ?? AppStyles.medium16Grey,
        labelStyle: labelStyle ?? AppStyles.medium16Grey,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: borderColor ?? AppColors.greyColor,
            width: 2
          )
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
                color: borderColor ?? AppColors.greyColor,
                width: 2
            )
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
                color: AppColors.redColor,
                width: 2
            )
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
                color: AppColors.redColor,
                width: 2
            )
        ),

      ),
    );
  }
}
