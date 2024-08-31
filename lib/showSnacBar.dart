import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showSnacBar(BuildContext context , String text){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        content: Text(
          text,
          style: GoogleFonts.alata(),
        )
    )
  );
}