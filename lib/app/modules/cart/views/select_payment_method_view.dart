import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/cart/controllers/cart_controller.dart';
import 'package:get_flutter_fire/app/widgets/cart/payment_selection_card.dart';
import 'package:get_flutter_fire/app/widgets/common/spacing.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';

class SelectPaymentMethodView extends StatelessWidget {
  const SelectPaymentMethodView({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Select Payment", style: AppTheme.fontStyleDefaultBold),
        const SizedBox(height: AppTheme.spacingSmall),
        Obx(
          () => PaymentMethodSelectionCard(
            paymentMethod: "cash",
            selectedPaymentMethod: cartController.selectedPaymentMethod,
            displayText: "Cash On Delivery",
            onChanged: cartController.handlePaymentMethodChange,
            label: "(free)",
          ),
        ),
        const Spacing(size: AppTheme.spacingExtraSmall),
        Obx(
          () => PaymentMethodSelectionCard(
            paymentMethod: "online",
            selectedPaymentMethod: cartController.selectedPaymentMethod,
            displayText: "Pay Online",
            onChanged: cartController.handlePaymentMethodChange,
          ),
        ),
      ],
    );
  }
}
