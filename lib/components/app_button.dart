import 'package:crypto_exchange/components/app_text.dart';
import 'package:crypto_exchange/components/app_text_style.dart';
import 'package:crypto_exchange/core/constants/app_colors_path.dart';
import 'package:crypto_exchange/core/enum/enum.dart';
import 'package:flutter/cupertino.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onTap;
  final ButtonState buttonState;
  final String? leftIconPath;
  final String? rightIconPath;
  final String title;
  final double? width;

  const AppButton({
    required this.title,
    this.leftIconPath,
    this.rightIconPath,
    this.onTap,
    this.buttonState = ButtonState.normal,
    this.width = double.infinity,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: _getBorderColor(), width: 2),
          borderRadius: BorderRadius.circular(12),
          color: _getButtonColor(),
        ),
        width: width,
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (leftIconPath != null) ...[
              Image.asset(leftIconPath!),
              const SizedBox(width: 6),
            ],
            AppText(
              content: title,
              style: AppTextStyle.text16Medium.copyWith(
                fontSize: 18,
                color: _getTitleColor(),
              ),
            ),
            if (rightIconPath != null) ...[
              const SizedBox(width: 6),
              Image.asset(rightIconPath!),
            ],
          ],
        ),
      ),
    );
  }

  Color _getButtonColor() {
    switch (buttonState) {
      case ButtonState.normal:
        return AppColorsPath.blue;
      case ButtonState.disable:
        return AppColorsPath.gray2;
      case ButtonState.second:
        return AppColorsPath.white;
    }
  }

  Color _getTitleColor() {
    switch (buttonState) {
      case ButtonState.normal:
        return AppColorsPath.white;
      case ButtonState.disable:
        return AppColorsPath.grey;
      case ButtonState.second:
        return AppColorsPath.blue;
    }
  }

  Color _getBorderColor() {
    switch (buttonState) {
      case ButtonState.normal:
        return AppColorsPath.blue;
      case ButtonState.disable:
        return AppColorsPath.gray2;
      case ButtonState.second:
        return AppColorsPath.blue;
    }
  }
}
