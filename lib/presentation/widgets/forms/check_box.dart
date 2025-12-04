import 'package:builder_bloc_template/core/constants/app_color.dart';
import 'package:flutter/material.dart';

class CustomCBWidget extends StatefulWidget {
  const CustomCBWidget({
    super.key,
    required this.text,
    required this.onChanged,
    required this.value,
  });

  final String text;
  final void Function()? onChanged;
  final bool value;

  @override
  State<CustomCBWidget> createState() => _CustomCBWidgetState();
}

class _CustomCBWidgetState extends State<CustomCBWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            widget.onChanged!();
          },
          child: Text(widget.text)
        ),
        Checkbox(
          value: widget.value,
          checkColor: AppColor.tertiary,
          activeColor: AppColor.secondary,
          side: const BorderSide(color: AppColor.tertiary),
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: AppColor.tertiary),
            borderRadius: BorderRadius.circular(4)
          ),
          onChanged: (value) {
            widget.onChanged!();
          }
        ),
      ],
    );
  }
}