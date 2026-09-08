import 'package:flutter/material.dart';

import 'animated_clear_icon.dart';

/// A [TextField] with a design.md-standard leading icon (the field's
/// meaning — a person for a name field, an at-sign for email, ...) and a
/// trailing "clear" (X) icon that appears only once the field has text and
/// clears it on tap. [trailingStatus], if given, is shown *before* the
/// clear icon (e.g. the password field's show/hide toggle, or the
/// username field's availability spinner/check/✗).
class ClearableTextField extends StatelessWidget {
  const ClearableTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.leadingIcon,
    this.trailingStatus,
    this.helperText,
    this.helperMaxLines,
    this.errorText,
    this.obscureText = false,
    this.onChanged,
  });

  final TextEditingController controller;
  final String labelText;
  final IconData? leadingIcon;
  final Widget? trailingStatus;
  final String? helperText;
  final int? helperMaxLines;
  final String? errorText;
  final bool obscureText;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        return TextField(
          controller: controller,
          obscureText: obscureText,
          onChanged: onChanged,
          decoration: InputDecoration(
            labelText: labelText,
            helperText: helperText,
            helperMaxLines: helperMaxLines,
            errorText: errorText,
            prefixIcon: leadingIcon == null ? null : Icon(leadingIcon),
            suffixIconConstraints: const BoxConstraints(minWidth: 0),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ?trailingStatus,
                AnimatedClearIcon(
                  visible: value.text.isNotEmpty,
                  // controller.clear() alone doesn't fire onChanged (that
                  // only fires from real typing), so state would go stale
                  // — call it explicitly.
                  onPressed: () {
                    controller.clear();
                    onChanged?.call('');
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
