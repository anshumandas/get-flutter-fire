import 'package:flutter/material.dart';
import 'package:get_flutter_fire/enums/enums.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';

class OrderStatusIndicator extends StatefulWidget {
  final OrderStatus currentStatus;

  const OrderStatusIndicator({super.key, required this.currentStatus});

  @override
  OrderStatusIndicatorState createState() => OrderStatusIndicatorState();
}

class OrderStatusIndicatorState extends State<OrderStatusIndicator>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3200),
      vsync: this,
    )..forward();

    _animations = List.generate(4, (index) {
      final start = index * 0.25;
      final end = start + 0.25;
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(start, end, curve: Curves.easeIn),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _getBarColor(OrderStatus status, int index) {
    if (index <= status.index) {
      return AppTheme.colorMain;
    }
    return AppTheme.greyTextColor;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(4, (index) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: AppTheme.spacingTiny),
            child: AnimatedBuilder(
              animation: _animations[index],
              builder: (context, child) {
                double fillPercentage = (index <= widget.currentStatus.index)
                    ? _animations[index].value
                    : 0.0;
                return Stack(
                  children: [
                    Container(
                      height: 4,
                      decoration: BoxDecoration(
                        borderRadius: AppTheme.borderRadius,
                        color: AppTheme.backgroundColor,
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: fillPercentage,
                      child: Container(
                        height: 4,
                        decoration: BoxDecoration(
                          borderRadius: AppTheme.borderRadius,
                          color: _getBarColor(widget.currentStatus, index),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
