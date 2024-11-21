import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:renovate_ranger/features/designed_widgets/customDialog.dart';

class SettingsItem extends StatefulWidget {
  const SettingsItem({
    super.key,
    required this.title,
    required this.svgname,
    required this.onTap,
  });
  final String title;
  final String svgname;
  final VoidCallback onTap;
  @override
  State<SettingsItem> createState() => _SettingsItemState();
}

class _SettingsItemState extends State<SettingsItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12).w,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.title,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black87,
                ),
              ),
            ),
            SvgPicture.asset(
              widget.svgname,
              width: 32.w,
              height: 32.h,
            )
          ],
        ),
      ),
    );
    ;
  }
}
