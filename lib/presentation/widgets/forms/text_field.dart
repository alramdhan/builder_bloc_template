import 'package:flutter/material.dart';

class BuilderTextFormField extends StatefulWidget {
  const BuilderTextFormField({
    super.key,
    required this.controller,
    this.obscureText = false,
    this.hintText
  });

  final TextEditingController controller;
  final bool obscureText;
  final String? hintText;

  @override
  State<BuilderTextFormField> createState() => _BuilderTextFormFieldState();
}

class _BuilderTextFormFieldState extends State<BuilderTextFormField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
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
        color: Colors.blueGrey.shade100,
        borderRadius: const BorderRadius.all(Radius.circular(40))
      ),
      duration: const Duration(milliseconds: 100),
      child: TextFormField(
        controller: widget.controller,
        focusNode: _focusNode,
        onTapOutside: (e) {
          FocusScope.of(context).unfocus();
        },
        obscureText: widget.obscureText,
        cursorColor: Theme.of(context).colorScheme.secondary,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.blueGrey.shade300),
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          filled: false
        ),
      ),
    );
  }
}