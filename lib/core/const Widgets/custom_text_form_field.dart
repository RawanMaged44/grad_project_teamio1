import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_colors.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final String? labelText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool isPassword;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final Color? fillColor;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.validator,
    this.onChanged,
    this.fillColor,
    this.inputFormatters,
    this.focusNode,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: TextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        keyboardType: widget.keyboardType,
        obscureText: _obscureText,
        inputFormatters: widget.inputFormatters,
        onChanged: widget.onChanged,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: widget.validator,
        cursorColor: Colors.white,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.fillColor ?? AppColors.whiteColor,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 14.h,
          ),
          hintText: widget.hintText,
          labelText: widget.labelText,
          hintStyle: TextStyle(color: AppColors.whiteColor, fontSize: 14.sp),
          labelStyle: const TextStyle(color: AppColors.blackColor),
          prefixIcon: widget.prefixIcon != null
              ? Icon(widget.prefixIcon, color: Colors.black54, size: 20.sp)
              : null,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white54,
                    size: 20.sp,
                  ),
                  onPressed: () => setState(() => _obscureText = !_obscureText),
                )
              : widget.suffixIcon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: const BorderSide(color: AppColors.redColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: const BorderSide(color: AppColors.redColor, width: 1),
          ),
        ),
      ),
    );
  }
}
