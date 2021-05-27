import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:odoo_app/constants/colors.dart';
import 'package:odoo_app/constants/styles.dart';

class MyTextField extends StatelessWidget {
  final String? hintText;
  final bool obscureText;
  final keyboardType;
  final textInputAction;
  final sufixIcon;
  final int? maxLines;
  final maxLength;
  final TextAlign? textAlign;
  final text;
  final controller;
  final ValueChanged<String>? onTextChange;
  final String? validator;

  MyTextField(
      {this.controller,
      this.textAlign,
      this.text,
      this.maxLength,
      this.maxLines = 1,
      this.hintText,
      this.obscureText = false,
      this.keyboardType,
      this.textInputAction,
      this.onTextChange,
      this.validator,
      this.sufixIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      style: kTextFieldStyle,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      validator: (value) {
        if(value!.isEmpty){
          return validator;
        }
      },
      onChanged: (value) {
        if (onTextChange != null) onTextChange!(value);
      },
      decoration: InputDecoration(
        suffixIcon: sufixIcon,
        contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
        errorStyle: kTextFieldErrorStyle.copyWith(height: 0.4.h),
        filled: true,
        fillColor: kWhiteColor,
        border: UnderlineInputBorder(
            borderRadius:BorderRadius.circular(5.r),
            borderSide: BorderSide.none

        ),


      ),
    );
  }
}

class NeverFocusNode extends FocusNode {
  @override
  bool get hasFocus {
    return false;
  }
}
