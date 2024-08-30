import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';

class AutoCompleteTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?) validator;
  final FlutterGooglePlacesSdk places;
  final Rx<Place?> placeRx;
  final Rx<LatLng?> latLngRx;

  const AutoCompleteTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.validator,
    required this.places,
    required this.placeRx,
    required this.latLngRx,
  }) : super(key: key);

  @override
  AutoCompleteTextFieldState createState() => AutoCompleteTextFieldState();
}

class AutoCompleteTextFieldState extends State<AutoCompleteTextField> {
  final RxList<AutocompletePrediction> _predictions = <AutocompletePrediction>[].obs;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
            labelText: widget.labelText,
          ),
          validator: widget.validator,
          onChanged: (value) async {
            if (value.length < 3) {
              _predictions.clear();
              return;
            }

            FindAutocompletePredictionsResponse response =
            await widget.places.findAutocompletePredictions(value);
            _predictions.value = response.predictions;
          },
        ),
        Obx(() => _predictions.isNotEmpty
            ? SizedBox(
          height: 200,
          child: ListView.builder(
            itemCount: _predictions.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(_predictions[index].primaryText),
                onTap: () async {
                  FetchPlaceResponse fetchPlaceResponse = await widget.places
                      .fetchPlace(_predictions[index].placeId, fields: [
                    PlaceField.Location,
                    PlaceField.Name
                  ]);

                  Place? place = fetchPlaceResponse.place;
                  if (place != null) {
                    widget.controller.text = place.name ?? '';
                    widget.placeRx.value = place;
                    widget.latLngRx.value = place.latLng;
                    _predictions.clear();
                  }
                },
              );
            },
          ),
        )
            : const SizedBox.shrink()
        ),
      ],
    );
  }
}