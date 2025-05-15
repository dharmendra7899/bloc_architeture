import 'package:counter_demo_bloc/res/widgets/context_extension.dart';
import 'package:counter_demo_bloc/theme/colors.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String title;
  final String? icon;
  final Function()? onPressed;
  final bool isLoading;
  final bool? isBorder;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final double? radius;
  final double? height;
  final double? width;
  final double? fontSize;

  const AppButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.icon,
    this.color,
    this.textColor,
    this.borderColor,
    this.isBorder,
    this.radius,
    this.height = 50,
    this.fontSize = 16,
    this.width,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading == true ? null : onPressed,
      borderRadius: BorderRadius.circular(radius ?? 12),
      child: Container(
        width: width ?? MediaQuery.of(context).size.width,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [appColors.gradient2, appColors.gradient3],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            tileMode: TileMode.decal,
          ),
          borderRadius: BorderRadius.circular(radius ?? 12),
          border: Border.all(color: appColors.secondaryLight, width: 2),
        ),
        child: Center(
          child:
              isLoading == true
                  ? CircularProgressIndicator.adaptive(
                    strokeAlign: BorderSide.strokeAlignCenter,
                    strokeWidth: 2,
                    trackGap: 12,
                    strokeCap: StrokeCap.round,
                    constraints: BoxConstraints(minHeight: 25, minWidth: 25),
                    backgroundColor: appColors.barColor,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      appColors.appWhite,
                    ),
                  )
                  : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      icon != null
                          ? Image.asset(icon!, height: 20, width: 20)
                          : SizedBox(),
                      icon != null ? SizedBox(width: 12) : SizedBox(),
                      Text(
                        title,
                        style: context.textTheme.titleMedium?.copyWith(
                          fontSize: fontSize,
                          color: textColor ?? appColors.titleColor1,
                        ),
                      ),
                    ],
                  ),
        ),
      ),
    );
  }
}
