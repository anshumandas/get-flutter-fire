import 'package:flutter/widgets.dart';

class Spacing extends StatelessWidget {
  final double size;
  final bool isHorizontal;

  const Spacing({
    super.key,
    required this.size,
    this.isHorizontal = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isHorizontal ? null : size,
      width: isHorizontal ? size : null,
    );
  }
}
