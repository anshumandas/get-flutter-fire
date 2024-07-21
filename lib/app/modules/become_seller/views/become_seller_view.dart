import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/become_seller/controllers/become_seller_controller.dart';
import 'package:get_flutter_fire/app/routes/app_pages.dart';
import '../../../widgets/screen_widget.dart';

class BecomeSellerView extends GetView<BecomeSellerController> {
  const BecomeSellerView({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenWidget(
      body: Obx(
        () => Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Become Seller View"),
            if (controller.status.value == "waiting")
              Center(
                child: CircularProgressIndicator(),
              ),
            if (controller.status.value == "null")
              ElevatedButton(
                  onPressed: () {
                    controller.addUserRequest();
                  },
                  child: Text("Become Seller Now"))
            else if (controller.status.value == "pending")
              Text("Your request is pending")
            else if (controller.status.value == "rejected")
              Text("Request rejected")
          ],
        )),
      ),
      screen: screen!,
    );
  }
}
