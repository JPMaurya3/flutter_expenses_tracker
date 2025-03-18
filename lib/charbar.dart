import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final double fill;
  const ChartBar({super.key, required this.fill});
  @override
  Widget build(BuildContext context) {
    // checking device is dark mode or not
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return FractionallySizedBox(
      heightFactor: fill,
      child:  DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,  
          borderRadius: const BorderRadius.vertical(),
          color: isDarkMode? Theme.of(context).colorScheme.secondary:Theme.of(context).primaryColor.withOpacity(0.65)
        ),
      ),
    );// A widget that sizes its child to a fraction of the total avaibale space
  }
}
