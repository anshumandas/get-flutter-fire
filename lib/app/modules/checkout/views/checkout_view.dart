import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import '../controllers/checkout_controller.dart';
import '../../cart/controllers/cart_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              TextFormField(
                controller: controller.cardNumberController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(16),
                ],
                decoration: InputDecoration(labelText: 'Card Number'),
                validator: controller.validateCardNumber,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: controller.expiryDateController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(5),
                  ExpiryDateFormatter(), // Apply the updated expiry date formatter
                ],
                decoration: InputDecoration(labelText: 'Expiry Date (MM/YY)'),
                validator: controller.validateExpiryDate,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: controller.cvvController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(3),
                ],
                decoration: InputDecoration(labelText: 'CVV'),
                validator: controller.validateCVV,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: controller.cardHolderNameController,
                decoration: InputDecoration(labelText: 'Card Holder Name'),
                validator: controller.validateCardHolderName,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: controller.addressController,
                decoration: InputDecoration(labelText: 'Address'),
                validator: controller.validateAddress,
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  controller.onCheckoutPressed(cartController.total);
                },
                child: Text('Pay \$${cartController.total.toStringAsFixed(2)}'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
