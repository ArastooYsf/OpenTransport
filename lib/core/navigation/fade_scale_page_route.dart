import 'package:flutter/material.dart';

/// A quick cross-fade + scale transition, per design.md's motion principle
/// that transitions should stay under ~400ms and never feel like the user
/// is waiting.
///
/// Used for the splash → home hand-off so the incoming screen feels like
/// it "opens into" view rather than just cutting or sliding in.
PageRouteBuilder<T> fadeScalePageRoute<T>(Widget page) {
  return PageRouteBuilder<T>(
    transitionDuration: const Duration(milliseconds: 380),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(parent: animation, curve: Curves.easeOut);
      return FadeTransition(
        opacity: curved,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.94, end: 1).animate(curved),
          child: child,
        ),
      );
    },
  );
}
