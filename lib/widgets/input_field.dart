import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String? hintText;
  final String? value;
  final Function(String)? onChanged;
  final bool enabled;
  final bool showClearButton;
  final VoidCallback? onClearPressed;
  final TextInputType keyboardType;
  final int? maxLength;

  const InputField({
    Key? key,
    this.hintText,
    this.value,
    this.onChanged,
    this.enabled = true,
    this.showClearButton = false,
    this.onClearPressed,
    this.keyboardType = TextInputType.text,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: enabled ? Color(0xFF1A1D23) : Color(0xFF252931),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: enabled ? Color(0xFF4B515D) : Color(0xFF4B515D),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              enabled: enabled,
              onChanged: onChanged,
              keyboardType: keyboardType,
              maxLength: maxLength,
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: enabled ? Color(0xFFF6F8FA) : Color(0xFFBDC4D0),
                letterSpacing: -0.8,
                height: 24/16,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6A7180),
                  letterSpacing: -0.8,
                  height: 24/16,
                ),
                counterText: '', // maxLength 카운터 숨기기
              ),
            ),
          ),
          if (showClearButton && value?.isNotEmpty == true) ...[
            SizedBox(width: 10),
            GestureDetector(
              onTap: onClearPressed,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Color(0xFF6A7180),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close,
                  size: 14,
                  color: Color(0xFF1A1D23),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
