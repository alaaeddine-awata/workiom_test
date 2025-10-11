import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../resources/theme_manager.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isPrimary;
  final double? width;
  final double? height;
  final Widget? icon;
  final Widget? suffixIcon;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isPrimary = true,
    this.width,
    this.height,
    this.icon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null && !isLoading;

    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 50.h,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary
              ? (isEnabled
                    ? ThemeManager.primaryBlue
                    : ThemeManager.disabledGray)
              : ThemeManager.lightGray,
          foregroundColor: isPrimary ? ThemeManager.white : Colors.black87,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 20.w,
                height: 20.h,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isPrimary ? ThemeManager.white : ThemeManager.primaryBlue,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[icon!, SizedBox(width: 8.w)],
                  if (suffixIcon != null) Spacer(),
                  Text(text, style: Theme.of(context).textTheme.labelLarge?.copyWith(color: isPrimary ? ThemeManager.white : Colors.black)),
                  if (suffixIcon != null) ...[Spacer(), suffixIcon!],
                ],
              ),
      ),
    );
  }
}
