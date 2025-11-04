import 'package:builder_bloc_template/core/constants/app_color.dart';
import 'package:flutter/material.dart';

class CustomTFField extends StatefulWidget {
  const CustomTFField({
    super.key,
    required this.controller,
    this.obscureText = false,
    this.onFieldSubmitted,
    this.hintText,
  });

  final TextEditingController controller;
  final bool obscureText;
  final String? hintText;
  final void Function(String)? onFieldSubmitted;

  @override
  State<CustomTFField> createState() => _CustomTFFieldState();
}

class _CustomTFFieldState extends State<CustomTFField> {
  late FocusNode _focusNode;
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    // print("focus change ${_focusNode.hasFocus}");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        border: _focusNode.hasFocus
          ? Border.all(width: 0.8, color: Theme.of(context).colorScheme.primary)
          : null,
        color: AppColor.primary100,
        borderRadius: const BorderRadius.all(Radius.circular(50))
      ),
      duration: const Duration(milliseconds: 100),
      child: TextFormField(
        controller: widget.controller,
        focusNode: _focusNode,
        onTapOutside: (e) {
          FocusScope.of(context).unfocus();
        },
        onFieldSubmitted: widget.onFieldSubmitted,
        validator: (value) {
          if(value == null || value.isEmpty) {
            return "Field tidak boleh kosong";
          }

          return null;
        },
        obscureText: _obscureText,
        cursorColor: Theme.of(context).colorScheme.secondary,
        decoration: InputDecoration(
          hintText: widget.hintText,
          suffixIcon: widget.obscureText ? IconButton(
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off)
          ) : null,
        ),
      ),
    );
  }
}