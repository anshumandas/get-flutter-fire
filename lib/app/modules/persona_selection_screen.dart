import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/persona_service.dart';

class PersonaSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final personaService = Get.find<PersonaService>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Select Persona'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 1.2,
        ),
        itemCount: personaService.personas.length,
        itemBuilder: (context, index) {
          final persona = personaService.personas[index];

          return GestureDetector(
            onTap: () {
              personaService.selectPersona(persona);
              Get.back();
            },
            child: Card(
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage(persona.imageUrl),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    persona.name,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
