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
  final void Function(bool?)? onChanged;
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
        Text(widget.text),
        Checkbox(
          value: widget.value,
          checkColor: AppColor.secondary,
          onChanged: widget.onChanged
        ),
      ],
    );
  }
}