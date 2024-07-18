import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../services/persona_service.dart';
import '../controllers/product_details_controller.dart';

class ProductDetailsView extends GetWidget<ProductDetailsController> {
  const ProductDetailsView({super.key});

  Widget build(BuildContext context) {
    final personaService = Get.find<PersonaService>();
    return Scaffold(
      appBar: AppBar(title: Text('Select Persona')),
      body: ListView.builder(
        itemCount: personaService.personas.length,
        itemBuilder: (context, index) {
          final persona = personaService.personas[index];
          return ListTile(
            title: Text(persona.name),
            onTap: () => personaService.selectPersona(persona),
          );
        },
      ),
    );
  }
}
