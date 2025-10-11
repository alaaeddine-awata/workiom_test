import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:workiom_test/presentation/resources/assets_manager.dart';
import '../resources/theme_manager.dart';

class BaseScreen extends StatelessWidget {
  final String? title;
  final Widget body;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final bool showFooter;
  final EdgeInsetsGeometry? padding;

  const BaseScreen({
    super.key,
     this.title,
    required this.body,
    this.showBackButton = true,
    this.onBackPressed,
    this.showFooter = true,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeManager.white,
      appBar: showBackButton ? _buildAppBar(context) : null,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: padding ?? EdgeInsets.symmetric(horizontal: 24.w),
              child: body,
            ),
          ),
          if (showFooter) _buildFooter(context),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: GestureDetector(
        onTap: onBackPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 16.w),
            Icon(
              Icons.arrow_back_ios,
              color: ThemeManager.primaryBlue,
              size: 20.w,
            ),
            if(title != null)
            Row(
              children: [
                SizedBox(width: 5.w),
                Text(
                  title!,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ],
        ),
      ),
      leadingWidth: 100.w,
      automaticallyImplyLeading: false,
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Stay organized with',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          SizedBox(width: 8.w),
         SvgPicture.asset(AssetsManager.logoWithTitle),
        ],
      ),
    );
  }
}
