import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/add_ride_controller.dart';
import '../../../widgets/travel_card.dart';
import '../../../widgets/top_text.dart';
import '../../../widgets/auto_complete_text_field.dart';
import 'package:intl/intl.dart';

class AddRidesView extends GetView<AddRidesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.toggleFormVisibility(),
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                child: TopText(
                  text: 'My Rydes',
                ),
              ),
              Expanded(
                child: Obx(() => ListView.builder(
                  itemCount: controller.myRides.length,
                  itemBuilder: (context, index) {
                    final ride = controller.myRides[index];
                    return TravelCard(
                      ride: ride,
                      onPressed: () => controller.editRide(ride),
                      isEditable: true,
                      isUserRide: true,
                    );
                  },
                )),
              ),
            ],
          ),
          Obx(() => controller.isFormVisible.value
              ? Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 15.0,
                    spreadRadius: 1.0,
                  ),
                ],
              ),
              child: Form(
                key: controller.formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    _buildDateTimeField(context),
                    AutoCompleteTextField(
                      controller: controller.destinationController,
                      labelText: 'Destination',
                      validator: (value) => value!.isEmpty ? 'Please enter destination' : null,
                      places: controller.places,
                      placeRx: controller.destinationPlace,
                      latLngRx: controller.destinationLatLng,
                    ),
                    AutoCompleteTextField(
                      controller: controller.pickupController,
                      labelText: 'Pickup Location',
                      validator: (value) => value!.isEmpty ? 'Please enter pickup location' : null,
                      places: controller.places,
                      placeRx: controller.pickupPlace,
                      latLngRx: controller.pickupLatLng,
                    ),
                    TextFormField(
                      controller: controller.fareController,
                      decoration: const InputDecoration(labelText: 'Fare'),
                      keyboardType: TextInputType.number,
                      validator: (value) => value!.isEmpty ? 'Please enter fare' : null,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: controller.saveRide,
                      child: Text(controller.editingRide.value != null ? 'Update Ride' : 'Save Ride'),
                    ),
                    if (controller.editingRide.value != null)
                      ElevatedButton(
                        onPressed: controller.deleteRide,
                        child: const Text('Delete Ride'),
                      ),
                    ElevatedButton(
                      onPressed: controller.toggleFormVisibility,
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              ),
            ),
          )
              : SizedBox.shrink()
          ),
        ],
      ),
    );
  }

  Widget _buildDateTimeField(BuildContext context) {
    return InkWell(
      onTap: () async {
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        );
        if (pickedDate != null) {
          final TimeOfDay? pickedTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );
          if (pickedTime != null) {
            final DateTime pickedDateTime = DateTime(
              pickedDate.year,
              pickedDate.month,
              pickedDate.day,
              pickedTime.hour,
              pickedTime.minute,
            );
            controller.dateTimeController.text = DateFormat('yyyy-MM-dd HH:mm').format(pickedDateTime);
          }
        }
      },
      child: AbsorbPointer(
        child: TextFormField(
          controller: controller.dateTimeController,
          decoration: const InputDecoration(
            labelText: 'Date and Time',
          ),
          validator: (value) => value!.isEmpty ? 'Please select date and time' : null,
        ),
      ),
    );
  }
}