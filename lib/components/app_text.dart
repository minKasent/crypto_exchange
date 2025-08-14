import 'package:flutter/material.dart';

import 'app_text_style.dart';

class AppText extends StatelessWidget {
  final String content;
  final TextStyle? style;
  final TextAlign? textAlign;
  const AppText({super.key, required this.content, this.style, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: style ?? AppTextStyle.text32SemiBold,
      textAlign: textAlign ?? TextAlign.center,
    );
  }
}
