import 'package:flutter/material.dart';

class Decorations {
// Box Decoration
  static BoxDecoration buildBoxDecoration(
      {required Color gradient1, required Color gradient2}) {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          gradient1,
          gradient2,
        ],
        stops: const [0.5, 0.8],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ),
    );
  }

// Focused Border
  static OutlineInputBorder focusedBorder({required Color borderColor}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: borderColor,
      ),
    );
  }

// Enabled Border
  static OutlineInputBorder enabledBorder({required Color borderColor}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        width: 1.5,
        color: borderColor,
      ),
    );
  }

// Error border
  static OutlineInputBorder errorBorder({required Color borderColor}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        width: 1.5,
        color: borderColor,
      ),
    );
  }

// Focused Error Border
  static OutlineInputBorder focusedErrorBorder({required Color borderColor}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        width: 1,
        color: borderColor,
      ),
    );
  }
}
