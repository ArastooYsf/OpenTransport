import 'package:flutter/material.dart';

/// A small back affordance shown above a step's title, for any step that
/// isn't first. Kept out of the bottom action area on purpose — the bottom
/// is reserved for the single, full-width Continue button.
class StepBackButton extends StatelessWidget {
  const StepBackButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: 4),
      child: IconButton(
        onPressed: onPressed,
        // Icons.arrow_back_rounded has IconData.matchTextDirection set, so
        // it auto-mirrors in RTL and always points toward "back" in
        // reading order — no manual left/right logic needed.
        icon: const Icon(Icons.arrow_back_rounded),
        style: IconButton.styleFrom(
          padding: EdgeInsets.zero,
          alignment: AlignmentDirectional.centerStart,
        ),
      ),
    );
  }
}
