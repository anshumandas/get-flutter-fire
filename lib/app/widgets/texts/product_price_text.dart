import 'package:flutter/material.dart';

class SProductPriceText extends StatelessWidget {
  const SProductPriceText({
    super.key,
    this.currencySign = '₹',
    required this.price,
    this.maxLines = 1,
    this.isLarge = false,
    this.lineThrough = false,
  });

  final String currencySign, price;
  final int maxLines;
  final bool isLarge;
  final bool lineThrough;

  @override
  Widget build(BuildContext context) {
    return Text(
      currencySign + price,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: isLarge
        ? Theme.of(context).textTheme.headlineSmall!.apply(decoration: lineThrough ? TextDecoration.lineThrough : null)
        : Theme.of(context).textTheme.headlineSmall!.apply(decoration: lineThrough ? TextDecoration.lineThrough : null),
    );
  }
}
